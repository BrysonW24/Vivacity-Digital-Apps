# small-app-aws Variant Setup Guide

## Overview

The `small-app-aws` variant extends the base `small-app` template with AWS services integration:
- AWS Amplify for backend management
- Amazon Cognito for authentication
- Amazon S3 for file storage
- DynamoDB for real-time data sync
- CloudWatch for logging

## Prerequisites

- AWS Account with appropriate permissions
- AWS CLI installed and configured
- AWS Amplify CLI installed: `npm install -g @aws-amplify/cli`
- Flutter 3.19.0 or higher

## Structure

```
small-app-aws/
├── lib/
│   ├── config/
│   │   └── aws_config.dart             # AWS service configuration
│   └── services/
│       └── aws_cognito_service.dart    # Cognito authentication
├── amplify/                            # AWS Amplify configuration (created during setup)
├── README_AWS.md                       # This file
└── pubspec_additions.yaml              # Additional AWS dependencies
```

## Setup Instructions

### 1. Copy Base Template

```bash
cp -r variants/small-app my-aws-app
cd my-aws-app
```

### 2. Add AWS Extensions

```bash
mkdir -p lib/config lib/services
cp ../small-app-aws/lib/config/aws_config.dart lib/config/
cp ../small-app-aws/lib/services/aws_cognito_service.dart lib/services/
```

### 3. Configure AWS CLI (One-Time)

```bash
# Configure your AWS credentials
aws configure

# Verify configuration
aws sts get-caller-identity
```

### 4. Initialize AWS Amplify

```bash
# Initialize Amplify in your project
amplify init

# Answer the prompts:
# - Project name: my-aws-app
# - Environment: dev
# - Editor: Visual Studio Code (or your choice)
# - App type: flutter
# - AWS profile: default (or your configured profile)
```

### 5. Add AWS Services

```bash
# Add Authentication (Cognito)
amplify add auth
# Select: Amazon Cognito user pool

# Add File Storage (S3)
amplify add storage
# Select: S3 bucket for file storage

# (Optional) Add API
amplify add api
# Select: REST API

# Deploy to AWS
amplify push
```

### 6. Update Configuration

Edit `lib/config/aws_config.dart` with your AWS resources:

```dart
// From your Cognito User Pool
static const String cognitoUserPoolId = 'us-east-1_XXXXXXXXX';
static const String cognitoClientId = 'XXXXXXXXX';

// From your S3 bucket
static const String s3BucketName = 'your-app-bucket-XXXXX';

// From your API Gateway (if created)
static const String apiGatewayBaseUrl = 'https://XXXXXXXXX.execute-api.us-east-1.amazonaws.com/v1';
```

### 7. Add Dependencies

Add to `pubspec.yaml`:

```yaml
dependencies:
  amplify_flutter: ^1.3.0
  amplify_auth_cognito_dart: ^1.3.0
  amplify_storage_s3: ^1.3.0
  amplify_api: ^1.3.0  # If using REST API
  aws_common: ^0.1.0
```

### 8. Install and Test

```bash
flutter pub get
flutter analyze
flutter run
```

## AWS Service Setup Details

### Amazon Cognito Authentication

**What it does:** Manages user sign-up, sign-in, and multi-factor authentication

**Setup:**
```bash
amplify add auth

# Choose:
# - Default configuration
# - Email as sign-in method (or username)
# - Enable password requirements
```

**Usage in code:**
```dart
import 'services/aws_cognito_service.dart';

// Sign up
await AwsCognitoService.signUpUser(
  email: 'user@example.com',
  password: 'SecurePassword123!',
);

// Sign in
await AwsCognitoService.signInUser(
  email: 'user@example.com',
  password: 'SecurePassword123!',
);

// Get current user
final userId = await AwsCognitoService.getCurrentUserId();
```

### Amazon S3 Storage

**What it does:** Store files (images, documents, videos) in scalable cloud storage

**Setup:**
```bash
amplify add storage

# Choose:
# - Default configuration
# - Public access
# - CRUD permissions
```

**Usage in code:**
```dart
// Upload file
final result = await Amplify.Storage.uploadFile(
  local: File('/path/to/image.jpg'),
  key: 'images/profile-${userId}.jpg',
).result;

// Download file
final result = await Amplify.Storage.downloadFile(
  key: 'images/profile-${userId}.jpg',
  local: File('${tempDir}/image.jpg'),
).result;

// List files
final result = await Amplify.Storage.list(path: 'images/').result;
```

### DynamoDB for Sync

**What it does:** Synchronizes local data with cloud database automatically

**Setup:**
```dart
// In aws_config.dart
static const bool enableDynamoDBSync = true;
static const String dynamoDBTable = 'UserData';

// In models, add @DataModel annotation (with ModelProvider)
@DataModel
class User {
  final String id;
  final String name;
  final String email;

  // Sync status automatically tracked
}
```

### CloudWatch Logging

**What it does:** Centralized logging for debugging and monitoring

**Setup:**
```dart
// Automatically logs to CloudWatch when enabled
// View logs in AWS Console:
// CloudWatch → Log Groups → /aws/amplify/your-app
```

## Configuration Examples

### Scenario 1: Social App with Google Sign-In
```dart
// In aws_config.dart
static const bool enableCognitoAuth = true;
static const bool enableGoogleSignIn = true;

// In main.dart
// Configure Google Sign-In providers in Cognito
```

### Scenario 2: File Upload App with S3
```dart
static const bool enableS3Upload = true;
static const String s3BucketName = 'user-uploads-bucket';

// In your upload service
final s3Service = AwsS3Service();
await s3Service.uploadFile(file, path: 'uploads/${userId}/');
```

### Scenario 3: Real-Time Chat with AppSync
```dart
static const bool enableAppSync = true;
static const String appSyncEndpoint = 'https://XXXXXXXXX.appsync-api.us-east-1.amazonaws.com/graphql';

// Use AppSync subscriptions for real-time messages
```

## Cost Optimization

### Free Tier Limits (AWS Free Tier)
- **Cognito:** 50,000 MAUs (Monthly Active Users)
- **S3:** 5GB storage + 20,000 GET requests
- **DynamoDB:** 25GB storage + 25 read/write capacity units
- **CloudWatch:** 10GB logs per month

### Cost Reduction Tips
1. Use on-demand pricing for variable workloads
2. Enable S3 Intelligent-Tiering for automatic archival
3. Set DynamoDB autoscaling for burst traffic
4. Use CloudWatch log retention policies (e.g., 30 days)

## Troubleshooting

### Cognito Sign-In Fails
- **Error:** "Invalid client id"
- **Solution:** Check `cognitoClientId` in `aws_config.dart` matches Cognito app client
- **Debug:** `amplify auth console`

### S3 Upload Permission Denied
- **Error:** "Access Denied"
- **Solution:** Check S3 bucket policy allows authenticated users
- **Fix:** `amplify update storage` → adjust permissions

### API Gateway 403 Errors
- **Error:** "Forbidden"
- **Solution:** Verify IAM role has API Gateway invoke permissions
- **Check:** AWS Console → IAM → Roles

### DynamoDB Sync Not Working
- **Error:** "Table not found"
- **Solution:** Run `amplify push` to create DynamoDB table
- **Verify:** AWS Console → DynamoDB → Tables

## Testing

### Test Cognito Flow
```bash
# Create test user in Cognito console
# Sign in via app
# Verify token generated
# Check CloudWatch logs
```

### Test S3 Upload
```bash
# Upload file via app
# Check AWS Console → S3 → Your Bucket
# Verify file appears with correct permissions
```

### Test DynamoDB Sync
```bash
# Create data offline
# Go online
# Verify data synced in AWS Console → DynamoDB
```

## Performance Metrics

- **Cognito sign-in:** ~500-1000ms
- **S3 upload (5MB):** ~2-5 seconds (depends on network)
- **DynamoDB sync:** ~1-2 seconds for 100 items
- **API latency:** ~100-200ms from US regions

## Security Best Practices

✅ **Do:**
- Enable MFA for Cognito
- Use IAM roles with least privilege
- Enable S3 bucket versioning
- Enable CloudTrail for audit logs
- Use VPC endpoints for private connections

❌ **Don't:**
- Expose AWS credentials in code
- Disable S3 encryption
- Allow public S3 bucket access
- Store secrets in CloudWatch logs
- Hardcode API keys

## Next Steps

1. Complete AWS setup with `amplify push`
2. Implement Cognito sign-up/sign-in screens
3. Create S3 upload/download service
4. Set up DynamoDB models
5. Configure CloudWatch dashboards
6. Test with actual AWS services
7. Set up continuous deployment with Amplify

## Resources

- [AWS Amplify Flutter Documentation](https://docs.amplify.aws/flutter/)
- [Amazon Cognito Docs](https://docs.aws.amazon.com/cognito/)
- [Amazon S3 Docs](https://docs.aws.amazon.com/s3/)
- [AWS Pricing Calculator](https://calculator.aws/)
