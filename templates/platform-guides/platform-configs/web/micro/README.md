# Web Micro Templates

Lightweight web application templates optimized for small projects, MVPs, and rapid prototyping.

## Available Frameworks

### 1. Flutter Web (flutter/)
**Best For:** Cross-platform apps, existing Flutter developers
- Same codebase as Android/iOS
- Widget-based UI  
- Hot reload
- Material Design built-in

Quick Start:
```
cp -r flutter/ your-project/web/
cd your-project
flutter run -d chrome
```

### 2. React (react/)
**Best For:** Interactive SPAs, component-based architecture
- Large ecosystem
- Fast development
- Reusable components

Quick Start:
```
cp -r react/ your-project/
cd your-project
npm install && npm start
```

### 3. Next.js (nextjs/)
**Best For:** SEO-focused apps, server-side rendering
- Built-in SSR/SSG
- API routes
- File-based routing

Quick Start:
```
cp -r nextjs/ your-project/
cd your-project  
npm install && npm run dev
```

### 4. Vanilla JS (vanilla/)
**Best For:** Simple sites, no build tools
- No dependencies
- Lightweight
- Fast loading

Quick Start:
```
cp -r vanilla/ your-project/
cd your-project
npm install && npm run dev
```

See individual framework directories for detailed documentation.
