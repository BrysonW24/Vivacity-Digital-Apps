import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/journal_provider.dart';
import '../providers/theme_provider.dart';
import '../models/journal_entry.dart';
import '../constants/app_constants.dart';

class EntryEditorScreen extends StatefulWidget {
  final JournalEntry? entry;

  const EntryEditorScreen({super.key, this.entry});

  @override
  State<EntryEditorScreen> createState() => _EntryEditorScreenState();
}

class _EntryEditorScreenState extends State<EntryEditorScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _titleFocusNode = FocusNode();
  final _contentFocusNode = FocusNode();

  Mood? _selectedMood;
  String? _selectedCategoryId;
  final List<String> _selectedTags = [];
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    // If editing existing entry, populate fields
    if (widget.entry != null) {
      _titleController.text = widget.entry!.title;
      _contentController.text = widget.entry!.content;
      _selectedMood = widget.entry!.mood;
      _selectedCategoryId = widget.entry!.categoryId;
      _selectedTags.addAll(widget.entry!.tags);
    }

    // Listen for text changes to update word count
    _contentController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _titleFocusNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.entry != null;
    final themeProvider = context.watch<ThemeProvider>();
    final wordCount = _contentController.text
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Entry' : 'New Entry'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _confirmDiscard(),
        ),
        actions: [
          // Word count indicator - WHITE text for visibility
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '$wordCount words',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Mood selector bar - BIGGER EMOJIS
              _buildMoodBar(themeProvider),

              // Main content area
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppConstants.spaceLg), // More padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title field - MORE PADDING
                      TextField(
                        controller: _titleController,
                        focusNode: _titleFocusNode,
                        decoration: InputDecoration(
                          hintText: 'Entry Title',
                          hintStyle:
                              Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant
                                        .withValues(alpha: 0.5),
                                  ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, // Added vertical padding
                            horizontal: 4,
                          ),
                        ),
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                        maxLines: 2,
                        textCapitalization: TextCapitalization.words,
                      ),

                      const SizedBox(height: AppConstants.spaceSm),

                      // Date/time
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatDateTime(widget.entry?.createdAt ?? DateTime.now()),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),

                      const Divider(height: 32),

                      // Content field - MORE PADDING
                      TextField(
                        controller: _contentController,
                        focusNode: _contentFocusNode,
                        decoration: InputDecoration(
                          hintText:
                              'Write your thoughts here...\n\nWhat happened today? How do you feel?',
                          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant
                                    .withValues(alpha: 0.5),
                                height: 1.6,
                              ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, // Added vertical padding
                            horizontal: 4,
                          ),
                        ),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              height: 1.6,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                        maxLines: null,
                        minLines: 12,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                      ),

                      // Extra space at bottom for comfortable typing
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Floating toolbar at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomToolbar(context),
          ),
        ],
      ),

      // Prominent save button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isSaving ? null : _saveEntry,
        icon: _isSaving
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Icon(Icons.check),
        label: Text(_isSaving ? 'Saving...' : 'Save Entry'),
        elevation: 4,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildMoodBar(ThemeProvider themeProvider) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceMd,
        vertical: AppConstants.spaceMd, // More padding
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(
            color:
                Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How are you feeling?',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppConstants.spaceSm),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: Mood.values.map((mood) {
                final isSelected = _selectedMood == mood;
                return Padding(
                  padding: const EdgeInsets.only(right: AppConstants.spaceSm),
                  child: _buildMoodChip(mood, isSelected, themeProvider),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodChip(
      Mood mood, bool isSelected, ThemeProvider themeProvider) {
    return Tooltip(
      message: mood.displayName,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedMood = _selectedMood == mood ? null : mood;
          });
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              mood.emoji,
              style: const TextStyle(fontSize: 36),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomToolbar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spaceMd),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color:
                Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildToolbarButton(
              icon: Icons.format_bold,
              label: 'Bold',
              onTap: () => _insertMarkdown('**', '**'),
            ),
            _buildToolbarButton(
              icon: Icons.format_italic,
              label: 'Italic',
              onTap: () => _insertMarkdown('_', '_'),
            ),
            _buildToolbarButton(
              icon: Icons.format_list_bulleted,
              label: 'List',
              onTap: () => _insertMarkdown('- ', ''),
            ),
            _buildToolbarButton(
              icon: Icons.title,
              label: 'Heading',
              onTap: () => _insertMarkdown('## ', ''),
            ),
            _buildToolbarButton(
              icon: Icons.format_quote,
              label: 'Quote',
              onTap: () => _insertMarkdown('> ', ''),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbarButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _insertMarkdown(String before, String after) {
    final text = _contentController.text;
    final selection = _contentController.selection;

    if (selection.start == -1) {
      // No selection, insert at end
      _contentController.text = text + before + after;
      _contentController.selection = TextSelection.collapsed(
        offset: text.length + before.length,
      );
    } else {
      // Wrap selection
      final selectedText = text.substring(selection.start, selection.end);
      final newText = text.replaceRange(
        selection.start,
        selection.end,
        before + selectedText + after,
      );
      _contentController.text = newText;
      _contentController.selection = TextSelection.collapsed(
        offset: selection.start + before.length + selectedText.length,
      );
    }

    _contentFocusNode.requestFocus();
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final entryDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (entryDate == today) {
      return 'Today at ${_formatTime(dateTime)}';
    } else {
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year} at ${_formatTime(dateTime)}';
    }
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12
        ? dateTime.hour - 12
        : (dateTime.hour == 0 ? 12 : dateTime.hour);
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  Future<void> _confirmDiscard() async {
    // Check if there are unsaved changes
    final hasChanges = _titleController.text.trim().isNotEmpty ||
        _contentController.text.trim().isNotEmpty;

    if (!hasChanges) {
      Navigator.of(context).pop(false);
      return;
    }

    final shouldDiscard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Discard changes?'),
        content: const Text(
            'You have unsaved changes. Are you sure you want to discard them?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Discard'),
          ),
        ],
      ),
    );

    if (shouldDiscard == true && mounted) {
      Navigator.of(context).pop(false);
    }
  }

  Future<void> _saveEntry() async {
    // Validation
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add a title to your entry'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.orange,
        ),
      );
      _titleFocusNode.requestFocus();
      return;
    }

    if (_contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write something in your entry'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.orange,
        ),
      );
      _contentFocusNode.requestFocus();
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final journalProvider = context.read<JournalProvider>();

      // Create entry with all fields
      final entry = JournalEntry(
        id: widget.entry?.id,
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        mood: _selectedMood,
        categoryId: _selectedCategoryId,
        tags: _selectedTags,
        isFavorite: widget.entry?.isFavorite ?? false,
        createdAt: widget.entry?.createdAt,
        updatedAt: DateTime.now(),
      );

      // Save to database
      String? result;
      if (widget.entry == null) {
        result = await journalProvider.createEntry(entry);
        print('✅ Entry created: ${entry.id} - Result: $result');
        print('📊 Total entries after create: ${journalProvider.entries.length}');
      } else {
        await journalProvider.updateEntry(entry);
        print('✅ Entry updated: ${entry.id}');
        print('📊 Total entries after update: ${journalProvider.entries.length}');
      }

      // Reload all entries to ensure UI updates
      await journalProvider.loadEntries();
      print('📊 Total entries after reload: ${journalProvider.entries.length}');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 8),
                Text(widget.entry == null ? 'Entry created!' : 'Entry updated!'),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        // Navigate back with true to indicate success
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      print('❌ Save error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(child: Text('Failed to save: $e')),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).colorScheme.error,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }
}
