'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'

export default function Navigation() {
  const pathname = usePathname()
  
  const navItems = [
    { href: '/', label: 'Thought Leadership', active: pathname === '/' },
    { href: '/moat-finder', label: 'Strategic Moat Finder', active: pathname === '/moat-finder' },
    { href: '/disruption-radar', label: 'Disruption Radar', active: pathname === '/disruption-radar' },
    { href: '/news', label: 'News Intelligence', active: pathname === '/news' },
  ]

  return (
    <nav className="bg-gradient-to-r from-commbank-black via-gray-900 to-commbank-black border-b-4 border-commbank-yellow shadow-2xl">
      <div className="container mx-auto px-6">
        <div className="flex flex-col md:flex-row justify-between items-center py-6">
          <div className="text-center md:text-left mb-6 md:mb-0">
            <h1 className="text-commbank-yellow text-2xl font-extrabold tracking-tight animate-fade-in">
              Commonwealth Bank AI Strategy Studio
            </h1>
            <p className="text-gray-300 text-sm mt-2 font-medium">
              CommBank AI Strategy Intelligence Workbench
            </p>
          </div>

          <div className="flex gap-3 flex-wrap justify-center">
            {navItems.map((item) => (
              <Link
                key={item.href}
                href={item.href}
                className={item.active ? 'nav-link-active' : 'nav-link-inactive'}
              >
                {item.label}
              </Link>
            ))}
          </div>
        </div>

        <div className="pb-6 text-gray-300 text-sm border-t border-gray-800 pt-6 leading-relaxed">
          <p className="max-w-5xl">
            Unite expert insight and live market signals into a single decision-grade AI strategy for CommBank.
            Thought Leadership converts transcripts into board-ready moves Strategic Moat Finder isolates defensible
            advantages with hard evidence and Disruption Radar quantifies threats to core profit pools with immediate
            actions giving the CEO and Group Executive Strategy clear levers for capital allocation risk posture and differentiation.
          </p>
        </div>

        <div className="flex gap-8 pb-6 text-xs flex-wrap">
          <span className="text-commbank-gray-400 hover:text-commbank-yellow transition-colors cursor-default flex items-center gap-2">
            <span className="w-2 h-2 bg-commbank-yellow rounded-full"></span>
            AI strategy dossiers
          </span>
          <span className="text-commbank-gray-400 hover:text-commbank-yellow transition-colors cursor-default flex items-center gap-2">
            <span className="w-2 h-2 bg-commbank-yellow rounded-full"></span>
            Strategic moat intelligence
          </span>
          <span className="text-commbank-gray-400 hover:text-commbank-yellow transition-colors cursor-default flex items-center gap-2">
            <span className="w-2 h-2 bg-commbank-yellow rounded-full"></span>
            Disruption radar insights
          </span>
          <span className="text-commbank-gray-400 hover:text-commbank-yellow transition-colors cursor-default flex items-center gap-2">
            <span className="w-2 h-2 bg-commbank-yellow rounded-full"></span>
            Executive-ready briefings
          </span>
        </div>
      </div>
    </nav>
  )
}
