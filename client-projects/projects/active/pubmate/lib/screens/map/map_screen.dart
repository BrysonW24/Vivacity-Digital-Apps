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

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final GeolocationService _geolocationService = GeolocationService();
  late double _userLatitude;
  late double _userLongitude;
  bool _isMapLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    try {
      final position = await _geolocationService.getCurrentLocation();
      setState(() {
        _userLatitude = position.latitude;
        _userLongitude = position.longitude;
        _isMapLoaded = true;
      });

      if (mounted) {
        context.read<VenueProvider>().fetchNearbyVenues(
          latitude: _userLatitude,
          longitude: _userLongitude,
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
        title: const Text(AppStrings.map),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {
              _showFilterSheet(context);
            },
          ),
        ],
      ),
      body: Consumer2<VenueProvider, VenueFeatureProvider>(
        builder: (context, venueProvider, featureProvider, _) {
          if (!_isMapLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          // Filter venues based on selected features
          final filteredVenues = _filterVenuesByFeatures(
            venueProvider.allVenues,
            featureProvider,
          );

          return Stack(
            children: [
              // Map (placeholder - would use google_maps_flutter)
              Container(
                color: AppColors.surface,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.map, size: 64, color: Colors.grey),
                      const SizedBox(height: AppSizes.paddingMedium),
                      const Text('Google Maps Integration'),
                      const SizedBox(height: AppSizes.paddingSmall),
                      Text(
                        'Location: $_userLatitude, $_userLongitude',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppSizes.paddingMedium),
                      Text(
                        '${filteredVenues.length} venues found',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),

              // Venue list panel (bottom sheet style)
              DraggableScrollableSheet(
                initialChildSize: 0.3,
                minChildSize: 0.15,
                maxChildSize: 0.8,
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppSizes.radiusLarge),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Handle
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            margin:
                                const EdgeInsets.only(top: AppSizes.paddingMedium),
                            decoration: BoxDecoration(
                              color: AppColors.outline,
                              borderRadius:
                                  BorderRadius.circular(AppSizes.radiusSmall),
                            ),
                          ),
                        ),

                        // Active filters display
                        if (featureProvider.selectedFeatures.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(
                              AppSizes.paddingMedium,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Active Filters',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        featureProvider.clearAllFilters();
                                      },
                                      child: const Text('Clear'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSizes.paddingSmall),
                                Wrap(
                                  spacing: AppSizes.paddingSmall,
                                  children: featureProvider.selectedFeatures
                                      .map(
                                        (feature) => Chip(
                                          label: Text(feature),
                                          onDeleted: () {
                                            featureProvider
                                                .toggleFeature(feature);
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          ),

                        // Venue list
                        Expanded(
                          child: _buildVenueList(
                            filteredVenues,
                            scrollController,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildVenueList(
    List<VenueModel> venues,
    ScrollController scrollController,
  ) {
    if (venues.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_off, size: 48, color: Colors.grey),
            const SizedBox(height: AppSizes.paddingMedium),
            const Text(AppStrings.noPubsNearby),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: venues.length,
      itemBuilder: (context, index) {
        return _MapVenueCard(
          venue: venues[index],
          onTap: () {
            Navigator.of(context).pushNamed(
              '/venue-details',
              arguments: venues[index],
            );
          },
        );
      },
    );
  }

  List<VenueModel> _filterVenuesByFeatures(
    List<VenueModel> venues,
    VenueFeatureProvider featureProvider,
  ) {
    if (featureProvider.selectedFeatures.isEmpty) {
      return venues;
    }

    return venues.where((venue) {
      return featureProvider.venueHasSelectedFeatures(venue.features);
    }).toList();
  }

  void _showFilterSheet(BuildContext context) {
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

class _MapVenueCard extends StatelessWidget {
  final VenueModel venue;
  final VoidCallback onTap;

  const _MapVenueCard({
    required this.venue,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get top 3 features to display
    final topFeatures = venue.features.take(3).toList();

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMedium,
          vertical: AppSizes.paddingSmall,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Name and Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          venue.name,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppSizes.paddingSmall),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              '${venue.distance.toStringAsFixed(1)} km',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star,
                              size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            '${venue.rating}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.paddingSmall),
                      Text(
                        venue.priceRange,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: AppSizes.paddingMedium),

              // Features (icons + badges)
              if (topFeatures.isNotEmpty) ...[
                const Text(
                  'Features',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: AppSizes.paddingSmall),
                Wrap(
                  spacing: AppSizes.paddingSmall,
                  runSpacing: AppSizes.paddingSmall,
                  children: topFeatures.map((feature) {
                    return _FeatureBadge(feature: feature);
                  }).toList(),
                ),
              ],

              const SizedBox(height: AppSizes.paddingSmall),

              // Open status
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: venue.isOpen ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    venue.isOpen ? 'Open' : 'Closed',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: onTap,
                    child: const Text('View'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureBadge extends StatelessWidget {
  final dynamic feature;

  const _FeatureBadge({
    required this.feature,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String icon = _getFeatureIcon(feature.featureName);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.outline),
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          Text(
            feature.featureName,
            style: const TextStyle(fontSize: 12),
          ),
        ],
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
