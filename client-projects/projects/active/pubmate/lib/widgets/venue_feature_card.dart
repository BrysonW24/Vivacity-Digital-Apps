import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_sizes.dart';
import '../models/venue_feature_model.dart';

class VenueFeatureCard extends StatelessWidget {
  final VenueFeatureModel feature;
  final VoidCallback? onTap;

  const VenueFeatureCard({
    required this.feature,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: AppSizes.paddingSmall),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Icon, Name, Status
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Text(
                    _getFeatureIcon(feature.featureName),
                    style: const TextStyle(fontSize: 28),
                  ),
                  const SizedBox(width: AppSizes.paddingMedium),

                  // Name and Status
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          feature.featureName,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: feature.isAvailable
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              feature.isAvailable ? 'Available' : 'Not Available',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Category badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(feature.category),
                      borderRadius:
                          BorderRadius.circular(AppSizes.radiusSmall),
                    ),
                    child: Text(
                      _formatCategory(feature.category),
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              // Pricing
              if (feature.pricing != null && feature.pricing!.hasPricing) ...[
                const SizedBox(height: AppSizes.paddingMedium),
                Container(
                  padding: const EdgeInsets.all(AppSizes.paddingSmall),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.outline),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Price',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        feature.pricing!.getFormattedPrice(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF2196F3),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Schedule
              if (feature.schedule != null) ...[
                const SizedBox(height: AppSizes.paddingMedium),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Available',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      feature.schedule!.getScheduleDisplay(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    if (feature.schedule!.specialNotes != null) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusSmall),
                        ),
                        child: Text(
                          feature.schedule!.specialNotes!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.amber[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],

              // Details
              if (feature.details != null && feature.details!.isNotEmpty) ...[
                const SizedBox(height: AppSizes.paddingMedium),
                Text(
                  feature.details!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],

              // Capacity
              if (feature.capacity != null) ...[
                const SizedBox(height: AppSizes.paddingMedium),
                Row(
                  children: [
                    const Icon(Icons.people, size: 16, color: Colors.grey),
                    const SizedBox(width: 6),
                    Text(
                      'Capacity: ${feature.capacity} people',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],

              // Tags
              if (feature.tags.isNotEmpty) ...[
                const SizedBox(height: AppSizes.paddingMedium),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: feature.tags
                      .map(
                        (tag) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius:
                                BorderRadius.circular(AppSizes.radiusSmall),
                          ),
                          child: Text(
                            '#$tag',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],

              // Availability Now
              const SizedBox(height: AppSizes.paddingMedium),
              if (feature.schedule != null)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: feature.schedule!.isAvailableNow()
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        feature.schedule!.isAvailableNow()
                            ? Icons.check_circle
                            : Icons.cancel,
                        size: 16,
                        color: feature.schedule!.isAvailableNow()
                            ? Colors.green
                            : Colors.red,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        feature.schedule!.isAvailableNow()
                            ? 'Available now'
                            : 'Not available now',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: feature.schedule!.isAvailableNow()
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
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
    if (lowerName.contains('function') || lowerName.contains('private'))
      return '🎪';
    if (lowerName.contains('beer')) return '🍺';

    return '✨';
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'entertainment':
        return Colors.purple;
      case 'dining':
        return Colors.orange;
      case 'seating':
        return Colors.teal;
      case 'technology':
        return Colors.blue;
      case 'events':
        return Colors.pink;
      case 'safety':
        return Colors.red;
      case 'accessibility':
        return Colors.green;
      case 'specialOffers':
        return Colors.amber;
      case 'parking':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String _formatCategory(String category) {
    return category
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
        .trim()
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
