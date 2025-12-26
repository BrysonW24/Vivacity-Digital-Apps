import 'package:geolocator/geolocator.dart';
import '../utils/app_utils.dart';

class GeolocationService {
  static const String _tag = 'GeolocationService';
  static const int _timeoutSeconds = 30;

  // Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Request location permission
  Future<LocationPermission> requestLocationPermission() async {
    return await Geolocator.requestPermission();
  }

  // Get current location permission status
  Future<LocationPermission> checkLocationPermission() async {
    return await Geolocator.checkPermission();
  }

  // Get current user location
  Future<Position> getCurrentLocation({
    LocationAccuracy accuracy = LocationAccuracy.high,
  }) async {
    try {
      // Check if location services are enabled
      final isEnabled = await isLocationServiceEnabled();
      if (!isEnabled) {
        throw LocationServiceDisabledException();
      }

      // Check permission
      final permission = await checkLocationPermission();
      if (permission == LocationPermission.denied) {
        final result = await requestLocationPermission();
        if (result == LocationPermission.denied) {
          throw PermissionDeniedException('Location permission denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw PermissionDeniedException('Location permission denied forever');
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: accuracy,
        timeLimit: const Duration(seconds: _timeoutSeconds),
      );

      return position;
    } catch (e) {
      AppUtils.log(
        _tag,
        'Error getting current location: $e',
        error: e,
      );
      rethrow;
    }
  }

  // Calculate distance between two points (in kilometers)
  static double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000;
  }

  // Watch user location (continuous updates)
  Stream<Position> watchLocation({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 10, // meters
  }) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      ),
    );
  }

  // Open app location settings
  Future<bool> openLocationSettings() async {
    return await Geolocator.openLocationSettings();
  }

  // Open app permission settings
  Future<bool> openAppSettings() async {
    return await Geolocator.openAppSettings();
  }

  // Check if location permissions are sufficient
  Future<bool> hasLocationPermission() async {
    final permission = await checkLocationPermission();
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  // Get location from coordinates (reverse geocoding)
  // Note: This would typically require a separate geocoding service
  // like google_maps_flutter or geocoding package
}

class LocationServiceDisabledException implements Exception {
  @override
  String toString() => 'Location service is disabled';
}

class PermissionDeniedException implements Exception {
  final String message;
  PermissionDeniedException(this.message);

  @override
  String toString() => 'Permission denied: $message';
}
