import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/journal_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.spaceMd),
        children: [
          // Theme Preset Section
          _buildSectionHeader('Appearance'),
          const SizedBox(height: AppConstants.spaceMd),
          _buildThemePresetSelector(),
          const SizedBox(height: AppConstants.spaceLg),

          // Theme Mode Section
          _buildThemeModeSelector(),
          const SizedBox(height: AppConstants.spaceXl),

          // Statistics Section
          _buildSectionHeader('Statistics'),
          const SizedBox(height: AppConstants.spaceMd),
          _buildStatisticsSection(),
          const SizedBox(height: AppConstants.spaceXl),

          // About Section
          _buildSectionHeader('About'),
          const SizedBox(height: AppConstants.spaceMd),
          _buildAboutSection(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildThemePresetSelector() {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme Style',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppConstants.spaceSm),
            Text(
              'Choose your preferred visual style. You can A/B test both!',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: AppConstants.spaceMd),
            Row(
              children: [
                Expanded(
                  child: _buildPresetCard(
                    context,
                    themeProvider,
                    ThemePreset.modernMinimalist,
                    'Modern Minimalist',
                    'Clean, crisp, professional',
                    Icons.grid_view_rounded,
                    AppColors.modernMinimalistLightPrimary,
                  ),
                ),
                const SizedBox(width: AppConstants.spaceMd),
                Expanded(
                  child: _buildPresetCard(
                    context,
                    themeProvider,
                    ThemePreset.calmingZen,
                    'Calming Zen',
                    'Soft, peaceful, therapeutic',
                    Icons.spa_rounded,
                    AppColors.calmingZenLightPrimary,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildPresetCard(
    BuildContext context,
    ThemeProvider themeProvider,
    ThemePreset preset,
    String title,
    String description,
    IconData icon,
    Color accentColor,
  ) {
    final isSelected = themeProvider.themePreset == preset;
    final isDark = themeProvider.isDark(context);

    return InkWell(
      onTap: () async {
        await themeProvider.setThemePreset(preset);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Theme changed to $title'),
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      borderRadius: AppConstants.getBorderRadius('md', preset),
      child: AnimatedContainer(
        duration: AppConstants.animationNormal,
        curve: AppConstants.curveDefault,
        padding: const EdgeInsets.all(AppConstants.spaceMd),
        decoration: BoxDecoration(
          color: isSelected
              ? accentColor.withValues(alpha: isDark ? 0.2 : 0.1)
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: AppConstants.getBorderRadius('md', preset),
          border: Border.all(
            color: isSelected
                ? accentColor
                : Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? accentColor
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 28,
                ),
                const Spacer(),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: accentColor,
                    size: 24,
                  ),
              ],
            ),
            const SizedBox(height: AppConstants.spaceSm),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? accentColor : null,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeModeSelector() {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Color Mode',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppConstants.spaceSm),
            Text(
              'Choose between light, dark, or system theme',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: AppConstants.spaceMd),
            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.light,
                  icon: Icon(Icons.light_mode),
                  label: Text('Light'),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.dark,
                  icon: Icon(Icons.dark_mode),
                  label: Text('Dark'),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.system,
                  icon: Icon(Icons.brightness_auto),
                  label: Text('Auto'),
                ),
              ],
              selected: {themeProvider.themeMode},
              onSelectionChanged: (Set<ThemeMode> selection) {
                themeProvider.setThemeMode(selection.first);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatisticsSection() {
    return Consumer<JournalProvider>(
      builder: (context, journalProvider, child) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spaceMd),
            child: Column(
              children: [
                _buildStatRow(
                  context,
                  'Total Entries',
                  '${journalProvider.totalEntries}',
                  Icons.book,
                ),
                const Divider(),
                _buildStatRow(
                  context,
                  'Favorite Entries',
                  '${journalProvider.favoriteEntriesCount}',
                  Icons.favorite,
                ),
                FutureBuilder<Map<String, dynamic>>(
                  future: journalProvider.getStatistics(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox.shrink();
                    }
                    final stats = snapshot.data!;
                    return Column(
                      children: [
                        const Divider(),
                        _buildStatRow(
                          context,
                          'Avg Words per Entry',
                          '${stats['averageWordsPerEntry']?.round() ?? 0}',
                          Icons.text_fields,
                        ),
                        const Divider(),
                        _buildStatRow(
                          context,
                          'Total Words',
                          '${stats['totalWords'] ?? 0}',
                          Icons.format_size,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.spaceSm),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: AppConstants.spaceMd),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
          subtitle: const Text('Personal Journal v1.0.0'),
          trailing: const Icon(Icons.chevron_right),
          onTap: _showAboutDialog,
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip_outlined),
          title: const Text('Privacy Policy'),
          subtitle: const Text('Your data stays on your device'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Privacy policy coming soon'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.description_outlined),
          title: const Text('Terms of Service'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Terms of service coming soon'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ],
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Personal Journal'),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Version: 1.0.0',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'A beautiful and simple journal app to help you capture your thoughts, memories, and experiences.',
              ),
              SizedBox(height: 16),
              Text(
                'Features:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Create and edit journal entries'),
              Text('• Search and filter entries'),
              Text('• Mood tracking with emojis'),
              Text('• Categories and tags'),
              Text('• Favorite entries'),
              Text('• Dark mode support'),
              Text('• Two beautiful theme presets'),
              Text('• Local-only storage (privacy first)'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
