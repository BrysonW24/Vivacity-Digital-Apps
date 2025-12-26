# Vue + Capacitor - Web-First Mobile Wrapper

> **Philosophy:** Built for web, can wrap as mobile

A production-ready Vue 3 web application with Capacitor integration for wrapping as native iOS and Android apps. Web-first development with mobile deployment capabilities.

## 🎯 Overview

This boilerplate is designed for teams who:
- Want web as the primary platform
- Prefer Vue ecosystem and progressive framework
- Need mobile apps as secondary targets
- Want a single codebase for web + mobile
- Value developer experience and simplicity

## 🚀 Quick Start

```bash
# Navigate to template
cd boilerplates/web-variants/vue-capacitor

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
- ✅ **Vue 3** - Composition API and script setup
- ✅ **Vite** - Fast build tooling
- ✅ **TypeScript** - Full type safety
- ✅ **Vue Router** - Official routing
- ✅ **Pinia** - Intuitive state management
- ✅ **VueUse** - Essential composition utilities
- ✅ **Tailwind CSS** - Utility-first styling
- ✅ **Axios** - HTTP client
- ✅ **VeeValidate** - Form validation
- ✅ **Zod** - Schema validation

### Mobile Features (via Capacitor)
- ✅ **Capacitor** - Native runtime bridge
- ✅ **Native Plugins** - Camera, geolocation, filesystem
- ✅ **Push Notifications** - FCM integration
- ✅ **App Store Ready** - iOS and Android builds
- ✅ **Live Reload** - Hot reload on device
- ✅ **Native UI** - Platform-specific components

### Progressive Web App (PWA)
- ✅ **Service Workers** - Offline support
- ✅ **Web Manifest** - Installable app
- ✅ **Workbox** - Advanced caching strategies
- ✅ **Background Sync** - Deferred operations

## 🏗️ Project Structure

```
vue-capacitor/
├── src/
│   ├── components/        # Vue components
│   ├── views/             # Page views
│   ├── composables/       # Composition functions
│   ├── stores/            # Pinia stores
│   ├── api/               # API services
│   ├── utils/             # Utility functions
│   ├── types/             # TypeScript types
│   ├── styles/            # Global styles
│   ├── router/            # Vue Router config
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

Clean architecture optimized for Vue 3:

```
UI Layer (Vue Components)
    ↓
Composition Layer (Composables + Stores)
    ↓
API Layer (Services)
    ↓
Capacitor Bridge (Native features)
```

## 📦 Key Dependencies

```json
{
  "vue": "^3.3.0",
  "vue-router": "^4.x",
  "pinia": "^2.x",
  "vite": "^4.x",
  "@capacitor/core": "^5.x",
  "@capacitor/ios": "^5.x",
  "@capacitor/android": "^5.x",
  "@vueuse/core": "^10.x",
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
  appName: 'My Vue App',
  webDir: 'dist',
  server: {
    androidScheme: 'https'
  }
};

export default config;
```

### Vue Router with Capacitor
```typescript
// src/router/index.ts
import { createRouter, createWebHistory } from 'vue-router';
import { Capacitor } from '@capacitor/core';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    // ... routes
  ]
});

// Handle back button on Android
if (Capacitor.isNativePlatform()) {
  App.addListener('backButton', ({ canGoBack }) => {
    if (canGoBack) {
      router.back();
    } else {
      App.exitApp();
    }
  });
}
```

## 🎭 Composables Example

```typescript
// src/composables/usePlatform.ts
import { computed } from 'vue';
import { Capacitor } from '@capacitor/core';

export function usePlatform() {
  const isNative = computed(() => Capacitor.isNativePlatform());
  const isIOS = computed(() => Capacitor.getPlatform() === 'ios');
  const isAndroid = computed(() => Capacitor.getPlatform() === 'android');
  const isWeb = computed(() => Capacitor.getPlatform() === 'web');

  return {
    isNative,
    isIOS,
    isAndroid,
    isWeb
  };
}
```

## 🏪 Pinia Store Example

```typescript
// src/stores/auth.ts
import { defineStore } from 'pinia';
import { ref } from 'vue';

export const useAuthStore = defineStore('auth', () => {
  const user = ref(null);
  const isAuthenticated = ref(false);

  async function login(credentials) {
    // ... login logic
  }

  async function logout() {
    // ... logout logic
  }

  return { user, isAuthenticated, login, logout };
});
```

## 🌐 Platform-Specific UI

```vue
<template>
  <div>
    <NativeCameraButton v-if="isNative" />
    <WebFileUpload v-else />
  </div>
</template>

<script setup lang="ts">
import { usePlatform } from '@/composables/usePlatform';

const { isNative } = usePlatform();
</script>
```

## 🧪 Testing

```bash
# Unit tests (Vitest)
npm test

# Component tests
npm run test:unit

# E2E tests (Playwright)
npm run test:e2e

# Coverage
npm run test:coverage
```

## 🚢 Deployment

### Web Deployment
```bash
# Build for production
npm run build

# Preview build
npm run preview

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
# Archive in Xcode → Upload to App Store

# Android
npx cap sync android
npx cap open android
# Build → Generate Signed Bundle → Upload to Play Store
```

## 🎯 Use Cases

**Best for:**
- Modern web applications with mobile needs
- Progressive Web Apps (PWAs)
- Vue-centric development teams
- Content management systems
- Admin dashboards with mobile access
- E-commerce platforms

**Not ideal for:**
- Mobile-first gaming applications
- Apps requiring extensive native integrations
- Performance-critical mobile experiences
- Offline-heavy mobile applications

## 📱 Platform Support

| Feature | Web | iOS | Android |
|---------|-----|-----|---------|
| Core App | ✅ | ✅ | ✅ |
| Responsive UI | ✅ | ✅ | ✅ |
| Camera | 🟡 | ✅ | ✅ |
| Geolocation | ✅ | ✅ | ✅ |
| Push Notifications | 🟡 | ✅ | ✅ |
| Offline Mode | ✅ | ✅ | ✅ |
| SEO | ✅ | ❌ | ❌ |
| App Store | ❌ | ✅ | ✅ |

**Legend:** ✅ Full Support | 🟡 Partial | ❌ Not Available

## 🔌 Capacitor Plugins

Pre-configured plugins:
```typescript
// Available plugins
import { Camera } from '@capacitor/camera';
import { Geolocation } from '@capacitor/geolocation';
import { PushNotifications } from '@capacitor/push-notifications';
import { Filesystem } from '@capacitor/filesystem';
import { Storage } from '@capacitor/storage';
import { Share } from '@capacitor/share';
import { App } from '@capacitor/app';
```

## 📚 Documentation

- [Vue 3 Documentation](https://vuejs.org/)
- [Capacitor Docs](https://capacitorjs.com/docs)
- [Pinia](https://pinia.vuejs.org/)
- [VueUse](https://vueuse.org/)
- [Vue Router](https://router.vuejs.org/)
- [Vite](https://vitejs.dev/)

## 💡 Best Practices

1. **Use Composition API** - Leverage script setup syntax
2. **Platform detection** - Use composables for platform-specific logic
3. **Responsive design** - Mobile-first CSS approach
4. **Code splitting** - Lazy load routes and components
5. **Error handling** - Global error boundaries
6. **TypeScript** - Leverage type safety
7. **Testing** - Unit test composables, E2E test critical flows

## 🆚 Vue vs React (for Capacitor)

| Aspect | Vue + Capacitor | React + Capacitor |
|--------|----------------|-------------------|
| Learning Curve | Easier | Steeper |
| Bundle Size | Smaller | Larger |
| Performance | Excellent | Excellent |
| Ecosystem | Growing | Larger |
| State Management | Pinia (simple) | Many options |
| TypeScript | Great | Great |

## 🤝 Contributing

Contributions welcome! Please follow Vue style guide and test on both web and mobile platforms.

---

**Part of Vivacity Digital Boilerplates**
*Built for Web, Can Wrap as Mobile*
