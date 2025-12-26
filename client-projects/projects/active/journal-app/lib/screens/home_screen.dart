import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/journal_provider.dart';
import '../providers/theme_provider.dart';
import '../models/journal_entry.dart';
import '../constants/app_constants.dart';
import '../constants/app_colors.dart';
import '../utils/date_formatter.dart';
import 'entry_editor_screen.dart';
import 'entry_detail_screen.dart';
import 'search_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // 4 tabs with Table view
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Journal',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchScreen()),
            ),
            tooltip: 'Search',
          ),
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
            tooltip: 'Settings',
          ),
          const SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 13,
          ),
          tabs: const [
            Tab(
              icon: Icon(Icons.view_list_rounded, size: 20),
              text: 'Table',
            ),
            Tab(
              icon: Icon(Icons.history_rounded, size: 20),
              text: 'Recent',
            ),
            Tab(
              icon: Icon(Icons.favorite_rounded, size: 20),
              text: 'Favorites',
            ),
            Tab(
              icon: Icon(Icons.calendar_today_rounded, size: 20),
              text: 'Calendar',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTableView(context), // NEW: Table view first
          _buildEntriesList(context, showFavorites: false),
          _buildEntriesList(context, showFavorites: true),
          _buildCalendarView(context),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createNewEntry(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Entry'),
        elevation: 4,
      ),
    );
  }

  // NEW: Table View with all entry details
  Widget _buildTableView(BuildContext context) {
    return Consumer<JournalProvider>(
      builder: (context, journalProvider, child) {
        if (journalProvider.isLoading && journalProvider.entries.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final entries = journalProvider.entries;

        if (entries.isEmpty) {
          return _buildEmptyState(context, false);
        }

        return RefreshIndicator(
          onRefresh: () => journalProvider.loadEntries(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.spaceMd),
                  child: SizedBox(
                    width: constraints.maxWidth - (AppConstants.spaceMd * 2),
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
                      ),
                      headingTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      dataRowMinHeight: 60,
                      dataRowMaxHeight: 80,
                      columnSpacing: 24,
                      horizontalMargin: 16,
                  columns: const [
                    DataColumn(
                      label: Text('Title'),
                      tooltip: 'Entry title',
                    ),
                    DataColumn(
                      label: Text('Mood'),
                      tooltip: 'How you felt',
                    ),
                    DataColumn(
                      label: Text('Created'),
                      tooltip: 'Date created',
                    ),
                    DataColumn(
                      label: Text('Updated'),
                      tooltip: 'Last modified',
                    ),
                    DataColumn(
                      label: Text('Words'),
                      numeric: true,
                      tooltip: 'Word count',
                    ),
                    DataColumn(
                      label: Text('Favorite'),
                      tooltip: 'Favorited',
                    ),
                  ],
                  rows: entries.map((entry) {
                    return DataRow(
                      onSelectChanged: (_) => _openEntryDetail(context, entry),
                      cells: [
                        // Title
                        DataCell(
                          SizedBox(
                            width: 200,
                            child: Text(
                              entry.title,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        // Mood
                        DataCell(
                          entry.mood != null
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: AppColors.getMoodGradient(
                                      entry.mood!.name,
                                      context.read<ThemeProvider>().themePreset,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        entry.mood!.emoji,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        entry.mood!.displayName,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const Text('-'),
                        ),
                        // Created date
                        DataCell(
                          Text(
                            DateFormatter.shortDate(entry.createdAt),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        // Updated date
                        DataCell(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormatter.shortDate(entry.updatedAt),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                DateFormatter.timeAgo(entry.updatedAt),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                      fontSize: 11,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        // Word count
                        DataCell(
                          Text(
                            '${entry.wordCount}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        // Favorite
                        DataCell(
                          IconButton(
                            icon: entry.isFavorite
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red.shade400,
                                    size: 20,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    size: 20,
                                  ),
                            onPressed: () async {
                              await journalProvider.toggleFavorite(entry.id);
                            },
                            tooltip: entry.isFavorite ? 'Remove from favorites' : 'Add to favorites',
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildEntriesList(BuildContext context, {required bool showFavorites}) {
    return Consumer<JournalProvider>(
      builder: (context, journalProvider, child) {
        if (journalProvider.isLoading && journalProvider.entries.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final entries = showFavorites
            ? journalProvider.favoriteEntries
            : journalProvider.entries;

        if (entries.isEmpty) {
          return _buildEmptyState(
            context,
            showFavorites,
          );
        }

        return RefreshIndicator(
          onRefresh: () => journalProvider.loadEntries(),
          child: ListView.builder(
            padding: const EdgeInsets.all(AppConstants.spaceMd),
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return _buildGorgeousEntryCard(context, entry);
            },
          ),
        );
      },
    );
  }

  Widget _buildCalendarView(BuildContext context) {
    return Consumer<JournalProvider>(
      builder: (context, journalProvider, child) {
        // Use entries directly from provider instead of FutureBuilder
        if (journalProvider.isLoading && journalProvider.entries.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (journalProvider.entries.isEmpty) {
          return _buildEmptyState(context, false, isCalendar: true);
        }

        // Group entries by date locally
        final entriesByDate = <DateTime, List<JournalEntry>>{};
        for (final entry in journalProvider.entries) {
          final date = DateTime(
            entry.createdAt.year,
            entry.createdAt.month,
            entry.createdAt.day,
          );
          entriesByDate.putIfAbsent(date, () => []).add(entry);
        }

        final dates = entriesByDate.keys.toList()
          ..sort((a, b) => b.compareTo(a));

        return RefreshIndicator(
          onRefresh: () => journalProvider.loadEntries(),
          child: ListView.builder(
            padding: const EdgeInsets.all(AppConstants.spaceMd),
            itemCount: dates.length,
            itemBuilder: (context, index) {
              final date = dates[index];
              final dayEntries = entriesByDate[date]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppConstants.spaceMd,
                      bottom: AppConstants.spaceSm,
                    ),
                    child: _buildDateHeader(context, date),
                  ),
                  ...dayEntries.map(
                    (entry) => _buildGorgeousEntryCard(context, entry),
                  ),
                  const SizedBox(height: AppConstants.spaceSm),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDateHeader(BuildContext context, DateTime date) {
    final isToday = DateFormatter.isToday(date);
    final isYesterday = DateFormatter.isYesterday(date);

    String dateText;
    if (isToday) {
      dateText = 'Today';
    } else if (isYesterday) {
      dateText = 'Yesterday';
    } else {
      dateText = DateFormatter.fullDate(date);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceMd,
        vertical: AppConstants.spaceSm,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: AppConstants.getBorderRadius(
          'md',
          context.read<ThemeProvider>().themePreset,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today_rounded,
            size: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(
            dateText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildGorgeousEntryCard(BuildContext context, JournalEntry entry) {
    final themeProvider = context.read<ThemeProvider>();
    final isDark = themeProvider.isDark(context);

    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.spaceMd),
      elevation: isDark ? 2 : 1,
      shadowColor: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: AppConstants.getBorderRadius('md', themeProvider.themePreset),
      ),
      child: InkWell(
        onTap: () => _openEntryDetail(context, entry),
        borderRadius: AppConstants.getBorderRadius('md', themeProvider.themePreset),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spaceMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      entry.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (entry.mood != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppColors.getMoodGradient(
                          entry.mood!.name,
                          themeProvider.themePreset,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        entry.mood!.emoji,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  if (entry.isFavorite)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red.shade400,
                        size: 20,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppConstants.spaceSm),
              Text(
                entry.contentPreview,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.7),
                      height: 1.5,
                    ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppConstants.spaceMd),
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    DateFormatter.timeAgo(entry.createdAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 12,
                        ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.article_rounded,
                    size: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${entry.wordCount} words',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 12,
                        ),
                  ),
                  const Spacer(),
                  if (entry.readingTimeMinutes > 0) ...[
                    Icon(
                      Icons.schedule_rounded,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${entry.readingTimeMinutes} min read',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    bool showFavorites, {
    bool isCalendar = false,
  }) {
    IconData icon;
    String title;
    String subtitle;

    if (isCalendar) {
      icon = Icons.calendar_today_rounded;
      title = 'No Entries Yet';
      subtitle = 'Start journaling to see your entries organized by date';
    } else if (showFavorites) {
      icon = Icons.favorite_border_rounded;
      title = 'No Favorites Yet';
      subtitle = 'Mark entries as favorite by tapping the ♡ icon';
    } else {
      icon = Icons.book_rounded;
      title = 'Begin Your Journey';
      subtitle = 'Tap the button below to write your first journal entry';
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spaceXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 80,
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            if (!showFavorites && !isCalendar) ...[
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () => _createNewEntry(context),
                icon: const Icon(Icons.add_rounded),
                label: const Text('Write First Entry'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spaceXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () => setState(() {}),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createNewEntry(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EntryEditorScreen()),
    );

    if (result == true && mounted) {
      // Force refresh the entries list
      final provider = context.read<JournalProvider>();
      await provider.loadEntries();
      setState(() {
        // Force rebuild to show new entry
      });
    }
  }

  Future<void> _openEntryDetail(BuildContext context, JournalEntry entry) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EntryDetailScreen(entryId: entry.id),
      ),
    );

    if (result == true && mounted) {
      // Force refresh the entries list
      final provider = context.read<JournalProvider>();
      await provider.loadEntries();
      setState(() {
        // Force rebuild to show updated entry
      });
    }
  }
}
