# Vivacity Digital Boilerplates

Production-ready boilerplate templates for building scalable mobile and web applications with clean architecture, best practices, and comprehensive tooling.

**Current Version:** 2.0.0
**Last Updated:** December 22, 2025
**Status:** Ready for Production

---

## Table of Contents

- [Philosophy](#philosophy)
- [Quick Start](#quick-start)
- [Directory Structure](#directory-structure)
- [App-Variants (Mobile-First)](#app-variants-mobile-first)
- [Web-Variants (Web-First)](#web-variants-web-first)
- [Decision Matrix](#decision-matrix)
- [Architecture Overview](#architecture-overview)
- [Getting Started](#getting-started)
- [Paradigm Comparison](#paradigm-comparison)
- [Feature Matrix](#feature-matrix)
- [Support](#support)

---

## Philosophy

Our boilerplate collection is organized around a fundamental principle:

### **app-variants/** = "Built for Mobile, Can Run on Web"
- **Primary Target:** Native mobile experience
- **Best For:** Apps where mobile is the primary use case
- **Technologies:** Flutter, React Native, Ionic, Native (Swift/Kotlin)
- **Cross-Platform:** Can wrap for web when needed via Flutter Web or similar

### **web-variants/** = "Built for Web, Can Wrap as Mobile"
- **Primary Target:** Web-first experience
- **Best For:** Apps where web is the primary use case
- **Technologies:** React + Capacitor, Vue + Capacitor, Next.js, Static Sites
- **Cross-Platform:** Can wrap for mobile when needed via Capacitor

---

## Quick Start

### For Mobile-First Projects (app-variants)
```bash
# Flutter MVP
cd boilerplates/app-variants/flutter-small-app

# Flutter + AWS
cd boilerplates/app-variants/flutter-small-app-aws

# Flutter + GCP
cd boilerplates/app-variants/flutter-small-app-gcp

# Flutter + Kubernetes
cd boilerplates/app-variants/flutter-small-app-onpremis

# React Native
cd boilerplates/app-variants/react-native-base

# Ionic
cd boilerplates/app-variants/ionic-base

# Native (Swift/Kotlin)
cd boilerplates/app-variants/native-ios-android
```

### For Web-First Projects (web-variants)
```bash
# Next.js SSR
cd boilerplates/web-variants/next-app

# React + Capacitor
cd boilerplates/web-variants/react-capacitor

# Vue + Capacitor
cd boilerplates/web-variants/vue-capacitor

# Static Sites
cd boilerplates/web-variants/static-site

# Full-Stack Platform
cd boilerplates/web-variants/react-web-platform
```

---

## Directory Structure

```
boilerplates/
├── app-variants/                    # "Built for Mobile"
│   ├── flutter-small-app/           # Lightweight Flutter MVP
│   ├── flutter-small-app-aws/       # AWS-integrated Flutter
│   ├── flutter-small-app-gcp/       # GCP-integrated Flutter
│   ├── flutter-small-app-onpremis/  # Enterprise Kubernetes
│   ├── react-native-base/           # React Native mobile
│   ├── ionic-base/                  # Ionic hybrid
│   └── native-ios-android/          # Swift/Kotlin native
│
└── web-variants/                    # "Built for Web"
    ├── next-app/                    # Next.js SSR
    ├── react-capacitor/             # React + mobile wrapper
    ├── vue-capacitor/               # Vue + mobile wrapper
    ├── react-web-platform/          # Full-stack platform
    └── static-site/                 # Static generator
```

---

## App-Variants (Mobile-First)

> **Philosophy:** Built for mobile first, can run on web as secondary platform

### Flutter Ecosystem - Recommended

**flutter-small-app** - MVP & Learning
- Lightweight foundation
- No cloud dependencies
- Perfect for prototypes
- 400 lines per feature
- Best learning resource

**flutter-small-app-aws** - AWS Cloud
- AWS Amplify integration
- DynamoDB + S3
- Cognito auth
- Lambda functions

**flutter-small-app-gcp** - Google Cloud
- Firebase/Firestore
- Cloud Run backends
- BigQuery analytics
- Cloud Storage

**flutter-small-app-onpremis** - Enterprise
- Docker containers
- Kubernetes ready
- Self-hosted backends
- On-premise databases

### Other Mobile Frameworks

**react-native-base** - JavaScript Mobile
- Native iOS/Android
- Expo CLI
- JavaScript/TypeScript ecosystem
- Large community

**ionic-base** - Hybrid Mobile
- Angular/React/Vue options
- Web technologies (HTML/CSS/JS)
- Rapid cross-platform dev

**native-ios-android** - Maximum Performance
- Swift (iOS) + Kotlin (Android)
- Platform-specific optimization
- Direct hardware access

---

## Web-Variants (Web-First)

> **Philosophy:** Built for web first, can wrap as mobile with Capacitor

### Server-Side Rendered

**next-app** - Next.js SSR
- Server-side rendering
- Static generation
- API routes
- Vercel-ready
- SEO optimized

### Web + Mobile Wrapper

**react-capacitor** - React Web to Mobile
- React as primary
- Capacitor for iOS/Android
- Single codebase
- Native API access

**vue-capacitor** - Vue Web to Mobile
- Vue as primary
- Capacitor for iOS/Android
- Single codebase
- Progressive enhancement

### Platforms & Static

**react-web-platform** - Enterprise Web
- Full-stack React
- Monorepo structure
- Admin dashboards
- Complex workflows

**static-site** - JAMstack
- Static generation
- CDN-friendly
- Markdown content
- Blogs and docs

---

## Decision Matrix

| Your Need | Choose This | Why |
|-----------|-------------|-----|
| Mobile MVP | `flutter-small-app` | Fast, simple, no cloud |
| AWS Cloud Mobile | `flutter-small-app-aws` | AWS integrations |
| Firebase Mobile | `flutter-small-app-gcp` | Firestore ready |
| Enterprise Mobile | `flutter-small-app-onpremis` | Kubernetes/Docker |
| JavaScript Mobile | `react-native-base` | JS ecosystem |
| Quick Hybrid | `ionic-base` | Fast cross-platform |
| Max Performance | `native-ios-android` | Native code |
| Web with SEO | `next-app` | SSR, static gen |
| React to Mobile | `react-capacitor` | Single React codebase |
| Vue to Mobile | `vue-capacitor` | Single Vue codebase |
| Web Platform | `react-web-platform` | Enterprise web |
| Blog/Docs | `static-site` | JAMstack |

---

## Architecture Overview

All boilerplates follow **Clean Architecture** (5 layers):

```
┌─────────────────────────────────────┐
│  PRESENTATION (Screens/Widgets)    │
└──────────────┬──────────────────────┘
               ↓
┌──────────────▼──────────────────────┐
│  STATE MANAGEMENT (Providers)      │
└──────────────┬──────────────────────┘
               ↓
┌──────────────▼──────────────────────┐
│  REPOSITORY (Data Access)          │
└──────────────┬──────────────────────┘
               ↓
┌──────────────▼──────────────────────┐
│  SERVICES (Business Logic)         │
└──────────────┬──────────────────────┘
               ↓
┌──────────────▼──────────────────────┐
│  MODELS (Data Structures)          │
└─────────────────────────────────────┘
```

**Layer Rules:**
- Each layer only depends on the layer below
- Models have no dependencies
- Services contain business logic
- State management handles app state
- UI is completely separated

---

## Getting Started

### Prerequisites

**Mobile (app-variants):**
- Flutter: Dart SDK 3.0+, Flutter 3.10+
- React Native: Node.js 16+, Expo CLI
- Ionic: Node.js 16+, Ionic CLI
- Native: Xcode 14+ / Android Studio

**Web (web-variants):**
- Node.js 16+ or 18 LTS
- npm 8+ (or yarn/pnpm)
- Git

### Basic Setup

```bash
# 1. Navigate to chosen boilerplate
cd boilerplates/app-variants/flutter-small-app

# 2. Install dependencies
flutter pub get  # Flutter
npm install      # Web/React Native

# 3. Run
flutter run      # Flutter
npm start        # Web/React Native
```

---

## Paradigm Comparison

### Choose Mobile-First (app-variants) When:
- Mobile is your primary platform
- Need native performance
- Offline functionality critical
- Hardware access required (camera, GPS, sensors)
- App store distribution is primary

**Examples:** Fitness apps, maps, social media, games

### Choose Web-First (web-variants) When:
- Web is your primary platform
- SEO is important
- Frequent updates needed
- Browser-based distribution
- Desktop experience matters

**Examples:** E-commerce, SaaS, blogs, documentation

### Hybrid Strategy (web-variants + Capacitor):
- Web development team
- Need mobile apps eventually
- Single codebase priority
- Progressive enhancement approach

---

## Feature Matrix

| Feature | Flutter | React Native | Ionic | Native | Next.js | Capacitor |
|---------|---------|--------------|-------|--------|---------|-----------|
| **Mobile App** | Yes | Yes | Yes | Yes | Partial | Yes |
| **Web App** | Partial | Partial | Yes | No | Yes | Yes |
| **Desktop** | Partial | Partial | No | No | Partial | No |
| **Performance** | Excellent | Excellent | Good | Excellent | Good | Good |
| **Learning Curve** | Moderate | Easy | Easy | Moderate | Easy | Easy |
| **Team Size** | Small | Medium | Small | Small | Medium | Medium |
| **Time to MVP** | Fast | Medium | Fast | Slow | Fast | Medium |

---

## Common Features

All boilerplates include:

**Authentication:**
- Email/password login
- Social login support
- Biometric auth
- Token management
- Secure storage

**Data Management:**
- HTTP client with interceptors
- Local database (SQLite/IndexedDB)
- Caching strategies
- Offline support
- JSON serialization

**UI/UX:**
- Responsive design
- Dark mode support
- Accessibility ready
- Loading/error states
- Toast notifications

**Developer Tools:**
- Code generation
- Linting & formatting
- Example implementations
- Environment configs
- Git hooks

---

## Support

**Resources:**
- See individual template READMEs
- GitHub Issues
- GitHub Discussions
- support@vivacitydigital.com

**Troubleshooting:**

Flutter:
```bash
flutter clean && flutter pub get && flutter run
```

Web:
```bash
rm -rf node_modules && npm install && npm run dev
```

---

## License

MIT License - See individual template LICENSE files

---

**Vivacity Digital**

*Version 2.0.0 | December 22, 2025*
