# Web Deployment Guide

## Quick Deploy Options

### 1. Firebase Hosting
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Initialize
firebase init hosting

# Deploy
firebase deploy
```

### 2. Netlify
```bash
# Install Netlify CLI
npm install -g netlify-cli

# Login
netlify login

# Deploy
netlify deploy --prod
```

### 3. Vercel
```bash
# Install Vercel CLI
npm install -g vercel

# Deploy
vercel
```

### 4. GitHub Pages
```bash
# Build your app
npm run build

# Deploy to gh-pages branch
npm install -g gh-pages
gh-pages -d public
```

## Build Process

### Development
```bash
npm run dev
# or
yarn dev
```

### Production Build
```bash
npm run build
# or
yarn build
```

## Environment Variables

Create `.env` files for different environments:

**.env.development**
```
API_URL=http://localhost:3000
DEBUG=true
```

**.env.production**
```
API_URL=https://api.yourapp.com
DEBUG=false
```

## Custom Domain

### Firebase
```bash
firebase hosting:channel:deploy production --domain yourdomain.com
```

### Netlify
1. Go to Site settings
2. Domain management
3. Add custom domain

### Vercel
```bash
vercel domains add yourdomain.com
```

## SSL/HTTPS

All platforms provide free SSL certificates automatically.

## Performance Optimization

- Minify CSS/JS
- Optimize images
- Enable gzip compression
- Use CDN for static assets
- Lazy load components

## Monitoring

Consider adding:
- Google Analytics
- Sentry (error tracking)
- LogRocket (session replay)
- Performance monitoring

## Rollback

### Firebase
```bash
firebase hosting:rollback
```

### Netlify
Use the Netlify dashboard to rollback to previous deploy

### Vercel
Use the Vercel dashboard deployments tab
