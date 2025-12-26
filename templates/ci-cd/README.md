# CI/CD Configurations

Production-ready continuous integration and deployment pipeline configurations for automated builds, testing, and releases.

## Overview

This directory contains CI/CD pipeline templates for popular platforms. These configurations automate the build, test, and deployment processes, ensuring consistent and reliable software delivery.

## Available Configurations

### GitHub Actions (`configs/github_actions.yml`)

GitHub Actions workflow configuration featuring:
- Multi-platform builds (iOS, Android, Web)
- Automated testing
- Code quality checks
- Deployment automation
- Release management

### GitLab CI (`configs/gitlab_ci.yml`)

GitLab CI/CD pipeline with:
- Multi-stage pipeline
- Docker support
- Parallel job execution
- Environment-specific deployments
- Artifact management

### Bitrise (`configs/bitrise_pipeline.yml`)

Bitrise configuration for mobile apps:
- iOS and Android builds
- Code signing
- App store deployment
- Beta distribution
- Automated screenshots

## Quick Start

### Copy Configuration

```bash
# GitHub Actions
mkdir -p .github/workflows
cp templates/ci-cd/configs/github_actions.yml .github/workflows/main.yml

# GitLab CI
cp templates/ci-cd/configs/gitlab_ci.yml .gitlab-ci.yml

# Bitrise
cp templates/ci-cd/configs/bitrise_pipeline.yml bitrise.yml
```

### Configure Secrets

Each platform requires specific secrets/variables:

#### GitHub Actions
```bash
# Repository Settings > Secrets and variables > Actions
APPLE_CERTIFICATE          # iOS code signing certificate
APPLE_PROVISIONING_PROFILE # iOS provisioning profile
GOOGLE_SERVICES_JSON       # Android Firebase config
FIREBASE_TOKEN             # Firebase deployment token
```

#### GitLab CI
```bash
# Settings > CI/CD > Variables
CI_REGISTRY_USER          # Container registry username
CI_REGISTRY_PASSWORD      # Container registry password
DEPLOYMENT_KEY            # SSH key for deployment
```

#### Bitrise
```bash
# Workflow > Secrets
BITRISEIO_ANDROID_KEYSTORE_URL
BITRISEIO_ANDROID_KEYSTORE_PASSWORD
APPLE_CERTIFICATE_URL
APPLE_CERTIFICATE_PASSWORD
```

## Pipeline Stages

### 1. Build Stage

Compiles the application and prepares artifacts.

**GitHub Actions:**
```yaml
build:
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v3
    - uses: subosito/flutter-action@v2
    - run: flutter pub get
    - run: flutter build apk --release
```

**GitLab CI:**
```yaml
build:
  stage: build
  script:
    - flutter pub get
    - flutter build apk --release
  artifacts:
    paths:
      - build/app/outputs/
```

### 2. Test Stage

Runs automated tests and quality checks.

**Example:**
```yaml
test:
  runs-on: ubuntu-latest
  steps:
    - run: flutter test --coverage
    - run: flutter analyze
    - uses: codecov/codecov-action@v3
```

### 3. Deploy Stage

Deploys to staging or production environments.

**Example:**
```yaml
deploy:
  if: github.ref == 'refs/heads/main'
  runs-on: ubuntu-latest
  steps:
    - run: firebase deploy --only hosting
```

## Platform-Specific Guides

### GitHub Actions

#### Flutter Web Deployment

```yaml
name: Deploy Flutter Web

on:
  push:
    branches: [main]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'

      - name: Install dependencies
        run: flutter pub get

      - name: Build web
        run: flutter build web --release

      - name: Deploy to Firebase
        uses: FirebaseExtended/action-hosting-deploy@v0
        with:
          repoToken: '${{ secrets.GITHUB_TOKEN }}'
          firebaseServiceAccount: '${{ secrets.FIREBASE_SERVICE_ACCOUNT }}'
          channelId: live
```

#### React Deployment

```yaml
name: Deploy React App

on:
  push:
    branches: [main]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Install dependencies
        run: npm ci

      - name: Run tests
        run: npm test

      - name: Build
        run: npm run build

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./build
```

#### Android Release

```yaml
name: Android Release

on:
  push:
    tags:
      - 'v*'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - uses: actions/setup-java@v3
        with:
          distribution: 'zulu'
          java-version: '17'

      - uses: subosito/flutter-action@v2

      - name: Decode keystore
        run: |
          echo "${{ secrets.KEYSTORE_BASE64 }}" | base64 -d > android/app/keystore.jks

      - name: Build APK
        run: flutter build apk --release
        env:
          KEYSTORE_PASSWORD: ${{ secrets.KEYSTORE_PASSWORD }}
          KEY_ALIAS: ${{ secrets.KEY_ALIAS }}
          KEY_PASSWORD: ${{ secrets.KEY_PASSWORD }}

      - name: Upload to Play Store
        uses: r0adkll/upload-google-play@v1
        with:
          serviceAccountJsonPlainText: ${{ secrets.SERVICE_ACCOUNT_JSON }}
          packageName: com.example.app
          releaseFiles: build/app/outputs/bundle/release/app-release.aab
          track: internal
```

### GitLab CI

#### Multi-Stage Pipeline

```yaml
stages:
  - build
  - test
  - deploy

variables:
  FLUTTER_VERSION: "3.16.0"

before_script:
  - git clone https://github.com/flutter/flutter.git -b stable
  - export PATH="$PATH:`pwd`/flutter/bin"
  - flutter doctor -v

build:
  stage: build
  script:
    - flutter pub get
    - flutter build web --release
  artifacts:
    paths:
      - build/web/
    expire_in: 1 week

test:
  stage: test
  script:
    - flutter test --coverage
    - flutter analyze
  coverage: '/lines\.*: \d+\.\d+%/'

deploy_staging:
  stage: deploy
  script:
    - echo "Deploy to staging"
    - firebase deploy --only hosting:staging
  environment:
    name: staging
    url: https://staging.example.com
  only:
    - develop

deploy_production:
  stage: deploy
  script:
    - echo "Deploy to production"
    - firebase deploy --only hosting:production
  environment:
    name: production
    url: https://example.com
  only:
    - main
  when: manual
```

### Bitrise

#### iOS Build Configuration

```yaml
format_version: '11'
default_step_lib_source: https://github.com/bitrise-io/bitrise-steplib.git

workflows:
  primary:
    steps:
    - activate-ssh-key@4:
        run_if: '{{getenv "SSH_RSA_PRIVATE_KEY" | ne ""}}'

    - git-clone@8: {}

    - flutter-installer@0:
        inputs:
        - version: stable

    - flutter-build@0:
        inputs:
        - platform: ios
        - ios_output_type: archive

    - certificate-and-profile-installer@1: {}

    - xcode-archive@4:
        inputs:
        - project_path: ios/Runner.xcodeproj
        - scheme: Runner
        - export_method: app-store

    - deploy-to-bitrise-io@2: {}

    - deploy-to-itunesconnect-application-loader@1:
        inputs:
        - itunescon_user: $APPLE_ID
        - password: $APPLE_PASSWORD
```

## Advanced Configurations

### Matrix Builds

Test across multiple versions:

```yaml
strategy:
  matrix:
    os: [ubuntu-latest, macos-latest, windows-latest]
    flutter-version: ['3.13.0', '3.16.0']

runs-on: ${{ matrix.os }}
steps:
  - uses: subosito/flutter-action@v2
    with:
      flutter-version: ${{ matrix.flutter-version }}
```

### Conditional Deployments

```yaml
deploy:
  if: |
    github.event_name == 'push' &&
    github.ref == 'refs/heads/main' &&
    !contains(github.event.head_commit.message, '[skip ci]')
```

### Parallel Jobs

```yaml
jobs:
  build-android:
    runs-on: ubuntu-latest
    steps:
      - run: flutter build apk

  build-ios:
    runs-on: macos-latest
    steps:
      - run: flutter build ios

  build-web:
    runs-on: ubuntu-latest
    steps:
      - run: flutter build web
```

## Environment Management

### Environment Variables

```yaml
env:
  API_URL: ${{ secrets.API_URL }}
  ENVIRONMENT: production
  BUILD_NUMBER: ${{ github.run_number }}
```

### Multiple Environments

```yaml
deploy-staging:
  environment:
    name: staging
    url: https://staging.example.com
  variables:
    API_URL: https://api.staging.example.com

deploy-production:
  environment:
    name: production
    url: https://example.com
  variables:
    API_URL: https://api.example.com
```

## Caching

Speed up builds with caching:

### GitHub Actions
```yaml
- uses: actions/cache@v3
  with:
    path: |
      ~/.pub-cache
      **/.flutter-plugins
      **/.flutter-plugin-dependencies
    key: ${{ runner.os }}-pub-${{ hashFiles('**/pubspec.lock') }}
    restore-keys: |
      ${{ runner.os }}-pub-
```

### GitLab CI
```yaml
cache:
  key: ${CI_COMMIT_REF_SLUG}
  paths:
    - .pub-cache/
    - node_modules/
```

## Notifications

### Slack Notifications (GitHub Actions)

```yaml
- name: Slack notification
  uses: 8398a7/action-slack@v3
  with:
    status: ${{ job.status }}
    text: 'Build ${{ job.status }}'
    webhook_url: ${{ secrets.SLACK_WEBHOOK }}
  if: always()
```

### Email Notifications (GitLab)

```yaml
deploy:
  script:
    - ./deploy.sh
  after_script:
    - echo "Deployment complete" | mail -s "Deployment Status" team@example.com
```

## Security Best Practices

### Secrets Management
- Never commit secrets to repository
- Use platform-specific secret management
- Rotate secrets regularly
- Limit secret access by environment

### Code Signing
```yaml
# Securely handle certificates
- name: Import certificate
  run: |
    echo "${{ secrets.CERTIFICATE_BASE64 }}" | base64 -d > certificate.p12
    security import certificate.p12 -P "${{ secrets.CERTIFICATE_PASSWORD }}"
  # Clean up after
  - run: rm certificate.p12
```

### Dependency Scanning

```yaml
- name: Dependency check
  run: flutter pub outdated

- name: Security audit
  run: |
    flutter pub global activate pana
    pana --no-warning
```

## Testing in CI

### Unit Tests
```yaml
- name: Run unit tests
  run: flutter test --coverage
```

### Integration Tests
```yaml
- name: Run integration tests
  run: flutter test integration_test/
```

### E2E Tests
```yaml
- name: Run E2E tests
  run: |
    flutter drive --driver=test_driver/integration_test.dart \
                  --target=integration_test/app_test.dart
```

## Performance Optimization

### Build Time Reduction
- Use caching effectively
- Parallelize independent jobs
- Use incremental builds
- Optimize Docker images

### Resource Management
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 30
    strategy:
      max-parallel: 3
```

## Troubleshooting

### Common Issues

**Build Fails on Dependencies:**
```yaml
# Clear cache and retry
- run: flutter pub cache repair
- run: flutter pub get
```

**Certificate Issues (iOS):**
```yaml
# Verify certificate installation
- run: security find-identity -v -p codesigning
```

**Deployment Failures:**
```yaml
# Add verbose logging
- run: flutter build apk --verbose
```

## Monitoring and Analytics

### Build Metrics
```yaml
- name: Upload metrics
  run: |
    echo "Build time: $SECONDS" >> metrics.log
    cat metrics.log
```

### Coverage Reports
```yaml
- uses: codecov/codecov-action@v3
  with:
    files: coverage/lcov.info
    flags: unittests
```

## Best Practices

### Pipeline Design
- Keep pipelines fast (<10 minutes)
- Fail fast on critical errors
- Use parallel execution
- Cache dependencies
- Clean up resources

### Branching Strategy
- Main branch: Production deployments
- Develop branch: Staging deployments
- Feature branches: Build and test only
- Tags: Release builds

### Version Management
```yaml
- name: Get version
  run: |
    VERSION=$(grep 'version:' pubspec.yaml | cut -d ' ' -f 2)
    echo "APP_VERSION=$VERSION" >> $GITHUB_ENV
```

## Resources

### Documentation
- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [GitLab CI/CD Docs](https://docs.gitlab.com/ee/ci/)
- [Bitrise Docs](https://devcenter.bitrise.io/)

### Tools
- [act](https://github.com/nektos/act) - Run GitHub Actions locally
- [gitlab-runner](https://docs.gitlab.com/runner/) - Run GitLab CI locally

## Support

For CI/CD configuration help:
1. Review platform documentation
2. Check pipeline logs
3. Validate YAML syntax
4. Contact Vivacity Digital team

---

**Vivacity Digital** - Automated CI/CD Solutions
