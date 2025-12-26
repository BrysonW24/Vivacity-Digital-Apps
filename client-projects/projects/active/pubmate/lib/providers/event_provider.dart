import 'package:flutter/foundation.dart';
import '../models/event_model.dart';
import '../enums/loading_status.dart';

class EventProvider extends ChangeNotifier {
  List<EventModel> _upcomingEvents = [];
  List<EventModel> _myBookedEvents = [];
  EventModel? _selectedEvent;
  LoadingStatus _status = LoadingStatus.initial;
  String _errorMessage = '';

  List<EventModel> get upcomingEvents => _upcomingEvents;
  List<EventModel> get myBookedEvents => _myBookedEvents;
  EventModel? get selectedEvent => _selectedEvent;
  LoadingStatus get status => _status;
  String get errorMessage => _errorMessage;

  // Fetch upcoming events
  Future<void> fetchUpcomingEvents({
    required double latitude,
    required double longitude,
    required double radiusKm,
  }) async {
    _status = LoadingStatus.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      _upcomingEvents = [
        EventModel(
          id: '1',
          venueId: '1',
          venueName: 'The Red Lion',
          title: 'Live Music Night',
          description: 'Local band performing classic hits',
          startTime: DateTime.now().add(const Duration(days: 3)),
          endTime: DateTime.now().add(const Duration(days: 3, hours: 3)),
          category: 'Live Music',
          imageUrl: 'https://via.placeholder.com/300x200',
          attendeeCount: 45,
          capacity: 100,
          isBooked: false,
          tags: ['Live Music', 'Local Band', 'Free Entry'],
          pricePerPerson: 'Free',
          hasFood: true,
          hasLiveMusic: true,
        ),
      ];
      _status = LoadingStatus.loaded;
    } catch (e) {
      _errorMessage = 'Failed to fetch events: ${e.toString()}';
      _status = LoadingStatus.error;
    }
    notifyListeners();
  }

  // Book an event
  Future<void> bookEvent(EventModel event) async {
    _status = LoadingStatus.loading;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      _myBookedEvents.add(event);
      if (_selectedEvent?.id == event.id) {
        _selectedEvent = event.copyWith(isBooked: true);
      }
      _status = LoadingStatus.loaded;
    } catch (e) {
      _errorMessage = 'Failed to book event: ${e.toString()}';
      _status = LoadingStatus.error;
    }
    notifyListeners();
  }

  // Cancel booking
  Future<void> cancelBooking(String eventId) async {
    _status = LoadingStatus.loading;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      _myBookedEvents.removeWhere((event) => event.id == eventId);
      if (_selectedEvent?.id == eventId) {
        _selectedEvent = _selectedEvent?.copyWith(isBooked: false);
      }
      _status = LoadingStatus.loaded;
    } catch (e) {
      _errorMessage = 'Failed to cancel booking: ${e.toString()}';
      _status = LoadingStatus.error;
    }
    notifyListeners();
  }

  // Select event
  void selectEvent(EventModel event) {
    _selectedEvent = event;
    notifyListeners();
  }

  // Clear selected event
  void clearSelectedEvent() {
    _selectedEvent = null;
    notifyListeners();
  }

  // Fetch user's booked events
  Future<void> fetchMyBookedEvents() async {
    _status = LoadingStatus.loading;
    notifyListeners();

    try {
      // TODO: Replace with actual API call
      _status = LoadingStatus.loaded;
    } catch (e) {
      _errorMessage = 'Failed to fetch bookings: ${e.toString()}';
      _status = LoadingStatus.error;
    }
    notifyListeners();
  }

  // Get events by venue
  List<EventModel> getEventsByVenue(String venueId) {
    return _upcomingEvents.where((event) => event.venueId == venueId).toList();
  }

  // Get upcoming events for next N days
  List<EventModel> getUpcomingEventsForDays(int days) {
    final now = DateTime.now();
    final future = now.add(Duration(days: days));
    return _upcomingEvents
        .where((event) => event.startTime.isAfter(now) && event.startTime.isBefore(future))
        .toList();
  }
}
