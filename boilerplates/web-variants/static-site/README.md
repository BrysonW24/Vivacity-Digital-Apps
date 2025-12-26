# Static Site - JAMstack Boilerplate

> **Philosophy:** Built for web, optimized for speed and SEO

A production-ready static site generator boilerplate using modern JAMstack architecture. Perfect for blogs, documentation, marketing sites, and content-heavy applications.

## 🎯 Overview

This boilerplate is designed for teams who:
- Need blazing-fast load times
- Want excellent SEO out of the box
- Have content-driven websites
- Prefer git-based content workflows
- Need CDN-friendly deployment
- Want minimal runtime overhead

## 🚀 Quick Start

```bash
# Navigate to template
cd boilerplates/web-variants/static-site

# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview
```

## 🌐 What's Included

### Core Features
- ✅ **Astro** - Modern static site generator
- ✅ **TypeScript** - Type safety
- ✅ **Markdown/MDX** - Content with components
- ✅ **React/Vue/Svelte** - Interactive islands
- ✅ **Tailwind CSS** - Utility-first styling
- ✅ **Image Optimization** - Automatic optimization
- ✅ **RSS Feed** - Automatic feed generation
- ✅ **Sitemap** - SEO-friendly sitemap
- ✅ **SEO Meta Tags** - Built-in SEO support
- ✅ **Code Highlighting** - Syntax highlighting

### Content Management
- ✅ **Markdown CMS** - File-based content
- ✅ **Frontmatter** - YAML metadata
- ✅ **Collections** - Type-safe content collections
- ✅ **Pagination** - Built-in pagination
- ✅ **Search** - Client-side search (Pagefind)
- ✅ **Tags/Categories** - Content taxonomy

### Performance
- ✅ **Zero JS by default** - Ship only what's needed
- ✅ **Partial Hydration** - Islands architecture
- ✅ **Asset Optimization** - Images, CSS, JS
- ✅ **Lazy Loading** - Deferred loading
- ✅ **Prefetching** - Smart link prefetch

## 🏗️ Project Structure

```
static-site/
├── src/
│   ├── components/        # Reusable components
│   ├── layouts/           # Page layouts
│   ├── pages/             # Site pages (routes)
│   │   ├── index.astro    # Homepage
│   │   ├── blog/          # Blog pages
│   │   ├── docs/          # Documentation
│   │   └── [...slug].astro # Dynamic routes
│   ├── content/           # Markdown content
│   │   ├── blog/          # Blog posts
│   │   ├── docs/          # Documentation
│   │   └── config.ts      # Content schema
│   ├── styles/            # Global styles
│   ├── utils/             # Utility functions
│   └── config.ts          # Site configuration
├── public/                # Static assets
├── astro.config.mjs       # Astro configuration
├── tailwind.config.cjs    # Tailwind configuration
├── tsconfig.json
└── package.json
```

## 🎨 Architecture

JAMstack architecture with modern tooling:

```
Markdown Content
    ↓
Content Collections (Type-safe)
    ↓
Static Site Generation (Build time)
    ↓
Optimized HTML/CSS/JS
    ↓
CDN Deployment (Edge)
```

## 📦 Key Dependencies

```json
{
  "astro": "^3.x",
  "@astrojs/react": "^3.x",
  "@astrojs/tailwind": "^5.x",
  "@astrojs/mdx": "^1.x",
  "@astrojs/sitemap": "^3.x",
  "tailwindcss": "^3.x",
  "typescript": "^5.x"
}
```

## 🔧 Configuration

### Site Configuration
```typescript
// src/config.ts
export const SITE = {
  title: 'My Awesome Site',
  description: 'A blazing-fast static site',
  url: 'https://example.com',
  author: 'Your Name',
  social: {
    twitter: '@username',
    github: 'username'
  }
};
```

### Content Schema
```typescript
// src/content/config.ts
import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
  schema: z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.date(),
    author: z.string(),
    tags: z.array(z.string()),
    image: z.string().optional(),
    draft: z.boolean().default(false)
  })
});

export const collections = { blog };
```

### Astro Configuration
```javascript
// astro.config.mjs
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';
import react from '@astrojs/react';
import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';

export default defineConfig({
  site: 'https://example.com',
  integrations: [
    tailwind(),
    react(),
    mdx(),
    sitemap()
  ],
  markdown: {
    shikiConfig: {
      theme: 'dracula'
    }
  }
});
```

## 📝 Content Management

### Creating Blog Posts
```markdown
---
title: 'My First Post'
description: 'This is my first blog post'
pubDate: 2025-12-21
author: 'John Doe'
tags: ['astro', 'blogging']
---

# My First Post

Content goes here...
```

### Creating Pages
```astro
---
// src/pages/about.astro
import Layout from '../layouts/Layout.astro';
---

<Layout title="About">
  <h1>About Us</h1>
  <p>Welcome to our site!</p>
</Layout>
```

### Dynamic Routes
```astro
---
// src/pages/blog/[...slug].astro
import { getCollection } from 'astro:content';

export async function getStaticPaths() {
  const posts = await getCollection('blog');
  return posts.map(post => ({
    params: { slug: post.slug },
    props: { post }
  }));
}

const { post } = Astro.props;
const { Content } = await post.render();
---

<Layout title={post.data.title}>
  <article>
    <h1>{post.data.title}</h1>
    <Content />
  </article>
</Layout>
```

## 🎨 Interactive Components (Islands)

```astro
---
// src/pages/index.astro
import Counter from '../components/Counter.tsx';
---

<Layout>
  <h1>Static Content</h1>

  <!-- Interactive island -->
  <Counter client:load />

  <p>More static content</p>
</Layout>
```

```tsx
// src/components/Counter.tsx
import { useState } from 'react';

export default function Counter() {
  const [count, setCount] = useState(0);

  return (
    <button onClick={() => setCount(count + 1)}>
      Count: {count}
    </button>
  );
}
```

## 🔍 SEO Optimization

```astro
---
// src/components/SEO.astro
interface Props {
  title: string;
  description: string;
  image?: string;
}

const { title, description, image } = Astro.props;
const canonicalURL = new URL(Astro.url.pathname, Astro.site);
---

<head>
  <title>{title}</title>
  <meta name="description" content={description} />
  <link rel="canonical" href={canonicalURL} />

  <!-- Open Graph -->
  <meta property="og:title" content={title} />
  <meta property="og:description" content={description} />
  <meta property="og:image" content={image} />

  <!-- Twitter -->
  <meta name="twitter:card" content="summary_large_image" />
  <meta name="twitter:title" content={title} />
  <meta name="twitter:description" content={description} />
</head>
```

## 🚢 Deployment

### Vercel
```bash
npm run build
vercel deploy
```

### Netlify
```bash
npm run build
netlify deploy --prod
```

### Cloudflare Pages
```bash
npm run build
wrangler pages publish dist
```

### GitHub Pages
```yaml
# .github/workflows/deploy.yml
name: Deploy to GitHub Pages

on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
      - run: npm install
      - run: npm run build
      - uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./dist
```

## 📊 Performance Metrics

Target metrics:
- **Lighthouse Score:** 100/100 (all categories)
- **First Contentful Paint:** < 1s
- **Time to Interactive:** < 2s
- **Total Bundle Size:** < 100KB (initial)
- **Page Weight:** < 500KB

## 🎯 Use Cases

**Perfect for:**
- 📝 Blogs and personal sites
- 📚 Documentation sites
- 🏢 Marketing websites
- 🎓 Educational content
- 📰 News/media sites
- 🏪 E-commerce (with headless CMS)
- 📊 Landing pages

**Not ideal for:**
- Real-time applications
- User authentication (without external service)
- Complex interactive dashboards
- Apps requiring server-side logic
- Database-driven applications

## 🆚 Static Site vs Traditional CMS

| Feature | Static Site | WordPress | Next.js SSR |
|---------|-------------|-----------|-------------|
| Speed | ⚡⚡⚡ | 🐢 | ⚡⚡ |
| Hosting Cost | $0-$5/mo | $10-50/mo | $20-100/mo |
| Security | ✅ | 🟡 | 🟡 |
| SEO | ✅ | ✅ | ✅ |
| Content Updates | Git-based | Admin panel | Code/CMS |
| Scalability | Infinite | Limited | Good |
| Maintenance | Minimal | High | Medium |

## 🔌 Integrations

### Headless CMS Options
- **Contentful** - Enterprise CMS
- **Sanity** - Flexible content platform
- **Strapi** - Open-source CMS
- **Forestry** - Git-based CMS
- **Decap CMS** - Open-source, Git-based

### Example: Contentful Integration
```typescript
// src/lib/contentful.ts
import { createClient } from 'contentful';

const client = createClient({
  space: import.meta.env.CONTENTFUL_SPACE_ID,
  accessToken: import.meta.env.CONTENTFUL_ACCESS_TOKEN
});

export async function getBlogPosts() {
  const entries = await client.getEntries({
    content_type: 'blogPost'
  });
  return entries.items;
}
```

## 🧪 Testing

```bash
# Build and test
npm run build
npm run preview

# Lighthouse CI
npm run lighthouse

# Link checking
npm run check-links

# Accessibility testing
npm run test:a11y
```

## 📚 Documentation

- [Astro Documentation](https://docs.astro.build/)
- [Tailwind CSS](https://tailwindcss.com/)
- [MDX](https://mdxjs.com/)
- [JAMstack](https://jamstack.org/)

## 💡 Best Practices

1. **Optimize images** - Use Astro's Image component
2. **Minimize JavaScript** - Use islands architecture
3. **Implement caching** - Leverage CDN caching
4. **Use semantic HTML** - Better SEO and accessibility
5. **Write accessible content** - Follow WCAG guidelines
6. **Monitor Core Web Vitals** - Use Lighthouse/PageSpeed
7. **Version control content** - Git-based workflow
8. **Implement search** - Client-side or Algolia

## 🤝 Contributing

Contributions welcome! Please maintain the focus on performance and simplicity.

---

**Part of Vivacity Digital Boilerplates**
*Built for Web, Optimized for Speed*
