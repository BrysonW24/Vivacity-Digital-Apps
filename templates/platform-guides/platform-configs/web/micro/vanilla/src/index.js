// Main entry point for web application
// This is a basic template for micro-tier web apps

import './styles/main.css';
import { getEnvironment } from '../config/firebase.config.js';

// Initialize app
document.addEventListener('DOMContentLoaded', () => {
  console.log('App initialized');
  const env = getEnvironment();
  console.log('Environment:', env);

  // Initialize your app here
  initializeApp();
});

function initializeApp() {
  // Add your initialization logic here
  const app = document.getElementById('app');

  if (app) {
    app.innerHTML = `
      <div class="container">
        <h1>Welcome to Your App</h1>
        <p>This is a micro-tier web template.</p>
      </div>
    `;
  }
}

// Service Worker registration for PWA
if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('/service-worker.js')
      .then(registration => {
        console.log('SW registered:', registration);
      })
      .catch(error => {
        console.log('SW registration failed:', error);
      });
  });
}

export { initializeApp };
