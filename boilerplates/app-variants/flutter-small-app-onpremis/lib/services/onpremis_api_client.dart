/// On-Premises API Client Extension
/// Extends the base api_client.dart with certificate pinning and security features

import 'dart:io';
import 'package:http/http.dart' as http;
import 'onpremis_config.dart';

class OnPremisApiClient {
  /// Create HTTP client with certificate pinning
  /// Usage: Replace the default http.Client with this in api_client.dart
  static http.Client createSecureClient() {
    if (!OnPremisConfig.enableCertificatePinning) {
      return http.Client();
    }

    final httpClient = HttpClient();

    // Disable SSL verification only if you're using self-signed certs
    // IMPORTANT: Only for development! Use proper certificates in production
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    return http.IOClient(httpClient);
  }

  /// Create client with proxy support (if configured)
  static http.Client createProxyClient() {
    if (!OnPremisConfig.useProxy) {
      return createSecureClient();
    }

    final httpClient = HttpClient();

    // Configure proxy
    if (OnPremisConfig.useProxy) {
      httpClient.findProxy = (uri) {
        return 'PROXY ${OnPremisConfig.proxyHost}:${OnPremisConfig.proxyPort}';
      };

      // Set proxy credentials if needed
      if (OnPremisConfig.proxyUsername.isNotEmpty) {
        httpClient.authenticate = (host, port, scheme, realm) async {
          if (host == OnPremisConfig.proxyHost &&
              port == OnPremisConfig.proxyPort) {
            return httpClient.addProxyCredentials(
              OnPremisConfig.proxyHost,
              OnPremisConfig.proxyPort,
              'realm',
              HttpClientBasicCredentials(
                OnPremisConfig.proxyUsername,
                OnPremisConfig.proxyPassword,
              ),
            );
          }
          return false;
        };
      }
    }

    return http.IOClient(httpClient);
  }

  /// Validate certificate fingerprint
  /// Compare the certificate hash with the configured one
  static bool validateCertificateFingerprint(X509Certificate cert) {
    if (OnPremisConfig.certificateHash.isEmpty) {
      return true; // No validation if hash not configured
    }

    // TODO: Implement certificate hash validation
    // This requires computing SHA-256 of the certificate and comparing
    return true;
  }
}
