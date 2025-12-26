# small-app-onpremis Variant Setup Guide

## Overview

The `small-app-onpremis` variant extends the base `small-app` template with enterprise on-premises deployment features:
- SSL/TLS certificate pinning
- Proxy support
- Offline-first capabilities
- Enterprise logging & audit trails

## Structure

```
small-app-onpremis/
├── lib/
│   ├── config/
│   │   └── onpremis_config.dart        # On-prem specific configuration
│   └── services/
│       └── onpremis_api_client.dart    # Extended API client with certificate pinning
├── pubspec_additions.yaml              # Additional dependencies to add
└── README_ONPREMIS.md                  # This file
```

## Setup Instructions

### 1. Copy Base Template
First, copy the `small-app` base template to your project:

```bash
cp -r variants/small-app my-enterprise-app
cd my-enterprise-app
```

### 2. Add On-Premises Extensions
Copy the variant-specific files:

```bash
cp -r ../small-app-onpremis/lib/config/onpremis_config.dart lib/config/
cp -r ../small-app-onpremis/lib/services/onpremis_api_client.dart lib/services/
```

### 3. Configure On-Premises Settings
Edit `lib/config/onpremis_config.dart`:

```dart
// Update your server URL
static const String onPremisServerUrl = 'https://internal.company.local';

// Enable certificate pinning (recommended for production)
static const bool enableCertificatePinning = true;
static const String certificateHash = 'YOUR_CERT_SHA256_HASH';

// Optional: Configure proxy if required
static const bool useProxy = true;
static const String proxyHost = 'proxy.company.local';
static const int proxyPort = 8080;
```

### 4. Update API Client
Edit `lib/services/api_client.dart` to use the secure client:

```dart
// Import the onprem extension
import '../config/onpremis_config.dart';
import 'onpremis_api_client.dart';

// Replace the default http.Client creation:
final client = OnPremisConfig.enableCertificatePinning
  ? OnPremisApiClient.createSecureClient()
  : OnPremisApiClient.createProxyClient();
```

### 5. Install Dependencies
```bash
flutter pub get
flutter analyze
```

## Key Features

### Certificate Pinning
Protects against man-in-the-middle attacks by verifying server certificates:

```dart
// In onpremis_config.dart
static const bool enableCertificatePinning = true;
static const String certificateHash = '...'; // SHA-256 hash
```

### Proxy Support
Connect through corporate proxies:

```dart
static const bool useProxy = true;
static const String proxyHost = 'proxy.company.local';
static const String proxyUsername = 'domain\\username';
static const String proxyPassword = 'password';
```

### Offline-First
Apps work offline and sync when connection returns:

```dart
static const bool enableOfflineMode = true;
static const bool enableLocalEncryption = true;
```

### Audit Logging
Track all API calls for compliance:

```dart
static const bool enableAuditLogging = true;
// All API calls automatically logged with timestamps and user info
```

## Common Configurations

### Scenario 1: Self-Signed Certificates (Development Only)
```dart
static const bool enableCertificatePinning = false;
static const bool validateSSLCertificate = false; // Dev only!
```

### Scenario 2: Corporate Network with Proxy
```dart
static const bool useProxy = true;
static const String proxyHost = 'proxy.corp.com';
static const int proxyPort = 8080;
static const String proxyUsername = 'DOMAIN\\username';
static const String proxyPassword = 'password';
```

### Scenario 3: Air-Gapped Network (No Internet)
```dart
static const bool enableOfflineMode = true;
static const bool enableLocalEncryption = true;
// App works entirely offline with local database
```

## Certificate Hash Generation

To get your certificate hash for pinning:

```bash
# From PEM file
openssl x509 -in certificate.pem -noout -pubkey | openssl pkey -pubin -outform DER | openssl dgst -sha256 -hex

# From server
echo | openssl s_client -servername server.com -connect server.com:443 | \
  openssl x509 -outform DER | openssl dgst -sha256 -hex
```

## Troubleshooting

### Certificate Pinning Errors
- **Error:** "Certificate validation failed"
- **Solution:** Verify certificate hash matches with: `openssl x509 -in cert.pem -noout -pubkey | ...`
- **Dev Only:** Disable pinning temporarily to debug

### Proxy Connection Fails
- **Error:** "CONNECT error" or "407 Proxy Authentication Required"
- **Solution:** Check proxy hostname/port and credentials in `onpremis_config.dart`
- **Debug:** Enable logging to see proxy requests

### API Timeouts
- **Error:** "Connection timeout"
- **Solution:** Increase timeout in `onpremis_config.dart`:
  ```dart
  static const int connectionTimeoutSeconds = 60; // Increase if needed
  ```

### Offline Sync Issues
- **Error:** "Data not syncing"
- **Solution:** Check that offline storage is enabled and device has storage space

## Security Recommendations

✅ **Do:**
- Enable certificate pinning in production
- Use SSL/TLS for all connections (HTTPS only)
- Encrypt sensitive data locally
- Enable audit logging for compliance
- Regularly rotate certificates

❌ **Don't:**
- Disable SSL validation in production
- Hardcode credentials in code
- Store sensitive data in SharedPreferences unencrypted
- Commit certificate hashes to public repositories

## Testing

### Test Certificate Pinning
```bash
# Start local HTTPS server
# Update config to point to localhost
# Run app - should connect without issues
```

### Test Proxy
```bash
# Use Charles Proxy or similar
# Route app traffic through proxy
# Verify all requests go through proxy
```

### Test Offline Mode
```bash
# Disconnect network
# Use app normally
# Reconnect and verify sync
```

## Performance Impact

- Certificate pinning: ~5-10ms additional validation time
- Proxy: ~20-50ms additional latency (depends on network)
- Offline encryption: ~2-5ms per write operation
- Audit logging: <1ms overhead

## Next Steps

1. Configure `onpremis_config.dart` with your server settings
2. Obtain and configure certificate hashes
3. Test with development servers
4. Run security audit before production
5. Set up monitoring and logging

## Support

For certificate pinning issues: See [Flutter HTTP documentation](https://pub.dev/packages/http)
For proxy configuration: Check your corporate IT department
For offline sync: Review `local_storage_service.dart` in base template
