# Vivacity Digital - App Templates

Three production-ready Flutter app templates for different project scopes and budgets.

## Template Tiers

### 1. Micro-Budget Template (`micro-budget/`)
**For:** Simple 6-page apps, MVPs, proof-of-concepts
**Timeline:** 1-2 weeks
**Budget:** $500-2,000

**Includes:**
- 6 essential pages (Home, List, Detail, Settings, About, Contact)
- Bottom navigation
- Basic theme support (light/dark mode)
- Local storage (SharedPreferences)
- Minimal dependencies
- Android & iOS support

**Use When:**
- Client needs a simple informational app
- Quick MVP to test market
- Limited budget
- Static content focus

---

### 2. Standard Template (`standard/`)
**For:** Business apps, client projects, full-featured apps
**Timeline:** 4-8 weeks
**Budget:** $5,000-15,000

**Includes:**
- Everything from Micro +
- Authentication (email/password, social login)
- Database integration (SQLite/Firebase)
- API integration & networking
- State management (Riverpod)
- Forms & validation
- Push notifications
- Image uploads
- Search functionality
- Polished UI/UX

**Use When:**
- Client needs user accounts
- Database/backend integration required
- Professional polish needed
- Multiple user flows

---

### 3. Premium Template (`premium/`)
**For:** Enterprise apps, complex apps, AI-powered apps
**Timeline:** 12+ weeks
**Budget:** $25,000+

**Includes:**
- Everything from Standard +
- AI/ML integration
- Advanced animations
- Offline-first architecture
- Analytics & crash reporting
- In-app purchases
- Multi-language support
- Advanced state management
- CI/CD pipeline
- Comprehensive testing
- Admin dashboard

**Use When:**
- Enterprise client
- Complex business logic
- AI features needed
- Scalability is priority
- Premium user experience required

---

## Usage

### Quick Start

1. **Choose your template tier** based on project scope
2. **Copy the template:**
   ```bash
   cd Vivacity-Digital-Apps/client-projects/templates

   # For micro-budget
   cp -r micro-budget/simple-mobile-app ../active/your-project-name

   # For standard
   cp -r standard/business-mobile-app ../active/your-project-name

   # For premium
   cp -r premium/ai-enhanced-mobile ../active/your-project-name
   ```

3. **Rebrand the app:**
   - Update `pubspec.yaml` (name, description)
   - Update Android package name (`android/app/build.gradle.kts`)
   - Update iOS bundle ID (`ios/Runner.xcodeproj/project.pbxproj`)
   - Replace app icons and splash screens
   - Update theme colors

4. **Install dependencies:**
   ```bash
   cd ../active/your-project-name
   flutter pub get
   ```

5. **Run the app:**
   ```bash
   flutter run
   ```

---

## Rebranding Checklist

### Essential Changes
- [ ] Update app name in `pubspec.yaml`
- [ ] Change Android `applicationId`
- [ ] Change iOS `PRODUCT_BUNDLE_IDENTIFIER`
- [ ] Replace app icons
- [ ] Update splash screen
- [ ] Modify theme colors
- [ ] Update About page with client info
- [ ] Configure backend URLs/API keys

### Android Specific
```kotlin
// android/app/build.gradle.kts
applicationId = "com.yourclient.appname"
```

### iOS Specific
```
// ios/Runner/Info.plist
<key>CFBundleDisplayName</key>
<string>Your App Name</string>
```

---

## Template Maintenance

### When to Update Templates
- New Flutter version released
- Package updates available
- Bug fixes discovered
- New best practices emerge

### Template Structure
```
templates/
├── micro-budget/
│   └── simple-mobile-app/       # 6-page minimal app
├── standard/
│   └── business-mobile-app/     # Full-featured business app
├── premium/
│   └── ai-enhanced-mobile/      # Enterprise-grade app
└── README.md (this file)
```

---

## Creating a New Project

### From Micro Template
```bash
# Copy template
cp -r templates/micro-budget/simple-mobile-app client-projects/active/client-app

# Rebrand
cd client-projects/active/client-app
# Use find/replace to change app name throughout codebase

# Setup
flutter pub get
flutter run
```

### From Standard Template
```bash
cp -r templates/standard/business-mobile-app client-projects/active/client-app
cd client-projects/active/client-app

# Configure backend
# Update API URLs in lib/config/environment.dart
# Setup Firebase (if using)

flutter pub get
flutter run
```

### From Premium Template
```bash
cp -r templates/premium/ai-enhanced-mobile client-projects/active/client-app
cd client-projects/active/client-app

# Full setup required
# Configure all services (Firebase, Analytics, AI APIs, etc.)
# Setup CI/CD
# Configure environments (dev/staging/prod)

flutter pub get
flutter run
```

---

## Next Steps After Copying

1. **Customize Content** - Replace placeholder text and images
2. **Configure Backend** - Set up APIs, databases, auth
3. **Test Thoroughly** - Run on multiple devices
4. **Setup Signing** - Generate keystores for release
5. **Prepare Store Listings** - Screenshots, descriptions
6. **Deploy** - Build and upload to stores

---

**Need Help?** Contact the Vivacity Digital team for template assistance.
