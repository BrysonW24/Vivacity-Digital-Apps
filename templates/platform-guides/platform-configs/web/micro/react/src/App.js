import React from 'react';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <h1>React Micro Template</h1>
        <p>A minimal React app template for micro-tier projects.</p>

        <div className="features">
          <div className="feature-card">
            <h3>⚡ Fast Setup</h3>
            <p>Get started in minutes with Create React App</p>
          </div>
          <div className="feature-card">
            <h3>📱 Responsive</h3>
            <p>Mobile-first design out of the box</p>
          </div>
          <div className="feature-card">
            <h3>🎨 Customizable</h3>
            <p>Easy to theme and extend</p>
          </div>
        </div>
      </header>
    </div>
  );
}

export default App;
