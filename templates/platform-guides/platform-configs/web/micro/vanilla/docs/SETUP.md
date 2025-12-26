# Web App Setup Guide

## Prerequisites

- Node.js 16+ installed
- npm or yarn package manager
- Text editor (VS Code recommended)

## Installation

### 1. Copy Template
```bash
cp -r templates/platforms/web/micro your-project-name
cd your-project-name
```

### 2. Install Dependencies

Create `package.json`:
```json
{
  "name": "your-app-name",
  "version": "1.0.0",
  "description": "Your app description",
  "scripts": {
    "dev": "webpack serve --mode development",
    "build": "webpack --mode production",
    "start": "npm run dev"
  },
  "devDependencies": {
    "webpack": "^5.88.0",
    "webpack-cli": "^5.1.0",
    "webpack-dev-server": "^4.15.0",
    "style-loader": "^3.3.3",
    "css-loader": "^6.8.1"
  }
}
```

Then install:
```bash
npm install
```

### 3. Update Configuration

**Update config/firebase.config.js:**
- Replace API keys with your Firebase project credentials
- Set environment URLs

**Update manifest.json:**
```json
{
  "name": "Your App Name",
  "short_name": "YourApp",
  "description": "Your app description"
}
```

**Update index.html:**
```html
<title>Your App Name</title>
```

### 4. Customize Branding

- Replace `favicon.png` (16x16, 32x32, 48x48)
- Replace icons in `icons/` folder:
  - Icon-192.png (192x192)
  - Icon-512.png (512x512)
  - Icon-maskable-192.png (192x192)
  - Icon-maskable-512.png (512x512)

### 5. Update Service Worker

Edit `public/service-worker.js`:
```javascript
const CACHE_NAME = 'your-app-v1';  // Change this
```

## Development

### Run Development Server
```bash
npm run dev
```

Open http://localhost:3000

### Build for Production
```bash
npm run build
```

Output will be in `public/` directory.

## Project Structure

```
your-app/
├── config/
│   ├── webpack.config.js      # Build configuration
│   └── firebase.config.js     # Firebase & environment config
├── src/
│   ├── index.js              # App entry point
│   └── styles/
│       └── main.css          # Main stylesheet
├── public/
│   └── service-worker.js     # PWA service worker
├── docs/
│   ├── SETUP.md             # This file
│   └── DEPLOYMENT.md        # Deployment guide
├── icons/                    # PWA icons
├── index.html               # HTML entry point
├── manifest.json            # PWA manifest
├── favicon.png              # Browser icon
└── README.md                # Main documentation
```

## Adding Features

### Add a New Page
1. Create new HTML in `index.html`
2. Add routing logic in `src/index.js`
3. Style in `src/styles/main.css`

### Add API Integration
1. Configure endpoint in `config/firebase.config.js`
2. Create API service in `src/services/api.js`
3. Use in your app components

### Add Database
- Firebase Firestore
- Supabase
- MongoDB Atlas

See documentation for your chosen database.

## Testing

### Manual Testing
- Test on Chrome, Firefox, Safari, Edge
- Test responsive design (mobile, tablet, desktop)
- Test PWA install functionality
- Test offline mode

### Automated Testing
Add testing framework:
```bash
npm install --save-dev jest
```

## Next Steps

1. Complete customization
2. Add your app logic
3. Test thoroughly
4. Deploy to hosting platform
5. Configure custom domain
6. Monitor performance

See [DEPLOYMENT.md](./DEPLOYMENT.md) for deployment instructions.
