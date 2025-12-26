import './globals.css';

export const metadata = {
  title: 'Next.js Micro Template',
  description: 'Micro-tier Next.js web application',
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
