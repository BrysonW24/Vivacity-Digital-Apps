import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_sizes.dart';
import '../../config/app_strings.dart';
import '../../enums/loading_status.dart';
import '../../models/event_model.dart';
import '../../providers/event_provider.dart';
import '../../services/geolocation_service.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final GeolocationService _geolocationService = GeolocationService();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadEvents();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadEvents() async {
    try {
      final position = await _geolocationService.getCurrentLocation();
      if (mounted) {
        context.read<EventProvider>().fetchUpcomingEvents(
          latitude: position.latitude,
          longitude: position.longitude,
          radiusKm: 5,
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
        title: const Text(AppStrings.events),
        elevation: 0,
      ),
      body: Consumer<EventProvider>(
        builder: (context, eventProvider, _) {
          return Column(
            children: [
              // Tab selector
              Padding(
                padding: const EdgeInsets.all(AppSizes.paddingMedium),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text(AppStrings.upcoming),
                      ),
                    ),
                    const SizedBox(width: AppSizes.paddingSmall),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text(AppStrings.myBookings),
                      ),
                    ),
                  ],
                ),
              ),

              // Events list
              Expanded(
                child: _buildEventsList(eventProvider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEventsList(EventProvider eventProvider) {
    if (eventProvider.status == LoadingStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (eventProvider.status == LoadingStatus.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(eventProvider.errorMessage),
            const SizedBox(height: AppSizes.paddingMedium),
            ElevatedButton(
              onPressed: _loadEvents,
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      );
    }

    final events = eventProvider.upcomingEvents;

    if (events.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.event_note, size: 48),
            SizedBox(height: AppSizes.paddingMedium),
            Text('No events nearby'),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return _EventCard(
          event: events[index],
          onTap: () {
            eventProvider.selectEvent(events[index]);
            Navigator.of(context).pushNamed(
              '/event-details',
              arguments: events[index],
            );
          },
          onBook: () {
            _showBookingConfirmation(context, events[index], eventProvider);
          },
        );
      },
    );
  }

  void _showBookingConfirmation(
    BuildContext context,
    EventModel event,
    EventProvider eventProvider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Book Event'),
        content: Text('Book ${event.title} at ${event.venueName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              eventProvider.bookEvent(event);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Event booked successfully')),
              );
            },
            child: const Text(AppStrings.bookEvent),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback onTap;
  final VoidCallback onBook;

  const _EventCard({
    required this.event,
    required this.onTap,
    required this.onBook,
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
            // Image with category badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppSizes.radiusMedium),
                  ),
                  child: Image.network(
                    event.imageUrl,
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
                Positioned(
                  top: AppSizes.paddingSmall,
                  right: AppSizes.paddingSmall,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingSmall,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius:
                          BorderRadius.circular(AppSizes.radiusSmall),
                    ),
                    child: Text(
                      event.category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(AppSizes.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    event.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.paddingSmall),
                  // Venue
                  Text(
                    'at ${event.venueName}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: AppSizes.paddingSmall),
                  // Date and Time
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      const SizedBox(width: AppSizes.paddingSmall),
                      Expanded(
                        child: Text(
                          '${event.startTime.day}/${event.startTime.month} at ${event.startTime.hour.toString().padLeft(2, '0')}:${event.startTime.minute.toString().padLeft(2, '0')}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingSmall),
                  // Attendees and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${event.attendeeCount}/${event.capacity} going',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        event.pricePerPerson,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.paddingMedium),
                  // Book button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: event.isSoldOut ? null : onBook,
                      child: Text(
                        event.isSoldOut ? 'Sold Out' : AppStrings.bookEvent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on EventProvider {
  String get myBookings => 'My Bookings';
}
