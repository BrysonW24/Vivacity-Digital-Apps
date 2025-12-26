import 'package:flutter/material.dart';

/// Navigation Service
///
/// Centralized navigation management.
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Get current context
  BuildContext? get context => navigatorKey.currentContext;

  /// Get current navigator state
  NavigatorState? get _navigator => navigatorKey.currentState;

  /// Navigate to named route
  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return _navigator?.pushNamed(routeName, arguments: arguments) ??
        Future.value();
  }

  /// Navigate and replace current route
  Future<dynamic> navigateToReplacement(String routeName,
      {Object? arguments}) {
    return _navigator?.pushReplacementNamed(routeName, arguments: arguments) ??
        Future.value();
  }

  /// Navigate and clear all previous routes
  Future<dynamic> navigateToRemoveUntil(String routeName,
      {Object? arguments}) {
    return _navigator?.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments) ??
        Future.value();
  }

  /// Pop current route
  void pop<T extends Object?>({T? result}) {
    _navigator?.pop(result);
  }

  /// Pop until route
  void popUntil(String routeName) {
    _navigator?.popUntil(ModalRoute.withName(routeName));
  }

  /// Check if can pop
  bool canPop() {
    return _navigator?.canPop() ?? false;
  }

  /// Get current route name
  String? get currentRouteName {
    String? routeName;
    _navigator?.popUntil((route) {
      routeName = route.settings.name;
      return true;
    });
    return routeName;
  }
}
