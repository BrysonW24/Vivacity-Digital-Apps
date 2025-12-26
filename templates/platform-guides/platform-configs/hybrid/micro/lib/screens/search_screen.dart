import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/journal_provider.dart';
import '../models/journal_entry.dart';
import 'entry_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategoryId;
  List<String> _selectedTagIds = [];
  Mood? _selectedMood;
  bool? _isFavorite;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    // Clear filters when leaving search screen
    final provider = context.read<JournalProvider>();
    provider.loadEntries();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
    _performSearch();
  }

  Future<void> _performSearch() async {
    final provider = context.read<JournalProvider>();
    await provider.loadEntries(
      searchQuery: _searchQuery.isEmpty ? null : _searchQuery,
      categoryId: _selectedCategoryId,
      tagIds: _selectedTagIds.isEmpty ? null : _selectedTagIds,
      mood: _selectedMood,
      isFavorite: _isFavorite,
      startDate: _startDate,
      endDate: _endDate,
      sortBy: 'created_at',
      ascending: false,
    );
  }

  void _clearFilters() {
    setState(() {
      _selectedCategoryId = null;
      _selectedTagIds.clear();
      _selectedMood = null;
      _isFavorite = null;
      _startDate = null;
      _endDate = null;
      _searchController.clear();
    });
    _performSearch();
  }

  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      _performSearch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Entries'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by title, content, or tags...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => _searchController.clear(),
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _getActiveFiltersText(),
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => setState(() => _showFilters = !_showFilters),
                      icon: Icon(_showFilters ? Icons.filter_list_off : Icons.filter_list),
                      label: Text(_showFilters ? 'Hide Filters' : 'Show Filters'),
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          if (_showFilters) _buildFiltersPanel(),
          Expanded(child: _buildSearchResults()),
        ],
      ),
    );
  }

  Widget _buildFiltersPanel() {
    return Consumer<JournalProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border(
              bottom: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Filters',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _clearFilters,
                    child: const Text('Clear All'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  // Category filter
                  _buildFilterChip(
                    label: _selectedCategoryId != null
                        ? provider.getCategoryById(_selectedCategoryId!)?.name ?? 'Category'
                        : 'Category',
                    icon: Icons.category,
                    onTap: () => _showCategoryPicker(provider.categories),
                  ),

                  // Mood filter
                  _buildFilterChip(
                    label: _selectedMood?.displayName ?? 'Mood',
                    icon: Icons.sentiment_satisfied,
                    onTap: () => _showMoodPicker(),
                  ),

                  // Tags filter
                  _buildFilterChip(
                    label: _selectedTagIds.isEmpty
                        ? 'Tags'
                        : '${_selectedTagIds.length} selected',
                    icon: Icons.tag,
                    onTap: () => _showTagsPicker(provider.tags),
                  ),

                  // Date range filter
                  _buildFilterChip(
                    label: _startDate != null && _endDate != null
                        ? '${_formatDate(_startDate!)} - ${_formatDate(_endDate!)}'
                        : 'Date Range',
                    icon: Icons.date_range,
                    onTap: _selectDateRange,
                  ),

                  // Favorite filter
                  FilterChip(
                    label: const Text('Favorites Only'),
                    selected: _isFavorite == true,
                    onSelected: (selected) {
                      setState(() => _isFavorite = selected ? true : null);
                      _performSearch();
                    },
                    backgroundColor: Colors.transparent,
                    selectedColor: Colors.red.shade100,
                    checkmarkColor: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final isActive = label != 'Category' && label != 'Mood' && label != 'Tags' && label != 'Date Range';

    return ActionChip(
      label: Text(label),
      avatar: Icon(icon, size: 18),
      onPressed: onTap,
      backgroundColor: isActive
          ? Theme.of(context).colorScheme.primaryContainer
          : null,
      labelStyle: TextStyle(
        color: isActive
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : null,
      ),
    );
  }

  Widget _buildSearchResults() {
    return Consumer<JournalProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: ${provider.error}'),
                TextButton(
                  onPressed: _performSearch,
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        final entries = provider.entries;

        if (entries.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 64,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(height: 16),
                Text(
                  _searchQuery.isEmpty && !_hasActiveFilters()
                      ? 'Start typing to search your entries'
                      : 'No entries found matching your search',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final entry = entries[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EntryDetailScreen(entryId: entry.id),
                  ),
                ),
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              entry.title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (entry.isFavorite)
                            const Icon(Icons.favorite, color: Colors.red, size: 20),
                          if (entry.mood != null)
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: entry.mood!.color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                entry.mood!.emoji,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        entry.contentPreview,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatTimeAgo(entry.createdAt),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${entry.wordCount} words',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  bool _hasActiveFilters() {
    return _selectedCategoryId != null ||
           _selectedTagIds.isNotEmpty ||
           _selectedMood != null ||
           _isFavorite != null ||
           _startDate != null ||
           _endDate != null;
  }

  String _getActiveFiltersText() {
    final filters = <String>[];
    if (_selectedCategoryId != null) filters.add('Category');
    if (_selectedTagIds.isNotEmpty) filters.add('Tags (${_selectedTagIds.length})');
    if (_selectedMood != null) filters.add('Mood');
    if (_isFavorite == true) filters.add('Favorites');
    if (_startDate != null && _endDate != null) filters.add('Date Range');

    return filters.isEmpty ? 'No active filters' : 'Active: ${filters.join(', ')}';
  }

  void _showCategoryPicker(List<Category> categories) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Category',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('All Categories'),
                  selected: _selectedCategoryId == null,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedCategoryId = null);
                      _performSearch();
                      Navigator.pop(context);
                    }
                  },
                ),
                ...categories.map((category) {
                  return ChoiceChip(
                    label: Text(category.name),
                    selected: _selectedCategoryId == category.id,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedCategoryId = category.id);
                        _performSearch();
                        Navigator.pop(context);
                      }
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMoodPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Mood',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('All Moods'),
                  selected: _selectedMood == null,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedMood = null);
                      _performSearch();
                      Navigator.pop(context);
                    }
                  },
                ),
                ...Mood.values.map((mood) {
                  return ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(mood.emoji),
                        const SizedBox(width: 4),
                        Text(mood.displayName),
                      ],
                    ),
                    selected: _selectedMood == mood,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedMood = mood);
                        _performSearch();
                        Navigator.pop(context);
                      }
                    },
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTagsPicker(List<Tag> availableTags) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Select Tags',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() => _selectedTagIds.clear());
                    _performSearch();
                    Navigator.pop(context);
                  },
                  child: const Text('Clear All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: availableTags.map((tag) {
                  final isSelected = _selectedTagIds.contains(tag.id);
                  return CheckboxListTile(
                    title: Text(tag.name),
                    value: isSelected,
                    onChanged: (selected) {
                      setState(() {
                        if (selected == true) {
                          _selectedTagIds.add(tag.id);
                        } else {
                          _selectedTagIds.remove(tag.id);
                        }
                      });
                      _performSearch();
                    },
                    secondary: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: tag.color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}