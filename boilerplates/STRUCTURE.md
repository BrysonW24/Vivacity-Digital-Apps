# Boilerplate Structure Overview

This document provides a complete overview of the Vivacity Digital boilerplate structure and philosophy.

## 🎯 Core Philosophy

### The Logic

```
app-variants/  = "Built for Mobile, Can Run on Web"
web-variants/  = "Built for Web, Can Wrap as Mobile"
```

This fundamental distinction drives all architectural decisions and helps teams choose the right starting point for their projects.

---

## 📱 App-Variants (Mobile-First)

**Philosophy:** Native mobile experience first, web as secondary platform

### Available Templates

| Template | Status | Purpose | Tech Stack |
|----------|--------|---------|------------|
| `flutter-small-app` | ✅ Active | MVP/Learning | Flutter + Dart |
| `flutter-small-app-aws` | ✅ Active | AWS Cloud | Flutter + AWS Amplify |
| `flutter-small-app-gcp` | ✅ Active | Google Cloud | Flutter + Firebase |
| `flutter-small-app-onpremis` | ✅ Active | Enterprise/K8s | Flutter + Docker |
| `react-native-base` | ✅ New | JavaScript Mobile | React Native + Expo |
| `ionic-base` | ✅ New | Hybrid Mobile | Ionic + Capacitor |
| `native-ios-android` | ✅ New | Maximum Performance | Swift + Kotlin |

### Template Breakdown

#### Flutter Ecosystem (4 variants)
- **Shared Foundation:** All use same clean architecture (5 layers)
- **Differentiator:** Cloud provider integration
- **Best For:** Teams wanting one mobile stack with flexible backend

#### React Native
- **Framework:** React Native + Expo
- **Best For:** JavaScript teams, npm ecosystem
- **Cross-Platform:** iOS + Android from single codebase
- **README:** ✅ Complete

#### Ionic
- **Framework:** Ionic + Capacitor (Angular/React/Vue options)
- **Best For:** Web developers, rapid prototyping
- **Cross-Platform:** iOS + Android + Web
- **README:** ✅ Complete

#### Native
- **Platforms:** Swift (iOS) + Kotlin (Android)
- **Best For:** Performance-critical apps, platform-specific features
- **Cross-Platform:** Separate codebases
- **README:** ✅ Complete

---

## 🌐 Web-Variants (Web-First)

**Philosophy:** Web experience first, mobile via wrapper when needed

### Available Templates

| Template | Status | Purpose | Tech Stack |
|----------|--------|---------|------------|
| `next-app` | ✅ Active | SSR Web | Next.js + React |
| `react-web-platform` | ✅ Active | Enterprise Web | React Monorepo |
| `react-capacitor` | ✅ New | React → Mobile | React + Capacitor |
| `vue-capacitor` | ✅ New | Vue → Mobile | Vue 3 + Capacitor |
| `static-site` | ✅ New | JAMstack | Astro + Markdown |

### Template Breakdown

#### Next.js
- **Rendering:** Server-side + Static
- **Best For:** Traditional web apps, SEO-critical sites
- **Deployment:** Vercel-optimized
- **README:** ✅ Existing

#### React Web Platform
- **Structure:** Monorepo, multiple services
- **Best For:** Large-scale web applications
- **Features:** Admin dashboards, complex workflows
- **README:** ✅ Existing

#### React + Capacitor
- **Primary:** Web application (React)
- **Secondary:** iOS + Android via Capacitor wrapper
- **Best For:** React teams needing mobile presence
- **README:** ✅ Complete

#### Vue + Capacitor
- **Primary:** Web application (Vue 3)
- **Secondary:** iOS + Android via Capacitor wrapper
- **Best For:** Vue teams needing mobile presence
- **README:** ✅ Complete

#### Static Site
- **Generator:** Astro
- **Best For:** Blogs, docs, marketing sites
- **Performance:** Perfect Lighthouse scores
- **README:** ✅ Complete

---

## 📊 Decision Matrix

### Choose App-Variants When:

✅ Mobile is your primary target platform
✅ Need native device features (camera, GPS, sensors)
✅ Offline functionality is critical
✅ App store distribution is required
✅ Native performance matters

**Examples:** Fitness apps, maps, social media, messaging, games

### Choose Web-Variants When:

✅ Web is your primary target platform
✅ SEO is important
✅ Frequent updates without app store approval
✅ Desktop/laptop experience matters
✅ Browser-based distribution preferred

**Examples:** E-commerce, SaaS platforms, blogs, documentation, admin panels

### Hybrid Approach:

Use **web-variants** with Capacitor when:
- Web development team
- Need mobile apps eventually
- Single codebase priority
- SEO + mobile presence both important

---

## 🏗️ Architecture Comparison

### Mobile-First (App-Variants)

```
┌─────────────────────────────────────┐
│  Native UI (Platform-Specific)     │
│  iOS: SwiftUI  |  Android: Compose  │
└──────────────┬──────────────────────┘
               ↓
┌──────────────▼──────────────────────┐
│  Application Layer (Business Logic) │
└──────────────┬──────────────────────┘
               ↓
┌──────────────▼──────────────────────┐
│  Data Layer (API + Local Storage)  │
└─────────────────────────────────────┘
```

### Web-First (Web-Variants)

```
┌─────────────────────────────────────┐
│  Web UI (HTML/CSS/JS)               │
│  React/Vue/Astro Components         │
└──────────────┬──────────────────────┘
               ↓
┌──────────────▼──────────────────────┐
│  State Management (Client)          │
└──────────────┬──────────────────────┘
               ↓
┌──────────────▼──────────────────────┐
│  API Layer (REST/GraphQL)           │
└──────────────┬──────────────────────┘
               ↓
┌──────────────▼──────────────────────┐
│  Capacitor Bridge (for mobile)      │
└─────────────────────────────────────┘
```

---

## 📈 Feature Matrix

| Feature | Flutter | React Native | Ionic | Native | Next.js | Capacitor | Static |
|---------|---------|--------------|-------|--------|---------|-----------|--------|
| **Mobile App** | ✅ | ✅ | ✅ | ✅ | 🟡 | ✅ | ❌ |
| **Web App** | 🟡 | 🟡 | ✅ | ❌ | ✅ | ✅ | ✅ |
| **Desktop** | 🟡 | 🟡 | ❌ | ❌ | 🟡 | ❌ | ✅ |
| **Performance** | ✅ | ✅ | 🟡 | ✅ | 🟡 | 🟡 | ✅ |
| **SEO** | ❌ | ❌ | 🟡 | ❌ | ✅ | 🟡 | ✅ |
| **Offline** | ✅ | ✅ | ✅ | ✅ | 🟡 | 🟡 | 🟡 |
| **Native APIs** | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | ❌ |
| **Learning Curve** | 🟡 | ✅ | ✅ | 🟡 | ✅ | ✅ | ✅ |
| **Time to MVP** | Fast | Medium | Fast | Slow | Fast | Fast | Fast |
| **Team Size** | Small | Medium | Small | Small | Medium | Medium | Small |

**Legend:** ✅ Excellent | 🟡 Good | ❌ Not Suitable

---

## 📚 Documentation Status

### App-Variants
- ✅ `flutter-small-app` - Has README
- ⚠️ `flutter-small-app-aws` - Needs README
- ⚠️ `flutter-small-app-gcp` - Needs README
- ⚠️ `flutter-small-app-onpremis` - Needs README
- ✅ `react-native-base` - Complete README
- ✅ `ionic-base` - Complete README
- ✅ `native-ios-android` - Complete README

### Web-Variants
- ✅ `next-app` - Has README
- ✅ `react-web-platform` - Has README
- ✅ `react-capacitor` - Complete README
- ✅ `vue-capacitor` - Complete README
- ✅ `static-site` - Complete README

---

## 🎯 Quick Selection Guide

### "I need a mobile app"
→ **Start:** `app-variants/`
- MVP? → `flutter-small-app`
- AWS team? → `flutter-small-app-aws`
- Firebase team? → `flutter-small-app-gcp`
- Enterprise? → `flutter-small-app-onpremis`
- JS team? → `react-native-base`
- Quick prototype? → `ionic-base`
- Max performance? → `native-ios-android`

### "I need a web app"
→ **Start:** `web-variants/`
- Traditional site? → `next-app`
- Enterprise platform? → `react-web-platform`
- React + mobile later? → `react-capacitor`
- Vue + mobile later? → `vue-capacitor`
- Blog/docs/marketing? → `static-site`

### "I need both equally"
→ **Consider:**
1. **Mobile priority?** → `ionic-base` (web tech, mobile-first)
2. **Web priority?** → `react-capacitor` or `vue-capacitor` (web-first, wrap mobile)
3. **Separate codebases?** → `flutter-small-app` (mobile) + `next-app` (web)

---

## 🔄 Migration Paths

### From App-Variants to Web
- Export business logic to shared libraries
- Build web-specific UI
- Use responsive design principles

### From Web-Variants to Mobile
- Add Capacitor to existing web app
- Implement platform detection
- Add native plugin integrations

### Between Templates
- Most templates share similar patterns (clean architecture)
- Data models can often be ported
- API contracts remain consistent

---

## 🚀 Getting Started

1. **Assess your primary platform** (mobile or web)
2. **Review the decision matrix** above
3. **Clone the appropriate template**
4. **Read the template's README.md**
5. **Follow the quick start guide**
6. **Customize for your needs**

---

## 📞 Support

- 📖 See individual template READMEs for detailed setup
- 🐛 Report issues on GitHub
- 💬 Join discussions for questions
- 📧 Email: support@vivacitydigital.com

---

**Version:** 2.0.0
**Last Updated:** December 21, 2025
**Maintainer:** Vivacity Digital

*Built with ❤️ for developers who ship*
