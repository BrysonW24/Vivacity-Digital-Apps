import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_sizes.dart';
import '../config/app_colors.dart';
import '../config/app_strings.dart';
import '../models/venue_feature_model.dart';
import '../providers/venue_feature_provider.dart';

class FeatureFilterSheet extends StatefulWidget {
  final VoidCallback onApply;

  const FeatureFilterSheet({
    required this.onApply,
    Key? key,
  }) : super(key: key);

  @override
  State<FeatureFilterSheet> createState() => _FeatureFilterSheetState();
}

class _FeatureFilterSheetState extends State<FeatureFilterSheet> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VenueFeatureProvider>(
      builder: (context, featureProvider, _) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSizes.radiusLarge),
            ),
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(AppSizes.paddingMedium),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filter by Features',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(),

              // Tab/Category selector
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMedium,
                ),
                child: SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _CategoryTab(
                        label: 'Entertainment',
                        icon: '🎮',
                        isSelected: _currentPage == 0,
                        onTap: () {
                          _pageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                      _CategoryTab(
                        label: 'Dining',
                        icon: '🍽️',
                        isSelected: _currentPage == 1,
                        onTap: () {
                          _pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                      _CategoryTab(
                        label: 'Atmosphere',
                        icon: '🪑',
                        isSelected: _currentPage == 2,
                        onTap: () {
                          _pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                      _CategoryTab(
                        label: 'Tech',
                        icon: '📱',
                        isSelected: _currentPage == 3,
                        onTap: () {
                          _pageController.animateToPage(
                            3,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                      _CategoryTab(
                        label: 'Events',
                        icon: '🎪',
                        isSelected: _currentPage == 4,
                        onTap: () {
                          _pageController.animateToPage(
                            4,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                      _CategoryTab(
                        label: 'Accessibility',
                        icon: '♿',
                        isSelected: _currentPage == 5,
                        onTap: () {
                          _pageController.animateToPage(
                            5,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Feature list by category
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  children: [
                    // Entertainment
                    _buildFeatureCategory(
                      context,
                      'Entertainment & Games',
                      [
                        CommonFeatures.poolTable,
                        CommonFeatures.darts,
                        CommonFeatures.sportsBar,
                        CommonFeatures.karaoke,
                        CommonFeatures.triviaQuiz,
                        CommonFeatures.boardGames,
                        CommonFeatures.tableFootball,
                        CommonFeatures.dartLeague,
                      ],
                      featureProvider,
                    ),
                    // Dining
                    _buildFeatureCategory(
                      context,
                      'Dining & Beverages',
                      [
                        CommonFeatures.foodService,
                        CommonFeatures.happyHour,
                        CommonFeatures.craftBeer,
                        CommonFeatures.cocktails,
                        CommonFeatures.sundayRoast,
                      ],
                      featureProvider,
                    ),
                    // Atmosphere
                    _buildFeatureCategory(
                      context,
                      'Atmosphere & Seating',
                      [
                        CommonFeatures.outdoorSeating,
                        CommonFeatures.garden,
                        CommonFeatures.rooftop,
                        CommonFeatures.familyFriendly,
                        CommonFeatures.petFriendly,
                      ],
                      featureProvider,
                    ),
                    // Technology
                    _buildFeatureCategory(
                      context,
                      'Technology',
                      [
                        CommonFeatures.freeWifi,
                        CommonFeatures.chargingStations,
                        CommonFeatures.liveStreaming,
                      ],
                      featureProvider,
                    ),
                    // Events
                    _buildFeatureCategory(
                      context,
                      'Events & Entertainment',
                      [
                        CommonFeatures.liveMusic,
                        CommonFeatures.liveJazz,
                        CommonFeatures.liveBands,
                        CommonFeatures.djMusic,
                        CommonFeatures.comedyNights,
                        CommonFeatures.openMic,
                        CommonFeatures.privateFunction,
                      ],
                      featureProvider,
                    ),
                    // Accessibility
                    _buildFeatureCategory(
                      context,
                      'Accessibility & Comfort',
                      [
                        CommonFeatures.parkingAvailable,
                        CommonFeatures.wheelchairAccessible,
                        CommonFeatures.lateeLicense,
                        CommonFeatures.studentDiscount,
                      ],
                      featureProvider,
                    ),
                  ],
                ),
              ),

              // Selected filters display
              if (featureProvider.selectedFeatures.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selected:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppSizes.paddingSmall),
                      Wrap(
                        spacing: AppSizes.paddingSmall,
                        runSpacing: AppSizes.paddingSmall,
                        children: featureProvider.selectedFeatures
                            .map(
                              (feature) => Chip(
                                label: Text(feature),
                                onDeleted: () {
                                  featureProvider.toggleFeature(feature);
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),

              // Actions
              Padding(
                padding: const EdgeInsets.all(AppSizes.paddingMedium),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          featureProvider.clearAllFilters();
                        },
                        child: const Text('Clear All'),
                      ),
                    ),
                    const SizedBox(width: AppSizes.paddingMedium),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          widget.onApply();
                          Navigator.pop(context);
                        },
                        child: const Text(AppStrings.filterBy),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeatureCategory(
    BuildContext context,
    String title,
    List<String> features,
    VenueFeatureProvider featureProvider,
  ) {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.paddingMedium),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...features.map((feature) {
          final isSelected = featureProvider.selectedFeatures.contains(feature);
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.paddingSmall),
            child: CheckboxListTile(
              value: isSelected,
              onChanged: (value) {
                featureProvider.toggleFeature(feature);
              },
              title: Text(feature),
              activeColor: Theme.of(context).primaryColor,
            ),
          );
        }).toList(),
      ],
    );
  }
}

class _CategoryTab extends StatelessWidget {
  final String label;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryTab({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.paddingSmall),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMedium,
            vertical: AppSizes.paddingSmall,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).primaryColor
                : AppColors.surface,
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : AppColors.outline,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(icon, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: AppSizes.paddingSmall),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
