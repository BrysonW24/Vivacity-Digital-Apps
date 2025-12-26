import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Connectivity Provider
///
/// Monitors network connectivity and notifies listeners of connection changes.
class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  bool _isOnline = false;

  // Getters
  ConnectivityResult get connectionStatus => _connectionStatus;
  bool get isOnline => _isOnline;
  bool get isOffline => !_isOnline;

  /// Initialize connectivity monitoring
  Future<void> initialize() async {
    // Check initial connectivity
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);

    // Listen to connectivity changes
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Update connection status
  void _updateConnectionStatus(ConnectivityResult result) {
    _connectionStatus = result;
    _isOnline = result != ConnectivityResult.none;
    notifyListeners();
  }

  /// Check if device has internet connection
  Future<bool> hasInternetConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      return false;
    }
  }

  /// Get connection type name
  String get connectionTypeName {
    switch (_connectionStatus) {
      case ConnectivityResult.mobile:
        return 'Mobile Data';
      case ConnectivityResult.wifi:
        return 'WiFi';
      case ConnectivityResult.ethernet:
        return 'Ethernet';
      case ConnectivityResult.vpn:
        return 'VPN';
      case ConnectivityResult.other:
        return 'Other';
      case ConnectivityResult.none:
        return 'No Connection';
      case ConnectivityResult.bluetooth:
        return 'Bluetooth';
    }
  }

  /// Check if connection is metered (mobile data)
  bool get isMeteredConnection => _connectionStatus == ConnectivityResult.mobile;

  /// Check if connection is unmetered (WiFi)
  bool get isUnmeteredConnection => _connectionStatus == ConnectivityResult.wifi;
}
