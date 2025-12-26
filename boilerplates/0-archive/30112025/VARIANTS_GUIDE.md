# Flutter Project Boilerplate - Variants Guide

## Overview

This guide explains the reorganized boilerplate template structure and how to choose the right variant for your project.

---

## Boilerplate Structure

```
project_boilerplates/
├── production_flutter_template/          # Original production template (kept for reference)
├── variants/
│   ├── small-app/                        # Base: Minimal, cloud-agnostic deployment
│   ├── small-app-onpremis/               # On-premises with certificate pinning
│   ├── small-app-aws/                    # AWS Amplify + Cognito + S3
│   └── small-app-gcp/                    # Google Cloud + Firebase + Cloud Storage
├── basic_flutter_app/                    # [STUB] For future basic template
├── mvvm_flutter_template/                # [STUB] For future MVVM pattern template
└── VARIANTS_GUIDE.md                     # This file
```

---

## Variant Selection Guide

### 1. **small-app** (Base Template)
**Best For:** Cloud-agnostic, custom backends, rapid MVP development

**Includes:**
- Minimal dependencies
- Generic HTTP API client
- SharedPreferences storage
- Provider state management
- Material Design 3 theming

**Use When:**
- Building for yourself (portfolio projects)
- Backend is custom (not AWS/GCP)
- Want smallest app size
- Maximum flexibility

**Example Projects:** FitCoach Pro, TaskFlow, RecipeBank

**Setup Time:** 15 minutes

---

### 2. **small-app-onpremis** (Enterprise On-Premises)
**Best For:** Corporate/enterprise deployments, on-premises infrastructure

**Includes:**
- Everything from small-app PLUS:
- SSL certificate pinning
- On-premises API endpoint configuration
- Custom domain support
- Enterprise logging
- Network security enhancements
- Offline-first capability

**Use When:**
- Client has on-premises servers
- Security/compliance requirements
- Cannot use public cloud services
- Enterprise customer project

**Example:** Hospital management, Government agency app

**Setup Time:** 20 minutes

---

### 3. **small-app-aws** (Amazon Web Services)
**Best For:** AWS-hosted projects, serverless backends, automatic scaling

**Includes:**
- Everything from small-app PLUS:
- AWS Amplify integration
- Amazon Cognito authentication
- Amazon S3 file uploads
- DynamoDB local sync
- CloudWatch logging integration
- API Gateway endpoints
- AWS IoT support (optional)

**Use When:**
- Backend hosted on AWS
- Using Cognito for authentication
- Need file uploads to S3
- Want AWS monitoring/logging

**Example:** Mobile app with AWS Lambda backend, S3 media storage

**Setup Time:** 25 minutes

---

### 4. **small-app-gcp** (Google Cloud Platform)
**Best For:** Google Cloud hosted projects, Firebase backend, real-time databases

**Includes:**
- Everything from small-app PLUS:
- Firebase Authentication
- Google Cloud Storage
- Firestore real-time database
- Cloud Logging integration
- Google Sign-In support
- Cloud Functions endpoints
- Firebase Hosting integration

**Use When:**
- Backend hosted on Google Cloud
- Using Firebase for real-time data
- Need Google Sign-In
- Want Firebase Analytics/Crashlytics

**Example:** Social app with Firestore, real-time updates, Firebase Storage

**Setup Time:** 25 minutes

---

## Quick Decision Tree

```
Start here: "Which cloud platform will host the backend?"
│
├─ "Custom/On-Premises" → Use: small-app-onpremis
│
├─ "AWS (Amplify, Lambda, API Gateway)" → Use: small-app-aws
│
├─ "Google Cloud (Firebase, Cloud Functions)" → Use: small-app-gcp
│
└─ "No preference / Building MVP / Self-hosted" → Use: small-app
```

---

## Feature Comparison Matrix

| Feature | small-app | onpremis | aws | gcp |
|---------|-----------|----------|-----|-----|
| **HTTP Client** | ✅ | ✅ | ✅ | ✅ |
| **State Management** | ✅ | ✅ | ✅ | ✅ |
| **Local Storage** | ✅ | ✅ | ✅ | ✅ |
| **Logging** | ✅ | ✅ Enhanced | ✅ CloudWatch | ✅ Cloud Logging |
| **Certificate Pinning** | ❌ | ✅ | ✅ | ✅ |
| **Auth Service** | Custom | Custom | Cognito | Firebase |
| **File Upload** | HTTP | HTTP | S3 Service | Cloud Storage |
| **Database Sync** | Manual | Manual | DynamoDB Sync | Firestore Sync |
| **Provider Libraries** | 3 | 5 | 7 | 8 |
| **Learning Curve** | Easy | Medium | Medium | Medium |
| **App Size** | ~50MB | ~52MB | ~60MB | ~62MB |

---

## How to Use Each Variant

### Using small-app

```bash
# Copy the variant
cp -r templates/project_boilerplates/variants/small-app my-app
cd my-app

# Customize
edit pubspec.yaml                          # Update app name
edit lib/config/app_config.dart           # Update API URLs
edit lib/config/theme_config.dart         # Update colors

# Install & run
flutter pub get
flutter run
```

### Using small-app-aws

```bash
# Copy the variant
cp -r templates/project_boilerplates/variants/small-app-aws my-aws-app
cd my-aws-app

# Install AWS Amplify CLI (one time)
npm install -g @aws-amplify/cli

# Configure AWS
amplify configure

# Initialize Amplify in project
amplify init

# Add backend resources
amplify add auth      # Add Cognito
amplify add storage   # Add S3 bucket
amplify push          # Deploy to AWS

# Customize Flutter
edit lib/config/aws_config.dart           # AWS resource names
edit lib/services/aws_cognito_service.dart # Auth setup

# Install & run
flutter pub get
flutter run
```

### Using small-app-gcp

```bash
# Copy the variant
cp -r templates/project_boilerplates/variants/small-app-gcp my-gcp-app
cd my-gcp-app

# Install Firebase CLI (one time)
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase
firebase init

# Create Firestore database
firebase firestore:indexes:deploy

# Customize Flutter
edit lib/config/gcp_config.dart           # GCP project ID
edit lib/services/firebase_service.dart   # Firebase setup

# Install & run
flutter pub get
flutter run
```

---

## Cleanup: Removing Unused Boilerplates

The following stub templates are no longer needed and can be removed:

```bash
# These are just placeholders - remove if not using
rm -rf project_boilerplates/basic_flutter_app/
rm -rf project_boilerplates/mvvm_flutter_template/
```

**Note:** Keep `production_flutter_template/` as reference documentation.

---

## Migration Guide: Updating Existing Projects

If you have existing projects using the old structure, migrate them to a variant:

1. **Identify your backend:** AWS, GCP, On-Premises, or Custom?
2. **Select the appropriate variant** from the table above
3. **Copy your custom code** (models, screens, services) to the new variant
4. **Delete the old boilerplate files**
5. **Run `flutter pub get`** to verify

Example migration:

```bash
# Backup old project
cp -r my-app my-app-backup

# Copy variant over existing lib/ (keeping your custom code)
cp -r variants/small-app-aws/lib/* my-app/lib/
cp variants/small-app-aws/pubspec.yaml my-app/

# Review changes
git diff pubspec.yaml

# Test
cd my-app
flutter pub get
flutter run
```

---

## Creating New Variants

To create a new variant for a different platform (e.g., Azure, Alibaba Cloud):

1. **Copy base template:**
   ```bash
   cp -r variants/small-app variants/small-app-azure
   ```

2. **Create variant-specific config:**
   ```bash
   touch lib/config/azure_config.dart
   touch lib/services/azure_auth_service.dart
   touch lib/services/azure_storage_service.dart
   ```

3. **Update pubspec.yaml** with platform-specific packages

4. **Create README_AZURE.md** with setup instructions

5. **Update VARIANTS_GUIDE.md** to include new variant

---

## Dependency Management

### Minimal Dependencies (small-app)
```yaml
dependencies:
  flutter: sdk flutter
  provider: ^6.0.5           # State management
  http: ^1.1.0               # HTTP client
  sqflite: ^2.3.0            # Local database
  shared_preferences: ^2.2.0 # Key-value storage
```

### AWS Dependencies (small-app-aws)
```yaml
# Adds to minimal:
  amplify_flutter: ^1.0.0
  amplify_auth_cognito_dart: ^1.0.0
  amplify_storage_s3: ^1.0.0
  aws_dynamodb_api: ^4.0.0
```

### GCP Dependencies (small-app-gcp)
```yaml
# Adds to minimal:
  firebase_core: ^2.0.0
  firebase_auth: ^4.0.0
  cloud_firestore: ^4.0.0
  firebase_storage: ^11.0.0
  google_sign_in: ^6.0.0
```

---

## Best Practices per Variant

### small-app
- ✅ Use for MVPs and portfolio projects
- ✅ Implement custom API client wrapper
- ✅ Keep services layer minimal
- ❌ Don't add cloud-specific dependencies unless needed

### small-app-onpremis
- ✅ Always use certificate pinning in production
- ✅ Implement custom domain configuration
- ✅ Test offline functionality thoroughly
- ❌ Don't hardcode server IPs; use DNS names

### small-app-aws
- ✅ Use Cognito for all authentication
- ✅ Configure S3 bucket policies correctly
- ✅ Enable CloudWatch monitoring
- ✅ Use DynamoDB for real-time sync
- ❌ Don't store sensitive data in SharedPreferences

### small-app-gcp
- ✅ Use Firebase Authentication for all auth
- ✅ Enable Firestore security rules
- ✅ Use Cloud Storage for file uploads
- ✅ Enable Cloud Logging for monitoring
- ❌ Don't expose Firebase config in client code

---

## Support & Documentation

Each variant includes:
- **README.md** - General setup instructions
- **README_VARIANT.md** - Variant-specific setup guide
- **lib/config/\*_config.dart** - Configuration templates
- **lib/services/** - Pre-implemented service patterns

For detailed service implementations, see individual variant READMEs.

---

## Troubleshooting

### "Dependencies don't resolve"
→ Check variant README for specific package versions
→ Run `flutter pub upgrade` to get latest compatible versions

### "Certificate pinning failing"
→ Use onpremis variant with proper certificate setup
→ See `README_ONPREMIS.md` for certificate configuration

### "AWS services not connecting"
→ Run `amplify status` to verify backend resources
→ Check `aws_config.dart` for correct resource names
→ See AWS variant README for IAM policy setup

### "Firebase auth not working"
→ Verify Firebase project ID in `gcp_config.dart`
→ Check Google Services JSON is in correct location
→ See GCP variant README for Firebase configuration

---

## Next Steps

1. Choose your variant based on backend platform
2. Copy variant to `client-projects/active/`
3. Customize configuration files
4. Run `flutter pub get`
5. Begin building features!

---

**Last Updated:** November 30, 2025
**Template Version:** 1.0.0
**Status:** Production Ready
