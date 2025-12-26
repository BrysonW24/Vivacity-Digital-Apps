# Flutter Small App Boilerplate - Upgrade Guide

This guide provides step-by-step instructions for upgrading your Flutter app that's based on this boilerplate to newer versions.

## General Upgrade Process

### 1. Before Upgrading

```bash
# Create a backup branch
git checkout -b backup/current-version

# Update your CHANGELOG.md (optional)
# Review all changes between versions
```

### 2. Review Changes

Always review the differences between versions in `.boilerplate/CHANGELOG.md` to understand:
- Breaking changes
- New features
- Deprecated functionality
- Security updates

### 3. Run Automated Checks

```bash
# Check boilerplate structure
bash scripts/health-check.sh

# Audit dependencies
bash scripts/update-deps.sh --audit
```

## Upgrading Between Versions

### 1.0.0 to 1.1.0 (When Available)

> **Timeline**: Follow this upgrade path when version 1.1.0 is released

#### Step 1: Backup Your Code

```bash
git checkout -b backup/pre-1.1.0-upgrade
git add .
git commit -m "Backup before 1.1.0 upgrade"
```

#### Step 2: Update Boilerplate Files

```bash
# Pull latest boilerplate changes
git pull origin main

# Review new files in .boilerplate/
ls -la .boilerplate/
```

#### Step 3: Update Configuration Files

Expected changes in:
- `pubspec.yaml` - Dependency versions
- `analysis_options.yaml` - Linter rules
- `.env.production` - Environment variables

```bash
# Compare your config files with boilerplate
diff pubspec.yaml .boilerplate/pubspec.yaml.template
```

#### Step 4: Update Dependencies

```bash
flutter pub upgrade
flutter pub get

# Run code generation if models changed
flutter pub run build_runner build --delete-conflicting-outputs
```

#### Step 5: Run Tests

```bash
# Run all tests
flutter test

# Check for lint issues
flutter analyze
```

#### Step 6: Update VERSION File

```bash
# Update the version in .boilerplate/VERSION
echo "1.1.0" > .boilerplate/VERSION

# Commit changes
git add .
git commit -m "chore: upgrade boilerplate to 1.1.0"
```

## Handling Breaking Changes

### Example: Architecture Layer Changes

If a new version introduces changes to the repository pattern:

1. **Identify affected files**
   ```bash
   grep -r "BaseRepository" lib/repositories/
   ```

2. **Update base class**
   ```dart
   // Old pattern
   class UserRepository extends BaseRepository {
     // ...
   }

   // New pattern (if changed)
   class UserRepository {
     // Use composition instead of inheritance
     final BaseRepository _base;
     // ...
   }
   ```

3. **Update dependent code**
   - Update providers that use the repository
   - Update services that use the repository
   - Run tests to verify

4. **Document changes**
   ```bash
   # Add note to your project's CHANGELOG
   echo "- Updated UserRepository to new pattern" >> CHANGELOG.md
   ```

## Dependency Updates

### Minor Version Updates (Safe)

These are typically safe to apply automatically:

```bash
# Update patch versions for all dependencies
flutter pub upgrade --null-safety

# Get specific dependency update
flutter pub upgrade provider
```

### Major Version Updates (Review Required)

Always review before updating major versions:

```bash
# Check what would be updated
flutter pub upgrade --dry-run

# Review breaking changes for specific package
# Visit https://pub.dev/packages/[package-name]/changelog
```

### Emergency Security Updates

For critical security vulnerabilities:

```bash
# Update immediately
flutter pub upgrade [affected-package]

# Run tests to ensure no breakage
flutter test

# Commit immediately
git add pubspec.lock
git commit -m "security: update [package-name] to patch vulnerability"
```

## Rollback Procedure

If an upgrade causes issues:

### Option 1: Git Rollback

```bash
# If you haven't committed
git reset --hard HEAD

# If you've committed
git revert HEAD
git push origin main
```

### Option 2: Restore from Backup Branch

```bash
# Switch back to backup
git checkout backup/pre-1.1.0-upgrade

# Create new branch from backup
git checkout -b main-rollback
git push origin main-rollback
```

### Option 3: Selective Rollback

If only specific files need rollback:

```bash
# Restore specific file
git checkout backup/pre-1.1.0-upgrade -- lib/repositories/user_repository.dart

# Or restore specific directory
git checkout backup/pre-1.1.0-upgrade -- lib/services/
```

## Common Upgrade Issues

### Issue 1: Dependency Conflicts

**Error**: `version solving failed`

**Solution**:
```bash
# Clear pub cache
flutter pub cache clean

# Get dependencies again
flutter pub get

# If still failing, check constraints
flutter pub outdated

# Manual constraint adjustment in pubspec.yaml
dependencies:
  provider: ^6.0.0  # Update version constraint if needed
```

### Issue 2: Code Generation Errors

**Error**: `freezed` or `json_serializable` build failures

**Solution**:
```bash
# Clean build
flutter clean

# Rebuild models
flutter pub run build_runner build --delete-conflicting-outputs

# If still failing, update generator packages
flutter pub upgrade build_runner freezed json_serializable
```

### Issue 3: Import Path Errors

**Error**: `Target of URI doesn't exist`

**Solution**:
```bash
# Verify file exists at expected location
ls -la lib/services/api_client.dart

# Check for moved/renamed files in CHANGELOG
grep -i "renamed\|moved" .boilerplate/CHANGELOG.md

# Update import paths if files were reorganized
# Old: import '../api_client.dart';
# New: import '../services/api/api_client.dart';
```

## Platform-Specific Updates

### iOS Deployment Target Update

If minimum iOS version is increased:

```yaml
# ios/Podfile
platform :ios, '12.0'  # Update if boilerplate requires higher
```

```bash
cd ios
pod repo update
pod install --repo-update
cd ..
```

### Android Min/Target SDK Update

If minimum Android SDK is increased:

```gradle
// android/app/build.gradle
minSdkVersion 21  // Update if boilerplate requires higher
targetSdkVersion 34
```

## Post-Upgrade Verification

### Checklist

- [ ] All tests pass: `flutter test`
- [ ] No lint issues: `flutter analyze`
- [ ] No build warnings: `flutter build apk --verbose` (preview)
- [ ] Verify hot reload works
- [ ] Test all major screens
- [ ] Check splash screen appears correctly
- [ ] Verify theme switching works
- [ ] Test authentication flow
- [ ] Confirm API calls work
- [ ] Review native code (if any changes required)

### Verification Script

```bash
#!/bin/bash
echo "Running upgrade verification..."

echo "✓ Checking Flutter environment"
flutter doctor

echo "✓ Running tests"
flutter test

echo "✓ Analyzing code"
flutter analyze

echo "✓ Building APK (preview)"
flutter build apk --debug --no-shrink 2>&1 | head -20

echo "✓ Verification complete!"
```

## Documentation Updates

After upgrading, update your project documentation:

1. **Update README.md** with new features
2. **Update Architecture Decisions** if changes warrant
3. **Update Team Knowledge Base** with breaking changes
4. **Create Migration Guide** for other developers

### Example README Update

```markdown
## Boilerplate Version

- **Current Version**: 1.1.0
- **Last Updated**: 2025-12-15
- **Key Changes**: [Brief summary of version highlights]
- **Migration Notes**: See UPGRADE_GUIDE.md for migration steps
```

## Getting Help

### Resources

1. **Check CHANGELOG.md**: Detailed changes in `.boilerplate/CHANGELOG.md`
2. **Review Issues**: Check GitHub issues for known problems
3. **Test Suite**: Run tests to identify problem areas
4. **Architecture Decisions**: Review `docs/DECISIONS.md` for rationale

### Reporting Upgrade Issues

When reporting issues:

1. **Include version numbers**
   - Current boilerplate version
   - Flutter version (`flutter --version`)
   - Dart version (`dart --version`)

2. **Provide error output**
   ```bash
   flutter doctor -v
   flutter analyze
   flutter test --verbose
   ```

3. **Create minimal example**
   - Isolated test case demonstrating issue
   - Steps to reproduce

## Version Support Policy

### Active Support

- **Latest Version**: Receives all updates and fixes
- **Previous Major Version**: Security fixes only
- **Older Versions**: No official support

### End of Life (EOL)

Versions are EOL when:
- Marked as EOL in CHANGELOG.md
- No security patches will be released
- Consider upgrading to latest version

## Automation

### Scheduled Dependency Checks

Consider setting up automation:

```bash
#!/bin/bash
# scripts/check-updates.sh - Run weekly via cron

echo "Checking for boilerplate updates..."
git fetch origin

if git log --oneline -1 origin/main | grep -q "boilerplate"; then
    echo "New boilerplate updates available!"
    # Notify team
fi

echo "Checking for dependency updates..."
flutter pub outdated
```

---

**Last Updated**: 2025-12-01
**For Issues**: Check the project's issue tracker or contact the team
