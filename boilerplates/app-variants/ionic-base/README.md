# Ionic Base - Hybrid Mobile Boilerplate

> **Philosophy:** Built for mobile, can run on web

A production-ready Ionic boilerplate for building cross-platform mobile applications using web technologies (HTML, CSS, JavaScript/TypeScript).

## 🎯 Overview

This boilerplate is designed for teams who:
- Want one codebase for iOS, Android, and Web
- Prefer web technologies (HTML/CSS/JS)
- Need rapid cross-platform development
- Want to leverage web frameworks (Angular/React/Vue)
- Require fast time-to-market

## 🚀 Quick Start

```bash
# Navigate to template
cd boilerplates/app-variants/ionic-base

# Install dependencies
npm install

# Start development server
ionic serve

# Run on iOS
ionic cap run ios

# Run on Android
ionic cap run android
```

## 📱 What's Included

### Core Features
- ✅ **Ionic Framework** - UI components and tooling
- ✅ **Capacitor** - Native runtime
- ✅ **Angular/React/Vue** - Choose your framework
- ✅ **TypeScript** - Type safety
- ✅ **Ionic Storage** - Cross-platform storage
- ✅ **Ionic Router** - Navigation
- ✅ **PWA Support** - Progressive Web App ready
- ✅ **Native Plugins** - Camera, geolocation, etc.
- ✅ **Live Reload** - Hot reload during development

### Framework Options
This boilerplate supports multiple frameworks:
- **Angular** (default) - Full-featured framework
- **React** - Component-based UI
- **Vue** - Progressive framework

### Authentication
- Email/password authentication
- OAuth integration
- Biometric support (via Capacitor)
- Token management
- Secure storage

### Developer Experience
- ESLint + Prettier
- Git hooks
- Component scaffolding
- Debug configurations
- VS Code integration

## 🏗️ Project Structure

```
ionic-base/
├── src/
│   ├── app/              # Application core
│   ├── pages/            # Page components
│   ├── components/       # Reusable components
│   ├── services/         # Business logic services
│   ├── models/           # Data models
│   ├── guards/           # Route guards
│   ├── interceptors/     # HTTP interceptors
│   ├── theme/            # Styling and theming
│   └── assets/           # Static assets
├── capacitor.config.ts   # Capacitor configuration
├── ionic.config.json     # Ionic CLI configuration
├── package.json
└── tsconfig.json
```

## 🎨 Architecture

Clean architecture with framework-specific patterns:

```
Presentation Layer (Pages/Components)
    ↓
Service Layer (Injectable Services)
    ↓
Data Layer (HTTP/Storage)
    ↓
Models Layer (Interfaces/Types)
```

## 📦 Key Dependencies

```json
{
  "@ionic/angular": "^7.x",
  "@capacitor/core": "^5.x",
  "@capacitor/ios": "^5.x",
  "@capacitor/android": "^5.x",
  "typescript": "^5.x"
}
```

## 🔧 Configuration

### Environment Variables
```typescript
// src/environments/environment.ts
export const environment = {
  production: false,
  apiUrl: 'https://api.example.com',
  apiKey: 'your_api_key'
};
```

### Capacitor Plugins
Pre-configured plugins:
- @capacitor/camera
- @capacitor/geolocation
- @capacitor/push-notifications
- @capacitor/filesystem
- @capacitor/storage

## 📱 Platform Support

| Feature | iOS | Android | Web |
|---------|-----|---------|-----|
| Core App | ✅ | ✅ | ✅ |
| Native UI | ✅ | ✅ | 🟡 |
| Camera | ✅ | ✅ | 🟡 |
| Geolocation | ✅ | ✅ | ✅ |
| Push Notifications | ✅ | ✅ | 🟡 |

**Legend:** ✅ Full Support | 🟡 Partial Support

## 🧪 Testing

```bash
# Run unit tests
npm test

# Run E2E tests
npm run e2e

# Run with coverage
npm run test:coverage
```

## 🚢 Building for Production

```bash
# Build web version
ionic build --prod

# Sync with native projects
ionic cap sync

# Build iOS (requires macOS)
ionic cap build ios

# Build Android
ionic cap build android

# Open in native IDE
ionic cap open ios
ionic cap open android
```

## 🌐 Web Deployment

As a PWA, the app can be deployed to:
- Vercel
- Netlify
- Firebase Hosting
- AWS S3/CloudFront

```bash
# Build for web
ionic build --prod

# Deploy (example: Vercel)
vercel deploy dist/
```

## 🎯 Use Cases

**Best for:**
- Rapid cross-platform development
- Teams with web development skills
- MVPs and prototypes
- Apps with standard UI requirements
- Budget-conscious projects

**Not ideal for:**
- Graphics-intensive applications
- Apps requiring maximum performance
- Complex native integrations
- Large-scale enterprise apps (consider Flutter/React Native)

## 📊 Comparison

| Aspect | Ionic | React Native | Flutter |
|--------|-------|--------------|---------|
| Learning Curve | Easy | Medium | Medium |
| Performance | Good | Excellent | Excellent |
| Web Support | Native | Third-party | Official |
| Code Sharing | High | Medium | Medium |
| Native Look | Medium | High | High |

## 📚 Documentation

- [Ionic Framework](https://ionicframework.com/docs)
- [Capacitor](https://capacitorjs.com/docs)
- [Angular](https://angular.io/docs) (if using Angular)
- [React](https://react.dev/) (if using React)
- [Vue](https://vuejs.org/) (if using Vue)

## 🤝 Contributing

Contributions welcome! Please follow the standard Git workflow.

---

**Part of Vivacity Digital Boilerplates**
*Built for Mobile, Can Run on Web*
