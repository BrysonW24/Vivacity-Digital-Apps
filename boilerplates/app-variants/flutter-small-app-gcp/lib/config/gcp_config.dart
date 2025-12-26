/// Google Cloud Platform Configuration
/// Firebase and Google Cloud services configuration

class GcpConfig {
  // Firebase Project Configuration
  static const String firebaseProjectId = 'your-project-id';
  static const String firebaseApiKey = 'YOUR_FIREBASE_API_KEY';
  static const String firebaseAppId = 'YOUR_FIREBASE_APP_ID';
  static const String firebaseMessagingSenderId = 'YOUR_MESSAGING_SENDER_ID';

  // Firebase Authentication
  static const bool enableFirebaseAuth = true;
  static const bool enableGoogleSignIn = true;
  static const bool enablePhoneAuth = true;

  // Cloud Firestore Database
  static const bool enableFirestore = true;
  static const String firestoreDatabase = '(default)';

  // Google Cloud Storage
  static const bool enableCloudStorage = true;
  static const String storageBucket = 'your-project-id.appspot.com';

  // Cloud Logging
  static const bool enableCloudLogging = true;
  static const String cloudLogsProject = 'your-project-id';

  // Firebase Cloud Functions
  static const String cloudFunctionsRegion = 'us-central1';
  static const bool enableCloudFunctions = true;

  // Firebase Real-time Database (Optional - Realtime DB instead of Firestore)
  static const bool enableRealtimeDb = false;
  static const String realtimeDatabaseUrl = 'https://your-project-id.firebaseio.com';

  // Feature Flags
  static const bool enableOfflineSync = true;
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const int maxRetryAttempts = 3;
}
