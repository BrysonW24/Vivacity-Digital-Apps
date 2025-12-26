# React + Capacitor - Web-First Mobile Wrapper

> **Philosophy:** Built for web, can wrap as mobile

A production-ready React web application with Capacitor integration for wrapping as native iOS and Android apps. Web-first development with mobile deployment capabilities.

## 🎯 Overview

This boilerplate is designed for teams who:
- Want web as the primary platform
- Need mobile apps as secondary targets
- Prefer React ecosystem and tooling
- Want a single codebase for web + mobile
- Value web development speed

## 🚀 Quick Start

```bash
# Navigate to template
cd boilerplates/web-variants/react-capacitor

# Install dependencies
npm install

# Start web development
npm run dev

# Build and sync with mobile
npm run build
npx cap sync

# Run on iOS
npx cap run ios

# Run on Android
npx cap run android
```

## 🌐 What's Included

### Web Features
- ✅ **React 18** - Latest React with concurrent features
- ✅ **Vite** - Lightning-fast build tool
- ✅ **TypeScript** - Type safety
- ✅ **React Router** - Client-side routing
- ✅ **Zustand** - Lightweight state management
- ✅ **TanStack Query** - Server state management
- ✅ **Tailwind CSS** - Utility-first styling
- ✅ **Axios** - HTTP client
- ✅ **React Hook Form** - Form management
- ✅ **Zod** - Schema validation

### Mobile Features (via Capacitor)
- ✅ **Capacitor** - Native runtime bridge
- ✅ **Native Plugins** - Camera, geolocation, filesystem
- ✅ **Push Notifications** - FCM integration
- ✅ **App Store Ready** - iOS and Android builds
- ✅ **Live Reload** - Hot reload on device
- ✅ **Native UI** - Access platform-specific UI

### Progressive Web App (PWA)
- ✅ **Service Workers** - Offline functionality
- ✅ **Web Manifest** - Install prompts
- ✅ **Cache API** - Asset caching
- ✅ **Background Sync** - Deferred requests

## 🏗️ Project Structure

```
react-capacitor/
├── src/
│   ├── components/        # React components
│   ├── pages/             # Page components
│   ├── hooks/             # Custom hooks
│   ├── store/             # Zustand stores
│   ├── api/               # API clients
│   ├── utils/             # Utilities
│   ├── types/             # TypeScript types
│   ├── styles/            # Global styles
│   └── capacitor/         # Capacitor-specific code
├── public/                # Static assets
├── ios/                   # iOS native project
├── android/               # Android native project
├── capacitor.config.ts    # Capacitor configuration
├── vite.config.ts         # Vite configuration
├── package.json
└── tsconfig.json
```

## 🎨 Architecture

Clean architecture optimized for web-first:

```
UI Layer (React Components)
    ↓
State Layer (Zustand + TanStack Query)
    ↓
API Layer (Axios + React Query)
    ↓
Capacitor Bridge (Native features)
```

## 📦 Key Dependencies

```json
{
  "react": "^18.2.0",
  "vite": "^4.x",
  "@capacitor/core": "^5.x",
  "@capacitor/ios": "^5.x",
  "@capacitor/android": "^5.x",
  "zustand": "^4.x",
  "@tanstack/react-query": "^4.x",
  "tailwindcss": "^3.x",
  "typescript": "^5.x"
}
```

## 🔧 Configuration

### Environment Variables
```bash
# .env
VITE_API_URL=https://api.example.com
VITE_API_KEY=your_api_key
VITE_ENV=production
```

### Capacitor Configuration
```typescript
// capacitor.config.ts
import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.example.app',
  appName: 'My App',
  webDir: 'dist',
  server: {
    androidScheme: 'https'
  },
  plugins: {
    PushNotifications: {
      presentationOptions: ['badge', 'sound', 'alert']
    }
  }
};
```

### Responsive Design
```typescript
// src/hooks/useMediaQuery.ts
export const useMediaQuery = (query: string) => {
  const [matches, setMatches] = useState(false);
  // ... implementation
};

// Usage
const isMobile = useMediaQuery('(max-width: 768px)');
```

## 📱 Platform Detection

```typescript
// src/utils/platform.ts
import { Capacitor } from '@capacitor/core';

export const isNative = Capacitor.isNativePlatform();
export const isIOS = Capacitor.getPlatform() === 'ios';
export const isAndroid = Capacitor.getPlatform() === 'android';
export const isWeb = Capacitor.getPlatform() === 'web';
```

## 🌐 Web vs Mobile UX

```typescript
// Conditional rendering based on platform
{isNative ? (
  <NativeCameraButton />
) : (
  <WebFileUpload />
)}
```

## 🧪 Testing

```bash
# Web tests
npm test

# E2E tests (web)
npm run test:e2e

# Mobile tests require native testing frameworks
# iOS: XCTest
# Android: Espresso/JUnit
```

## 🚢 Deployment

### Web Deployment
```bash
# Build for production
npm run build

# Deploy to Vercel
vercel deploy

# Or Netlify
netlify deploy --prod

# Or Firebase
firebase deploy
```

### Mobile Deployment
```bash
# iOS
npx cap sync ios
npx cap open ios
# Then: Archive in Xcode → Upload to App Store

# Android
npx cap sync android
npx cap open android
# Then: Build → Generate Signed Bundle
```

## 🎯 Use Cases

**Best for:**
- Web applications that need mobile presence
- Progressive Web Apps (PWAs)
- Content-heavy applications
- E-commerce platforms
- SaaS dashboards
- React-centric teams

**Not ideal for:**
- Mobile-first applications
- Performance-critical mobile apps
- Apps requiring extensive native features
- Offline-first mobile experiences

## 📊 Platform Support

| Feature | Web | iOS | Android |
|---------|-----|-----|---------|
| Core App | ✅ | ✅ | ✅ |
| Responsive UI | ✅ | ✅ | ✅ |
| Camera | 🟡 | ✅ | ✅ |
| Geolocation | ✅ | ✅ | ✅ |
| Push Notifications | 🟡 | ✅ | ✅ |
| App Store | ❌ | ✅ | ✅ |
| SEO | ✅ | ❌ | ❌ |

**Legend:** ✅ Full Support | 🟡 Partial | ❌ Not Available

## 🔌 Capacitor Plugins

Pre-configured plugins:
- `@capacitor/camera` - Photo/video capture
- `@capacitor/geolocation` - GPS location
- `@capacitor/push-notifications` - Push messaging
- `@capacitor/filesystem` - File operations
- `@capacitor/storage` - Persistent storage
- `@capacitor/share` - Native share dialog
- `@capacitor/app` - App lifecycle events

## 📚 Documentation

- [React Documentation](https://react.dev/)
- [Capacitor Docs](https://capacitorjs.com/docs)
- [Vite Guide](https://vitejs.dev/guide/)
- [TanStack Query](https://tanstack.com/query/)
- [Tailwind CSS](https://tailwindcss.com/docs)

## 💡 Best Practices

1. **Design mobile-responsive from the start**
2. **Use platform detection for UX adaptations**
3. **Implement progressive enhancement**
4. **Test on actual devices, not just simulators**
5. **Optimize bundle size for mobile networks**
6. **Use lazy loading for code splitting**
7. **Implement proper error boundaries**

## 🤝 Contributing

Contributions welcome! Please follow React best practices and test on both web and mobile platforms.

---

**Part of Vivacity Digital Boilerplates**
*Built for Web, Can Wrap as Mobile*
