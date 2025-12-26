export default function Home() {
  return (
    <main className="container">
      <h1>Next.js Micro Template</h1>
      <p>A minimal Next.js 14 app template with App Router</p>

      <div className="features">
        <div className="feature-card">
          <h3>🚀 Server Components</h3>
          <p>Built with React Server Components by default</p>
        </div>
        <div className="feature-card">
          <h3>⚡ Fast Refresh</h3>
          <p>Lightning-fast development experience</p>
        </div>
        <div className="feature-card">
          <h3>📦 SEO Ready</h3>
          <p>Built-in SEO optimization and metadata</p>
        </div>
      </div>
    </main>
  );
}
