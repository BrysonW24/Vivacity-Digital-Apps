/// On-Premises Configuration
/// This file extends app_config.dart with enterprise security features

class OnPremisConfig {
  // On-Premises Server Configuration
  static const String onPremisServerUrl = 'https://internal.company.local';
  static const int apiPort = 8443; // Standard HTTPS port for on-prem

  // Certificate Pinning
  static const bool enableCertificatePinning = true;
  static const String certificateHash = ''; // SHA-256 hash of your certificate

  // Network Security
  static const bool enableNetworkEncryption = true;
  static const bool validateSSLCertificate = true;
  static const int connectionTimeoutSeconds = 30;
  static const int readTimeoutSeconds = 60;

  // Enterprise Features
  static const bool enableOfflineMode = true;
  static const bool enableLocalEncryption = true;
  static const bool enableAuditLogging = true;

  // Proxy Configuration (if required)
  static const bool useProxy = false;
  static const String proxyHost = ''; // e.g., 'proxy.company.local'
  static const int proxyPort = 8080;
  static const String proxyUsername = ''; // Optional
  static const String proxyPassword = ''; // Optional
}
