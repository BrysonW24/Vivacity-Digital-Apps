import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_sizes.dart';
import '../../config/app_strings.dart';
import '../../enums/loading_status.dart';
import '../../models/venue_model.dart';
import '../../providers/venue_provider.dart';
import '../../providers/venue_feature_provider.dart';
import '../../services/geolocation_service.dart';
import '../../widgets/feature_filter_sheet.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final GeolocationService _geolocationService = GeolocationService();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNearbyVenues();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadNearbyVenues() async {
    try {
      final position = await _geolocationService.getCurrentLocation();
      if (mounted) {
        context.read<VenueProvider>().fetchNearbyVenues(
          latitude: position.latitude,
          longitude: position.longitude,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.discoverPubs),
        elevation: 0,
      ),
      body: Consumer<VenueProvider>(
        builder: (context, venueProvider, _) {
          return Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(AppSizes.paddingMedium),
                child: TextField(
                  controller: _searchController,
                  onChanged: (query) {
                    venueProvider.searchVenues(query);
                  },
                  decoration: InputDecoration(
                    hintText: AppStrings.search,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        venueProvider.searchVenues('');
                      },
                    )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                    ),
                  ),
                ),
              ),

              // Filter chips and actions
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMedium,
                ),
                child: Consumer<VenueFeatureProvider>(
                  builder: (context, featureProvider, _) {
                    return Row(
                      children: [
                        // Distance filter
                        FilterChip(
                          label: const Text(AppStrings.filterBy),
                          onSelected: (selected) {
                            _showFilterDialog(context, venueProvider);
                          },
                        ),
                        const SizedBox(width: AppSizes.paddingSmall),

                        // Feature filter button
                        ActionChip(
                          label: const Text('🎯 Features'),
                          onPressed: () {
                            _showFeatureFilterSheet(context);
                          },
                        ),
                        const SizedBox(width: AppSizes.paddingSmall),

                        // Selected category filters
                        if (venueProvider.selectedCategories.isNotEmpty)
                          for (String category in venueProvider.selectedCategories)
                            Padding(
                              padding: const EdgeInsets.only(
                                right: AppSizes.paddingSmall,
                              ),
                              child: Chip(
                                label: Text(category),
                                onDeleted: () {
                                  venueProvider.removeCategoryFilter(category);
                                },
                              ),
                            ),

                        // Selected feature filters
                        if (featureProvider.selectedFeatures.isNotEmpty)
                          for (String feature in featureProvider.selectedFeatures)
                            Padding(
                              padding: const EdgeInsets.only(
                                right: AppSizes.paddingSmall,
                              ),
                              child: Chip(
                                label: Text(feature),
                                onDeleted: () {
                                  featureProvider.toggleFeature(feature);
                                },
                              ),
                            ),
                      ],
                    );
                  },
                ),
              ),

              // Venues list
              Expanded(
                child: _buildVenuesList(venueProvider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildVenuesList(VenueProvider venueProvider) {
    if (venueProvider.status == LoadingStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (venueProvider.status == LoadingStatus.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(venueProvider.errorMessage),
            const SizedBox(height: AppSizes.paddingMedium),
            ElevatedButton(
              onPressed: _loadNearbyVenues,
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      );
    }

    final venues = venueProvider.venues;

    if (venues.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.location_off, size: 48),
            SizedBox(height: AppSizes.paddingMedium),
            Text(AppStrings.noPubsNearby),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: venues.length,
      itemBuilder: (context, index) {
        return _VenueCard(
          venue: venues[index],
          onTap: () {
            venueProvider.selectVenue(venues[index]);
            // Navigate to venue details
            Navigator.of(context).pushNamed(
              '/venue-details',
              arguments: venues[index],
            );
          },
        );
      },
    );
  }

  void _showFilterDialog(BuildContext context, VenueProvider venueProvider) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSizes.paddingMedium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Distance Filter',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSizes.paddingMedium),
            Slider(
              value: venueProvider.maxDistance,
              min: 0.5,
              max: 20,
              divisions: 39,
              label: '${venueProvider.maxDistance.toStringAsFixed(1)} km',
              onChanged: (value) {
                venueProvider.setDistanceFilter(value);
              },
            ),
            const SizedBox(height: AppSizes.paddingMedium),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }

  void _showFeatureFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusLarge),
        ),
      ),
      builder: (context) => FeatureFilterSheet(
        onApply: () {
          // Filtering is automatic via Consumer rebuild
        },
      ),
    );
  }
}

class _VenueCard extends StatelessWidget {
  final VenueModel venue;
  final VoidCallback onTap;

  const _VenueCard({
    required this.venue,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMedium,
          vertical: AppSizes.paddingSmall,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppSizes.radiusMedium),
              ),
              child: Image.network(
                venue.imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    color: AppColors.surface,
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    venue.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.paddingSmall),
                  // Address
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16),
                      const SizedBox(width: AppSizes.paddingSmall),
                      Expanded(
                        child: Text(
                          venue.address,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingSmall),
                  // Features badges
                  if (venue.features.isNotEmpty) ...[
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: venue.features.take(4).map((feature) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            border: Border.all(color: AppColors.outline),
                            borderRadius:
                                BorderRadius.circular(AppSizes.radiusSmall),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _getFeatureIcon(feature.featureName),
                                style: const TextStyle(fontSize: 12),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                feature.featureName,
                                style: const TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppSizes.paddingSmall),
                  ],
                  // Distance and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${venue.distance.toStringAsFixed(1)} km away',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: AppSizes.paddingSmall),
                          Text(
                            '${venue.rating} (${venue.reviewCount})',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFeatureIcon(String featureName) {
    final lowerName = featureName.toLowerCase();

    if (lowerName.contains('pool')) return '🎱';
    if (lowerName.contains('darts')) return '🎯';
    if (lowerName.contains('sports')) return '📺';
    if (lowerName.contains('karaoke')) return '🎤';
    if (lowerName.contains('happy hour')) return '🍻';
    if (lowerName.contains('music')) return '🎵';
    if (lowerName.contains('wifi')) return '📶';
    if (lowerName.contains('outdoor')) return '🌳';
    if (lowerName.contains('pet')) return '🐕';
    if (lowerName.contains('food')) return '🍔';
    if (lowerName.contains('parking')) return '🚗';
    if (lowerName.contains('wheelchair')) return '♿';
    if (lowerName.contains('trivia') || lowerName.contains('quiz'))
      return '🧠';
    if (lowerName.contains('dj')) return '🎧';
    if (lowerName.contains('cocktail')) return '🍸';
    if (lowerName.contains('game')) return '🎮';

    return '✨';
  }
}
