/// Asset constants
class Assets {
  Assets._();

  // Base paths
  static const String _images = 'assets/images';
  static const String _icons = 'assets/icons';
  static const String _animations = 'assets/animations';

  /// Image assets
  static class Images {
    Images._();
    static const String logo = '$_images/logo.png';
    static const String logoWhite = '$_images/logo_white.png';
    static const String placeholder = '$_images/placeholder.png';
    static const String avatarPlaceholder = '$_images/avatar_placeholder.png';
    static const String emptySearch = '$_images/empty_search.png';
    static const String emptyNotifications = '$_images/empty_notifications.png';
    static const String emptyList = '$_images/empty_list.png';
    static const String error404 = '$_images/error_404.png';
    static const String error500 = '$_images/error_500.png';
    static const String noConnection = '$_images/no_connection.png';
  }

  /// Icon assets
  static class Icons {
    Icons._();
    static const String home = '$_icons/home.svg';
    static const String search = '$_icons/search.svg';
    static const String profile = '$_icons/profile.svg';
    static const String settings = '$_icons/settings.svg';
    static const String notifications = '$_icons/notifications.svg';
  }

  /// Animation assets
  static class Animations {
    Animations._();
    static const String loading = '$_animations/loading.json';
    static const String success = '$_animations/success.json';
    static const String error = '$_animations/error.json';
  }
}
