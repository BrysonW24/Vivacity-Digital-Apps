'use client';

import Link from 'next/link';
import { Layout } from '@/components/Layout';

export default function Home() {
  return (
    <Layout>
      {/* Hero Section */}
      <section className="py-20 px-4">
        <div className="max-w-4xl mx-auto text-center">
          <h1 className="text-5xl md:text-6xl font-bold text-gray-900 mb-6">
            Welcome to Next.js
          </h1>
          <p className="text-xl text-gray-600 mb-8 max-w-2xl mx-auto">
            Production-ready boilerplate with TypeScript, Tailwind CSS, NextAuth,
            and more. Build faster, ship sooner.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link
              href="/signup"
              className="px-8 py-3 rounded-lg bg-blue-600 text-white font-medium hover:bg-blue-700 transition"
            >
              Get Started
            </Link>
            <Link
              href="/docs"
              className="px-8 py-3 rounded-lg bg-gray-200 text-gray-900 font-medium hover:bg-gray-300 transition"
            >
              Learn More
            </Link>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="py-20 px-4 bg-white">
        <div className="max-w-6xl mx-auto">
          <h2 className="text-4xl font-bold text-center text-gray-900 mb-12">
            Features
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {[
              {
                title: 'Fast by Default',
                description:
                  'Built with Next.js 14 and optimized for performance',
                icon: '⚡',
              },
              {
                title: 'Type Safe',
                description:
                  'Full TypeScript support with Zod validation',
                icon: '🔒',
              },
              {
                title: 'Beautiful UI',
                description:
                  'Tailwind CSS with Radix UI components',
                icon: '✨',
              },
              {
                title: 'Authentication',
                description:
                  'NextAuth.js for secure user management',
                icon: '🔐',
              },
              {
                title: 'Data Fetching',
                description:
                  'React Query for efficient server state management',
                icon: '📊',
              },
              {
                title: 'Testing Ready',
                description:
                  'Playwright configured for E2E testing',
                icon: '✅',
              },
            ].map((feature, index) => (
              <div
                key={index}
                className="p-6 rounded-lg border border-gray-200 hover:border-blue-300 transition"
              >
                <div className="text-4xl mb-4">{feature.icon}</div>
                <h3 className="text-xl font-semibold text-gray-900 mb-2">
                  {feature.title}
                </h3>
                <p className="text-gray-600">{feature.description}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Tech Stack Section */}
      <section className="py-20 px-4">
        <div className="max-w-6xl mx-auto">
          <h2 className="text-4xl font-bold text-center text-gray-900 mb-12">
            Tech Stack
          </h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
            {[
              'Next.js 14',
              'React 18',
              'TypeScript',
              'Tailwind CSS',
              'NextAuth.js',
              'React Query',
              'Zustand',
              'Zod',
            ].map((tech) => (
              <div
                key={tech}
                className="p-4 rounded-lg bg-gray-100 text-center font-medium text-gray-900"
              >
                {tech}
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20 px-4 bg-gradient-to-r from-blue-600 to-blue-800">
        <div className="max-w-4xl mx-auto text-center text-white">
          <h2 className="text-4xl font-bold mb-4">Ready to build?</h2>
          <p className="text-xl mb-8 opacity-90">
            Start building your next project with this powerful boilerplate
          </p>
          <Link
            href="/signup"
            className="inline-block px-8 py-3 rounded-lg bg-white text-blue-600 font-semibold hover:bg-gray-100 transition"
          >
            Create Account
          </Link>
        </div>
      </section>
    </Layout>
  );
}
