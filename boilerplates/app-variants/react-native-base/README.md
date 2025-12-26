# React Native Base - Mobile-First Boilerplate

> **Philosophy:** Built for mobile, can run on web

A production-ready React Native boilerplate with clean architecture, best practices, and modern tooling for building native iOS and Android applications.

## 🎯 Overview

This boilerplate is designed for teams who:
- Want to build native mobile apps using JavaScript/TypeScript
- Prefer the React ecosystem and component model
- Need to leverage the vast npm ecosystem
- Want rapid development with hot reload
- Require access to native device features

## 🚀 Quick Start

```bash
# Navigate to template
cd boilerplates/app-variants/react-native-base

# Install dependencies
npm install

# Start development server
npm start

# Run on iOS
npm run ios

# Run on Android
npm run android
```

## 📱 What's Included

### Core Features
- ✅ **Expo CLI** - Rapid development with managed workflow
- ✅ **TypeScript** - Type safety and better DX
- ✅ **React Navigation** - Native navigation patterns
- ✅ **Redux Toolkit** - State management
- ✅ **RTK Query** - API data fetching
- ✅ **Async Storage** - Persistent local storage
- ✅ **React Native Paper** - Material Design components
- ✅ **Axios** - HTTP client with interceptors
- ✅ **React Hook Form** - Form handling
- ✅ **Zod** - Schema validation

### Authentication
- Email/password login
- OAuth integration ready
- Biometric authentication (Face ID, Touch ID)
- Token management
- Secure credential storage

### Developer Experience
- ESLint + Prettier configuration
- Git hooks (Husky)
- VS Code settings
- Debug configurations
- Component generators

## 🏗️ Project Structure

```
react-native-base/
├── src/
│   ├── api/              # API clients and endpoints
│   ├── components/       # Reusable components
│   ├── navigation/       # Navigation configuration
│   ├── screens/          # Screen components
│   ├── store/            # Redux store and slices
│   ├── hooks/            # Custom React hooks
│   ├── utils/            # Utility functions
│   ├── types/            # TypeScript types
│   ├── constants/        # App constants
│   └── theme/            # Theme configuration
├── assets/               # Images, fonts, etc.
├── __tests__/            # Test files
├── app.json              # Expo configuration
├── package.json
└── tsconfig.json
```

## 🎨 Clean Architecture

This boilerplate follows clean architecture principles:

```
UI Layer (Screens/Components)
    ↓
State Layer (Redux Store)
    ↓
Data Layer (API/Storage)
    ↓
Domain Layer (Types/Models)
```

## 📦 Key Dependencies

```json
{
  "expo": "~49.0.0",
  "react-native": "0.72.x",
  "@reduxjs/toolkit": "^1.9.x",
  "react-navigation": "^6.x",
  "react-native-paper": "^5.x",
  "typescript": "^5.x"
}
```

## 🔧 Configuration

### Environment Variables
```bash
# .env
API_URL=https://api.example.com
API_KEY=your_api_key
```

### Native Modules
The boilerplate includes setup for:
- Camera access
- Location services
- Push notifications
- Biometric auth
- File system access

## 📱 Platform Support

| Feature | iOS | Android |
|---------|-----|---------|
| Core App | ✅ | ✅ |
| Navigation | ✅ | ✅ |
| Biometric | ✅ | ✅ |
| Push Notifications | ✅ | ✅ |
| Deep Linking | ✅ | ✅ |

## 🧪 Testing

```bash
# Run tests
npm test

# Run tests with coverage
npm run test:coverage

# Run E2E tests
npm run test:e2e
```

## 🚢 Building for Production

```bash
# Build iOS
eas build --platform ios

# Build Android
eas build --platform android

# Submit to App Store
eas submit --platform ios

# Submit to Play Store
eas submit --platform android
```

## 🎯 Use Cases

**Best for:**
- Mobile-first applications
- Apps requiring native performance
- Teams familiar with React
- JavaScript/TypeScript shops

**Not ideal for:**
- Web-first applications
- Apps requiring complex native modules
- Teams wanting compile-time guarantees (use Flutter)

## 📚 Documentation

- [React Native Docs](https://reactnative.dev/)
- [Expo Documentation](https://docs.expo.dev/)
- [Redux Toolkit](https://redux-toolkit.js.org/)
- [React Navigation](https://reactnavigation.org/)

## 🤝 Contributing

Contributions welcome! Please follow the standard Git workflow.

---

**Part of Vivacity Digital Boilerplates**
*Built for Mobile, Can Run on Web*
