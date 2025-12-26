import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/entry_editor_screen.dart';
import '../screens/entry_detail_screen.dart';
import '../screens/search_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/change_password_screen.dart';
import '../screens/auth/delete_account_screen.dart';
import '../screens/info/about_screen.dart';
import '../screens/info/contact_screen.dart';
import '../screens/info/privacy_screen.dart';
import '../screens/info/terms_screen.dart';
import '../screens/common/error_screen.dart';
import '../screens/common/not_found_screen.dart';
import '../screens/common/no_connection_screen.dart';
import '../screens/common/maintenance_screen.dart';

/// Application Routes
///
/// Central route management for the journal app.
/// All named routes are defined here for centralized navigation.
class AppRoutes {
  // Auth routes
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String changePassword = '/change-password';
  static const String deleteAccount = '/delete-account';

  // Home routes
  static const String home = '/home';
  static const String entryEditor = '/entry-editor';
  static const String entryDetail = '/entry-detail';
  static const String search = '/search';
  static const String settings = '/settings';

  // Info routes
  static const String about = '/about';
  static const String contact = '/contact';
  static const String privacy = '/privacy';
  static const String terms = '/terms';

  // Error routes
  static const String error = '/error';
  static const String notFound = '/404';
  static const String noConnection = '/no-connection';
  static const String maintenance = '/maintenance';
}

/// Route Generator for the application
///
/// Handles navigation to different screens based on route names.
/// All routes should be defined here to ensure consistency.
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // Auth routes
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      case AppRoutes.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());

      case AppRoutes.deleteAccount:
        return MaterialPageRoute(builder: (_) => const DeleteAccountScreen());

      // Home routes
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case AppRoutes.entryEditor:
        return MaterialPageRoute(
          builder: (_) => EntryEditorScreen(entryId: args as String?),
        );

      case AppRoutes.entryDetail:
        return MaterialPageRoute(
          builder: (_) => EntryDetailScreen(entryId: args as String),
        );

      case AppRoutes.search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      // Info routes
      case AppRoutes.about:
        return MaterialPageRoute(builder: (_) => const AboutScreen());

      case AppRoutes.contact:
        return MaterialPageRoute(builder: (_) => const ContactScreen());

      case AppRoutes.privacy:
        return MaterialPageRoute(builder: (_) => const PrivacyScreen());

      case AppRoutes.terms:
        return MaterialPageRoute(builder: (_) => const TermsScreen());

      // Error routes
      case AppRoutes.error:
        return MaterialPageRoute(
          builder: (_) => ErrorScreen(
            message: args is String ? args : 'An error occurred',
            onRetry: () {},
          ),
        );

      case AppRoutes.notFound:
        return MaterialPageRoute(builder: (_) => const NotFoundScreen());

      case AppRoutes.noConnection:
        return MaterialPageRoute(builder: (_) => const NoConnectionScreen());

      case AppRoutes.maintenance:
        return MaterialPageRoute(builder: (_) => const MaintenanceScreen());

      // Home as default
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      // Unknown route
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundScreen());
    }
  }

  /// Handle unknown routes
  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const NotFoundScreen(),
    );
  }
}
