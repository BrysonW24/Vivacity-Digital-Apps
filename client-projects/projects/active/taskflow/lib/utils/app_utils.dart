/// General application utilities
/// Common helper functions used throughout the app

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';

class AppUtils {
  // ==================== Device Info ====================
  /// Get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get device padding (safe area)
  static EdgeInsets getDevicePadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Check if device is in landscape
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Check if device is in portrait
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// Get device pixel ratio
  static double getDevicePixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  /// Check if device is small (phone)
  static bool isSmallDevice(BuildContext context) {
    return getScreenWidth(context) < 600;
  }

  /// Check if device is medium (tablet)
  static bool isMediumDevice(BuildContext context) {
    final width = getScreenWidth(context);
    return width >= 600 && width < 900;
  }

  /// Check if device is large (large tablet)
  static bool isLargeDevice(BuildContext context) {
    return getScreenWidth(context) >= 900;
  }

  // ==================== Snackbar & Dialogs ====================
  /// Show success snackbar
  static void showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Show error snackbar
  static void showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  /// Show warning snackbar
  static void showWarningSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Show info snackbar
  static void showInfoSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Show confirmation dialog
  static Future<bool> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Show alert dialog
  static void showAlertDialog(
    BuildContext context, {
    required String title,
    required String message,
    String buttonText = 'OK',
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  // ==================== Navigation ====================
  /// Navigate to route
  static Future<T?> navigateTo<T>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Replace current route
  static Future<T?> replaceWith<T>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.pushReplacement<T, T>(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Pop current route
  static void goBack<T>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }

  /// Pop until route
  static void popUntil(BuildContext context, String routeName) {
    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }

  // ==================== Focus & Keyboard ====================
  /// Unfocus current text field
  static void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Request focus for a node
  static void requestFocus(FocusNode node) {
    FocusScope.of(node.context!).requestFocus(node);
  }

  // ==================== Formatting ====================
  /// Format phone number
  static String formatPhoneNumber(String phone) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 10) {
      return '(${digits.substring(0, 3)}) ${digits.substring(3, 6)}-${digits.substring(6)}';
    }
    return phone;
  }

  /// Format currency
  static String formatCurrency(num amount, {String symbol = '\$'}) {
    final formatted = amount.toStringAsFixed(2);
    final parts = formatted.split('.');
    var integerPart = parts[0];
    final decimalPart = parts[1];

    integerPart = integerPart.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );

    return '$symbol$integerPart.$decimalPart';
  }

  /// Format file size
  static String formatFileSize(int bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var i = 0;
    var doubleBytes = bytes.toDouble();

    while (doubleBytes >= 1024 && i < suffixes.length - 1) {
      doubleBytes /= 1024;
      i++;
    }

    return '${doubleBytes.toStringAsFixed(2)} ${suffixes[i]}';
  }

  /// Format duration
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // ==================== Validators ====================
  /// Check if string is null or empty
  static bool isNullOrEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  /// Check if list is null or empty
  static bool isNullOrEmptyList<T>(List<T>? value) {
    return value == null || value.isEmpty;
  }

  /// Check if map is null or empty
  static bool isNullOrEmptyMap<K, V>(Map<K, V>? value) {
    return value == null || value.isEmpty;
  }

  // ==================== Delays & Debounce ====================
  /// Wait for duration
  static Future<void> wait(Duration duration) {
    return Future.delayed(duration);
  }

  /// Debounce function calls
  static Future<T?> debounce<T>(
    Future<T> Function() callback,
    Duration duration,
  ) async {
    await Future.delayed(duration);
    return callback();
  }

  // ==================== Logging ====================
  /// Log message with tag
  static void log(String message, {String tag = 'LOG'}) {
    debugPrint('[$tag] $message');
  }

  /// Log error
  static void logError(dynamic error, {String tag = 'ERROR'}) {
    debugPrint('[$tag] $error');
  }

  // ==================== JSON & Serialization ====================
  /// Check if string is valid JSON
  static bool isValidJson(String jsonString) {
    try {
      // ignore: unused_local_variable
      final _ = jsonDecode(jsonString);
      return true;
    } catch (_) {
      return false;
    }
  }

  // ==================== Color Utilities ====================
  /// Convert hex color to Color
  static Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (!hexString.startsWith('#')) buffer.write('#');
    buffer.write(hexString);

    return Color(int.parse(buffer.toString().replaceFirst('#', '0xff')));
  }

  /// Convert Color to hex string
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  // ==================== Random ====================
  /// Generate random string
  static String generateRandomString(int length) {
    const charset = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = <String>[];
    for (int i = 0; i < length; i++) {
      random.add(charset[Random().nextInt(charset.length)]);
    }
    return random.join();
  }

  /// Generate random ID
  static String generateRandomId({int length = 16}) {
    return generateRandomString(length);
  }
}

// Extension on BuildContext for easier AppUtils access
extension AppUtilsExtension on BuildContext {
  double get screenWidth => AppUtils.getScreenWidth(this);
  double get screenHeight => AppUtils.getScreenHeight(this);
  bool get isLandscape => AppUtils.isLandscape(this);
  bool get isPortrait => AppUtils.isPortrait(this);
  bool get isSmallDevice => AppUtils.isSmallDevice(this);
  bool get isMediumDevice => AppUtils.isMediumDevice(this);
  bool get isLargeDevice => AppUtils.isLargeDevice(this);

  void showSuccessSnackbar(String message) =>
      AppUtils.showSuccessSnackbar(this, message);

  void showErrorSnackbar(String message) =>
      AppUtils.showErrorSnackbar(this, message);

  void showWarningSnackbar(String message) =>
      AppUtils.showWarningSnackbar(this, message);

  void showInfoSnackbar(String message) =>
      AppUtils.showInfoSnackbar(this, message);

  Future<bool> showConfirmDialog({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) =>
      AppUtils.showConfirmDialog(
        this,
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
      );

  void showAlertDialog({
    required String title,
    required String message,
    String buttonText = 'OK',
  }) =>
      AppUtils.showAlertDialog(
        this,
        title: title,
        message: message,
        buttonText: buttonText,
      );

  Future<T?> navigateTo<T>(Widget page) =>
      AppUtils.navigateTo<T>(this, page);

  Future<T?> replaceWith<T>(Widget page) =>
      AppUtils.replaceWith<T>(this, page);

  void goBack<T>([T? result]) => AppUtils.goBack(this, result);

  void unfocus() => AppUtils.unfocus(this);
}
