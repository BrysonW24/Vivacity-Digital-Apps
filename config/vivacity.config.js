/**
 * Vivacity Digital Platform Configuration
 * Configuration for the Flutter app development platform
 */

module.exports = {
  // Application metadata
  app: {
    name: 'Vivacity Digital Platform',
    version: '1.0.0',
    description: 'App Development Platform for Small Businesses',
    environment: process.env.APP_ENV || 'development',
  },

  // Flutter & Mobile Configuration
  flutter: {
    version: '3.19.0',
    channel: 'stable',
    minSdkVersion: 21,
    targetSdkVersion: 34,
  },

  // Project Structure
  projects: {
    active: ['journal-app'],
    examples: [
      'hello_world',
      'api',
      'flutter_view',
      'image_list',
      'layers',
      'platform_channel',
      'platform_channel_swift',
      'platform_view',
      'splash',
      'texture',
      'stocks',
      'catalog',
      'flutter_gallery',
    ],
  },

  // Build Configuration
  build: {
    outputDir: 'build',
    androidDir: 'android',
    iosDir: 'ios',
    releaseMode: process.env.BUILD_MODE || 'debug',
    buildNumber: process.env.BUILD_NUMBER || '1',
    buildVersion: process.env.BUILD_VERSION || '1.0.0',
  },

  // Testing Configuration
  testing: {
    framework: 'flutter_test',
    testDir: 'test',
    coverageDir: 'coverage',
    minCoverageThreshold: 80,
    runCoverage: true,
  },

  // Firebase Configuration
  firebase: {
    enabled: true,
    projectId: process.env.FIREBASE_PROJECT_ID,
    apiKey: process.env.FIREBASE_API_KEY,
    appId: process.env.FIREBASE_APP_ID,
    measurementId: process.env.FIREBASE_MEASUREMENT_ID,
    storageBucket: process.env.FIREBASE_STORAGE_BUCKET,
    authDomain: process.env.FIREBASE_AUTH_DOMAIN,
    features: {
      authentication: true,
      firestore: true,
      realtimeDatabase: false,
      storage: true,
      analytics: true,
      crashlytics: true,
      cloudMessaging: true,
    },
  },

  // Cloud Storage Configuration
  storage: {
    type: process.env.STORAGE_TYPE || 'firebase',
    aws: {
      enabled: false,
      region: process.env.AWS_REGION || 'us-east-1',
      accessKeyId: process.env.AWS_ACCESS_KEY_ID,
      secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
      bucket: process.env.AWS_S3_BUCKET,
    },
  },

  // API Configuration
  api: {
    baseUrl: process.env.API_BASE_URL || 'http://localhost:8080',
    timeout: parseInt(process.env.API_TIMEOUT_SECONDS || '30', 10) * 1000,
    retryAttempts: 3,
    retryDelay: 1000,
  },

  // Authentication Configuration
  auth: {
    jwtSecret: process.env.JWT_SECRET_KEY,
    jwtExpirationHours: parseInt(process.env.JWT_EXPIRATION_HOURS || '24', 10),
    refreshTokenExpirationDays: parseInt(process.env.REFRESH_TOKEN_EXPIRATION_DAYS || '7', 10),
    providers: {
      google: {
        enabled: !!process.env.GOOGLE_OAUTH_CLIENT_ID,
        clientId: process.env.GOOGLE_OAUTH_CLIENT_ID,
        clientSecret: process.env.GOOGLE_OAUTH_CLIENT_SECRET,
      },
      github: {
        enabled: !!process.env.GITHUB_OAUTH_CLIENT_ID,
        clientId: process.env.GITHUB_OAUTH_CLIENT_ID,
        clientSecret: process.env.GITHUB_OAUTH_CLIENT_SECRET,
      },
    },
  },

  // Notifications Configuration
  notifications: {
    push: {
      enabled: true,
      fcmServerKey: process.env.FCM_SERVER_KEY,
    },
    email: {
      enabled: true,
      driver: process.env.MAIL_DRIVER || 'smtp',
      host: process.env.MAIL_HOST,
      port: parseInt(process.env.MAIL_PORT || '587', 10),
      username: process.env.MAIL_USERNAME,
      password: process.env.MAIL_PASSWORD,
      fromAddress: process.env.MAIL_FROM_ADDRESS,
      fromName: process.env.MAIL_FROM_NAME,
    },
  },

  // Monitoring & Logging
  monitoring: {
    sentry: {
      enabled: !!process.env.SENTRY_DSN,
      dsn: process.env.SENTRY_DSN,
    },
    crashlytics: {
      enabled: process.env.CRASHLYTICS_ENABLED === 'true',
    },
    appInsights: {
      enabled: !!process.env.APPINSIGHTS_INSTRUMENTATION_KEY,
      instrumentationKey: process.env.APPINSIGHTS_INSTRUMENTATION_KEY,
    },
  },

  // Business Settings
  business: {
    defaultPlanTier: process.env.DEFAULT_PLAN_TIER || 'standard',
    enableStripeBilling: process.env.ENABLE_STRIPE_BILLING === 'true',
    maxProjectsPerClient: process.env.MAX_PROJECTS_PER_CLIENT || 'unlimited',
    maxUsersPerOrganization: parseInt(process.env.MAX_USERS_PER_ORGANIZATION || '50', 10),
    allowCustomDomains: process.env.ALLOW_CUSTOM_DOMAINS === 'true',
  },

  // Feature Flags
  features: {
    mobileApp: process.env.FEATURE_MOBILE_APP === 'true',
    webApp: process.env.FEATURE_WEB_APP === 'true',
    api: process.env.FEATURE_API === 'true',
    analytics: process.env.FEATURE_ANALYTICS === 'true',
    exportPdf: process.env.FEATURE_EXPORT_PDF === 'true',
    exportCsv: process.env.FEATURE_EXPORT_CSV === 'true',
    offlineMode: process.env.FEATURE_OFFLINE_MODE === 'true',
  },

  // Development Settings
  development: {
    debugEnabled: process.env.APP_DEBUG === 'true',
    devtoolsEnabled: process.env.DEVTOOLS_ENABLED === 'true',
    hotReloadEnabled: process.env.HOT_RELOAD_ENABLED === 'true',
    useMockFirebase: process.env.USE_MOCK_FIREBASE === 'true',
    useMockStorage: process.env.USE_MOCK_STORAGE === 'true',
    useMockPayments: process.env.USE_MOCK_PAYMENTS === 'true',
  },

  // Docker Configuration
  docker: {
    projectName: process.env.DOCKER_COMPOSE_PROJECT_NAME || 'vivacity-digital',
    imageName: 'vivacity-digital',
    imageTag: 'latest',
    registryUrl: process.env.DOCKER_REGISTRY_URL,
  },

  // Kubernetes Configuration
  kubernetes: {
    namespace: process.env.K8S_NAMESPACE || 'default',
    ingressEnabled: process.env.K8S_INGRESS_ENABLED === 'true',
  },

  // Paths
  paths: {
    root: __dirname,
    src: 'lib',
    test: 'test',
    build: 'build',
    coverage: 'coverage',
    docs: 'docs',
  },
};
