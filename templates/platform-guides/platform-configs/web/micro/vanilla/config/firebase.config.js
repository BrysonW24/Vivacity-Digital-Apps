// Firebase configuration template
// Replace these values with your Firebase project settings

export const firebaseConfig = {
  apiKey: "YOUR_API_KEY",
  authDomain: "your-project.firebaseapp.com",
  projectId: "your-project-id",
  storageBucket: "your-project.appspot.com",
  messagingSenderId: "YOUR_SENDER_ID",
  appId: "YOUR_APP_ID",
  measurementId: "YOUR_MEASUREMENT_ID"
};

// Environment-specific configs
export const environments = {
  development: {
    apiUrl: 'http://localhost:3000/api',
    debug: true,
  },
  staging: {
    apiUrl: 'https://staging-api.yourapp.com',
    debug: true,
  },
  production: {
    apiUrl: 'https://api.yourapp.com',
    debug: false,
  }
};

// Get current environment
export const getEnvironment = () => {
  const hostname = window.location.hostname;

  if (hostname === 'localhost' || hostname === '127.0.0.1') {
    return environments.development;
  } else if (hostname.includes('staging')) {
    return environments.staging;
  } else {
    return environments.production;
  }
};
