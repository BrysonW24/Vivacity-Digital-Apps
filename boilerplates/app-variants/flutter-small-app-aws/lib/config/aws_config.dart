/// AWS Amplify Configuration
/// Add these settings to your project configuration

class AwsConfig {
  // AWS Region
  static const String awsRegion = 'us-east-1'; // Change to your region

  // Cognito Authentication
  static const String cognitoUserPoolId = 'us-east-1_XXXXXXXXX';
  static const String cognitoClientId = 'XXXXXXXXX';
  static const bool enableCognitoAuth = true;

  // S3 File Storage
  static const String s3BucketName = 'your-app-bucket';
  static const String s3BucketRegion = 'us-east-1';
  static const bool enableS3Upload = true;

  // DynamoDB Local Sync
  static const bool enableDynamoDBSync = true;
  static const String dynamoDBTable = 'YourAppTable';

  // API Gateway
  static const String apiGatewayBaseUrl = 'https://XXXXXXXXX.execute-api.us-east-1.amazonaws.com/v1';

  // CloudWatch Logging
  static const bool enableCloudWatchLogging = true;
  static const String cloudWatchLogGroup = '/aws/amplify/your-app';

  // AWS AppSync (Optional - for real-time data)
  static const bool enableAppSync = false;
  static const String appSyncEndpoint = ''; // GraphQL endpoint URL

  // Feature Flags
  static const bool enableOfflineSync = true;
  static const bool enableBiometricAuth = true;
  static const int maxRetryAttempts = 3;
}
