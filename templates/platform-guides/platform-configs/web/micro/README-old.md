# Web Micro Template Configuration

**Platform:** Web (Flutter Web)
**Tier:** Micro-Budget

## Overview

Web configuration from the Journal App template for Flutter web applications. Includes all necessary files to deploy a Flutter app to the web.

## What's Included

From `journal-app-prod/web/`:
- `index.html` - Main HTML entry point
- `manifest.json` - PWA manifest
- `favicon.png` - Browser favicon
- `icons/` - PWA app icons (various sizes)

## Usage

This web folder should be in your Flutter project root:
```
your_flutter_app/
├── web/           ← This folder
├── lib/
├── android/
└── pubspec.yaml
```

## Customization

### 1. Update App Name

```html
<!-- web/index.html -->
<title>Your App Name</title>
```

```json
// web/manifest.json
{
  "name": "Your App Name",
  "short_name": "YourApp",
  "description": "Your app description"
}
```

### 2. Update Icons

Replace icons in `web/icons/`:
- Icon-192.png (192x192)
- Icon-512.png (512x512)
- Icon-maskable-192.png
- Icon-maskable-512.png

And `web/favicon.png`

### 3. Configure PWA

```json
// web/manifest.json
{
  "name": "Your App",
  "short_name": "App",
  "start_url": ".",
  "display": "standalone",
  "background_color": "#FFFFFF",
  "theme_color": "#6366F1",
  "description": "Your description",
  "orientation": "portrait-primary"
}
```

## Building for Web

### Development
```bash
flutter run -d chrome
```

### Production Build
```bash
flutter build web --release
```

Output: `build/web/`

### Build with Base Href
```bash
flutter build web --base-href="/your-path/"
```

## Deployment

### Static Hosting (Firebase, Netlify, Vercel)

1. Build: `flutter build web`
2. Deploy `build/web/` folder
3. Configure routing for single-page app

### Firebase Hosting
```bash
firebase init hosting
# Select build/web as public directory
firebase deploy
```

### Netlify
```bash
# build/web contains all files
# Add _redirects file for routing:
/*    /index.html   200
```

### GitHub Pages
```bash
flutter build web --base-href="/repo-name/"
# Deploy build/web to gh-pages branch
```

## PWA Features

### Install Prompt
Users can install your app like a native app

### Offline Support
Configure service worker in `web/index.html`

### App-like Experience
Runs in standalone mode (no browser UI)

## Web-Specific Considerations

### Performance
- Images: Use WebP format
- Code splitting enabled by default
- Tree shaking removes unused code

### Browser Compatibility
- Modern browsers (Chrome, Firefox, Safari, Edge)
- No IE11 support

### Features Not Available
- Some plugins don't support web
- No file system access (use downloads)
- Camera/location need permissions

## Testing

### Local Testing
```bash
flutter run -d chrome --web-renderer html
# or
flutter run -d chrome --web-renderer canvaskit
```

### Different Renderers
- **HTML:** Better compatibility, larger size
- **CanvasKit:** Better performance, consistent rendering

## Common Issues

### CORS Errors
Configure backend to allow web origin

### Plugin Not Working
Check if plugin supports web:
```yaml
# pubspec.yaml - check supported platforms
```

### Slow Initial Load
- Use code splitting
- Lazy load images
- Optimize assets

## SEO & Meta Tags

```html
<!-- web/index.html -->
<head>
  <meta name="description" content="Your app description">
  <meta property="og:title" content="Your App">
  <meta property="og:description" content="Description">
  <meta property="og:image" content="preview.png">
  <meta name="twitter:card" content="summary_large_image">
</head>
```

## Resources

- **Flutter Web:** https://docs.flutter.dev/platform-integration/web
- **PWA Guide:** https://web.dev/progressive-web-apps/
- **Deployment:** https://docs.flutter.dev/deployment/web

---

**Template Base:** Journal App Web Configuration
**Last Updated:** 2024-11-07