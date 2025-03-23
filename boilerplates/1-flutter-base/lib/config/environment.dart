/// This file is used to manage environment-specific configurations.
///
/// You can extend this setup later to switch between dev, staging, and production environments
/// either manually or using tools like `flutter_flavorizr` or `.env` files.
/// 
/// This allows clean separation between live and test environments, especially
/// when dealing with APIs or analytics.

class EnvironmentConfig {
  // Toggle this to `true` for production builds.
  static const bool isProduction = false;

  // The base URL used by API services throughout the app.
  // This can be changed depending on the deployment target.
  static const String baseUrl = "https://api.dev.example.com";
}
