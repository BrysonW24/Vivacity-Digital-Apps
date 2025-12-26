import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/journal_provider.dart';
import '../models/journal_entry.dart';
import 'entry_editor_screen.dart';
import 'search_screen.dart';
import 'settings_screen.dart';

class EntryDetailScreen extends StatefulWidget {
  final String entryId;

  const EntryDetailScreen({Key? key, required this.entryId}) : super(key: key);

  @override
  State<EntryDetailScreen> createState() => _EntryDetailScreenState();
}

class _EntryDetailScreenState extends State<EntryDetailScreen> {
  late JournalEntry? _entry;
  bool _isLoading = true;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadEntry();
  }

  Future<void> _loadEntry() async {
    setState(() => _isLoading = true);
    final entry = await context.read<JournalProvider>().getEntryById(widget.entryId);
    if (entry != null) {
      setState(() {
        _entry = entry;
        _isFavorite = entry.isFavorite;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
      // Entry not found, show error and go back
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Entry not found')),
        );
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> _toggleFavorite() async {
    if (_entry == null) return;

    final newFavoriteStatus = await context.read<JournalProvider>().toggleFavorite(_entry!.id);
    setState(() => _isFavorite = newFavoriteStatus);
  }

  void _editEntry() {
    if (_entry == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EntryEditorScreen(entry: _entry),
      ),
    ).then((result) {
      if (result == true) {
        // Entry was updated, reload it
        _loadEntry();
      }
    });
  }

  Future<void> _deleteEntry() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Entry'),
        content: const Text('Are you sure you want to delete this entry? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && _entry != null) {
      setState(() => _isLoading = true);
      final success = await context.read<JournalProvider>().deleteEntry(_entry!.id);
      if (success && mounted) {
        Navigator.of(context).pop(true); // Return success to refresh the list
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete entry')),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  void _showMoreOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share Entry'),
            onTap: () {
              Navigator.pop(context);
              _shareEntry();
            },
          ),
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text('Copy to Clipboard'),
            onTap: () {
              Navigator.pop(context);
              _copyToClipboard();
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Delete Entry', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              _deleteEntry();
            },
          ),
        ],
      ),
    );
  }

  void _shareEntry() {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality coming soon!')),
    );
  }

  void _copyToClipboard() {
    // Implement copy to clipboard functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entry Details'),
        actions: [
          IconButton(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
            color: _isFavorite ? Colors.red : null,
            onPressed: _toggleFavorite,
            tooltip: _isFavorite ? 'Remove from favorites' : 'Add to favorites',
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editEntry,
            tooltip: 'Edit entry',
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _showMoreOptions,
            tooltip: 'More options',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _entry == null
              ? const Center(child: Text('Entry not found'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        _entry!.title,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Meta information row
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatDateTime(_entry!.createdAt),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          if (_entry!.updatedAt != _entry!.createdAt) ...[
                            const SizedBox(width: 16),
                            Text(
                              'Updated ${_formatDateTime(_entry!.updatedAt)}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Mood and category row
                      Row(
                        children: [
                          if (_entry!.mood != null) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _entry!.mood!.color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(_entry!.mood!.emoji),
                                  const SizedBox(width: 4),
                                  Text(
                                    _entry!.mood!.displayName,
                                    style: TextStyle(
                                      color: _entry!.mood!.color,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          if (_entry!.categoryId != null &&
                              context.read<JournalProvider>().getCategoryById(_entry!.categoryId!) != null) ...[
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                context.read<JournalProvider>().getCategoryById(_entry!.categoryId!)!.name,
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Tags
                      if (_entry!.tags.isNotEmpty) ...[
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _entry!.tags.map((tagId) {
                            final tag = context.read<JournalProvider>().getTagById(tagId);
                            return tag != null
                                ? Chip(
                                    label: Text(tag.name),
                                    backgroundColor: tag.color.withOpacity(0.1),
                                    labelStyle: TextStyle(color: tag.color),
                                  )
                                : const SizedBox.shrink();
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Content
                      Text(
                        _entry!.content,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Statistics
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatItem(
                              '${_entry!.wordCount}',
                              'Words',
                              Icons.text_fields,
                            ),
                            _buildStatItem(
                              '~${_entry!.readingTimeMinutes}',
                              'Min Read',
                              Icons.access_time,
                            ),
                            _buildStatItem(
                              '${_entry!.content.length}',
                              'Characters',
                              Icons.format_size,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return 'Today at ${_formatTime(dateTime)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday at ${_formatTime(dateTime)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago at ${_formatTime(dateTime)}';
    } else {
      return '${dateTime.month}/${dateTime.day}/${dateTime.year} at ${_formatTime(dateTime)}';
    }
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : (dateTime.hour == 0 ? 12 : dateTime.hour);
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${dateTime.minute.toString().padLeft(2, '0')} $period';
  }
}