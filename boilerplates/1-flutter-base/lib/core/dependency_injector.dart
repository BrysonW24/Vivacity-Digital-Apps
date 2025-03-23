/// DependencyInjector is used to register services globally across the app.
///
/// You can plug in a service locator like GetIt here, or set up async initializations
/// before the app starts (e.g., shared preferences, logging, analytics).
///
/// In this base boilerplate, the DI layer is a placeholder to support
/// scalable architecture as the app grows.

class DependencyInjector {
  static Future<void> initialize() async {
    // This method is called before `runApp()` in main.dart
    // and can be used to initialize global services.
    //
    // For example:
    // final prefs = await SharedPreferences.getInstance();
    // GetIt.I.registerSingleton(prefs);

    // Currently empty by design for flutter-base
  }
}
