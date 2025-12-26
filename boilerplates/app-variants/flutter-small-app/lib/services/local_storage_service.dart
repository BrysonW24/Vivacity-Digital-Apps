import 'package:shared_preferences/shared_preferences.dart';
import '../services/logger_service.dart';

/// Local storage service for persisting user preferences and app data
/// Uses SharedPreferences as the underlying storage mechanism
class LocalStorageService {
  static late final SharedPreferences _prefs;

  static const String _keyUserId = 'user_id';
  static const String _keyUserName = 'user_name';
  static const String _keyThemeMode = 'theme_mode';
  static const String _keyLastSyncTime = 'last_sync_time';
  static const String _keyIsFirstLaunch = 'is_first_launch';

  /// Initialize local storage
  static Future<void> initialize() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      LoggerService.info('LocalStorageService initialized');
    } catch (e) {
      LoggerService.error('Failed to initialize LocalStorageService', e);
      rethrow;
    }
  }

  // ===== User Data =====

  /// Save user ID
  static Future<bool> setUserId(String userId) async {
    try {
      return await _prefs.setString(_keyUserId, userId);
    } catch (e) {
      LoggerService.error('Error saving userId', e);
      return false;
    }
  }

  /// Get user ID
  static String? getUserId() {
    try {
      return _prefs.getString(_keyUserId);
    } catch (e) {
      LoggerService.error('Error getting userId', e);
      return null;
    }
  }

  /// Save user name
  static Future<bool> setUserName(String userName) async {
    try {
      return await _prefs.setString(_keyUserName, userName);
    } catch (e) {
      LoggerService.error('Error saving userName', e);
      return false;
    }
  }

  /// Get user name
  static String? getUserName() {
    try {
      return _prefs.getString(_keyUserName);
    } catch (e) {
      LoggerService.error('Error getting userName', e);
      return null;
    }
  }

  // ===== App Preferences =====

  /// Save theme mode (light/dark)
  static Future<bool> setThemeMode(String themeMode) async {
    try {
      return await _prefs.setString(_keyThemeMode, themeMode);
    } catch (e) {
      LoggerService.error('Error saving themeMode', e);
      return false;
    }
  }

  /// Get theme mode
  static String? getThemeMode() {
    try {
      return _prefs.getString(_keyThemeMode);
    } catch (e) {
      LoggerService.error('Error getting themeMode', e);
      return null;
    }
  }

  /// Save last sync timestamp
  static Future<bool> setLastSyncTime(int timestamp) async {
    try {
      return await _prefs.setInt(_keyLastSyncTime, timestamp);
    } catch (e) {
      LoggerService.error('Error saving lastSyncTime', e);
      return false;
    }
  }

  /// Get last sync timestamp
  static int? getLastSyncTime() {
    try {
      return _prefs.getInt(_keyLastSyncTime);
    } catch (e) {
      LoggerService.error('Error getting lastSyncTime', e);
      return null;
    }
  }

  // ===== First Launch =====

  /// Check if this is the first launch
  static bool isFirstLaunch() {
    try {
      return _prefs.getBool(_keyIsFirstLaunch) ?? true;
    } catch (e) {
      LoggerService.error('Error checking isFirstLaunch', e);
      return true;
    }
  }

  /// Mark app as launched
  static Future<bool> markAsLaunched() async {
    try {
      return await _prefs.setBool(_keyIsFirstLaunch, false);
    } catch (e) {
      LoggerService.error('Error marking as launched', e);
      return false;
    }
  }

  // ===== Generic Methods =====

  /// Save any string value
  static Future<bool> saveString(String key, String value) async {
    try {
      return await _prefs.setString(key, value);
    } catch (e) {
      LoggerService.error('Error saving string for key: $key', e);
      return false;
    }
  }

  /// Get any string value
  static String? getString(String key) {
    try {
      return _prefs.getString(key);
    } catch (e) {
      LoggerService.error('Error getting string for key: $key', e);
      return null;
    }
  }

  /// Save any integer value
  static Future<bool> saveInt(String key, int value) async {
    try {
      return await _prefs.setInt(key, value);
    } catch (e) {
      LoggerService.error('Error saving int for key: $key', e);
      return false;
    }
  }

  /// Get any integer value
  static int? getInt(String key) {
    try {
      return _prefs.getInt(key);
    } catch (e) {
      LoggerService.error('Error getting int for key: $key', e);
      return null;
    }
  }

  /// Save any boolean value
  static Future<bool> saveBool(String key, bool value) async {
    try {
      return await _prefs.setBool(key, value);
    } catch (e) {
      LoggerService.error('Error saving bool for key: $key', e);
      return false;
    }
  }

  /// Get any boolean value
  static bool getBool(String key, {bool defaultValue = false}) {
    try {
      return _prefs.getBool(key) ?? defaultValue;
    } catch (e) {
      LoggerService.error('Error getting bool for key: $key', e);
      return defaultValue;
    }
  }

  /// Remove a value
  static Future<bool> remove(String key) async {
    try {
      return await _prefs.remove(key);
    } catch (e) {
      LoggerService.error('Error removing key: $key', e);
      return false;
    }
  }

  /// Clear all stored data
  static Future<bool> clear() async {
    try {
      return await _prefs.clear();
    } catch (e) {
      LoggerService.error('Error clearing all data', e);
      return false;
    }
  }

  /// Get all keys
  static Set<String> getAllKeys() {
    try {
      return _prefs.getKeys();
    } catch (e) {
      LoggerService.error('Error getting all keys', e);
      return {};
    }
  }
}
