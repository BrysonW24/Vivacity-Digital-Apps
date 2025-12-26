/// User app settings/preferences model
/// Stores user-specific preferences and app configuration

class AppSettings {
  final bool notificationsEnabled;
  final bool darkModeEnabled;
  final String appLanguage;
  final bool analyticsEnabled;
  final bool biometricEnabled;
  final bool crashReportingEnabled;
  final DateTime? lastSyncTime;
  final Map<String, dynamic>? customSettings;

  AppSettings({
    this.notificationsEnabled = true,
    this.darkModeEnabled = false,
    this.appLanguage = 'en',
    this.analyticsEnabled = true,
    this.biometricEnabled = false,
    this.crashReportingEnabled = true,
    this.lastSyncTime,
    this.customSettings,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      darkModeEnabled: json['darkModeEnabled'] ?? false,
      appLanguage: json['appLanguage'] ?? 'en',
      analyticsEnabled: json['analyticsEnabled'] ?? true,
      biometricEnabled: json['biometricEnabled'] ?? false,
      crashReportingEnabled: json['crashReportingEnabled'] ?? true,
      lastSyncTime: json['lastSyncTime'] != null
          ? DateTime.parse(json['lastSyncTime'])
          : null,
      customSettings: json['customSettings'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationsEnabled': notificationsEnabled,
      'darkModeEnabled': darkModeEnabled,
      'appLanguage': appLanguage,
      'analyticsEnabled': analyticsEnabled,
      'biometricEnabled': biometricEnabled,
      'crashReportingEnabled': crashReportingEnabled,
      'lastSyncTime': lastSyncTime?.toIso8601String(),
      'customSettings': customSettings,
    };
  }

  /// Copy with method for immutable updates
  AppSettings copyWith({
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    String? appLanguage,
    bool? analyticsEnabled,
    bool? biometricEnabled,
    bool? crashReportingEnabled,
    DateTime? lastSyncTime,
    Map<String, dynamic>? customSettings,
  }) {
    return AppSettings(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      appLanguage: appLanguage ?? this.appLanguage,
      analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      crashReportingEnabled: crashReportingEnabled ?? this.crashReportingEnabled,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      customSettings: customSettings ?? this.customSettings,
    );
  }

  /// Factory constructor for default settings
  factory AppSettings.defaults() {
    return AppSettings(
      notificationsEnabled: true,
      darkModeEnabled: false,
      appLanguage: 'en',
      analyticsEnabled: true,
      biometricEnabled: false,
      crashReportingEnabled: true,
    );
  }
}
