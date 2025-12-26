/// Route definitions and route generator
/// Centralizes all navigation paths and enables type-safe navigation

import 'package:flutter/material.dart';
import 'package:small_app/screens/splash_screen.dart';
import 'package:small_app/screens/home_screen.dart';

/// Route path constants
class Routes {
  // Auth routes
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';

  // Main routes
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String editProfile = '/edit-profile';

  // Utility routes
  static const String notifications = '/notifications';
  static const String about = '/about';
  static const String error = '/error';
  static const String noInternet = '/no-internet';
  static const String emptyState = '/empty-state';
}

/// Route generator for navigation
class RouteGenerator {
  /// Generates routes dynamically based on route name
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routes.login:
        // TODO: Implement LoginScreen
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Login Screen - Not implemented yet'),
            ),
          ),
        );

      case Routes.signup:
        // TODO: Implement SignupScreen
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Signup Screen - Not implemented yet'),
            ),
          ),
        );

      case Routes.profile:
        // TODO: Implement ProfileScreen
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Profile Screen - Not implemented yet'),
            ),
          ),
        );

      case Routes.settings:
        // TODO: Implement SettingsScreen
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Settings Screen - Not implemented yet'),
            ),
          ),
        );

      case Routes.error:
        // TODO: Implement ErrorScreen
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Error Screen - Not implemented yet'),
            ),
          ),
        );

      case Routes.noInternet:
        // TODO: Implement NoInternetScreen
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Internet Screen - Not implemented yet'),
            ),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Unknown route: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
