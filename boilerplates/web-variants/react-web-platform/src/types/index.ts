export interface YouTubeUrl {
  id: number
  url: string
}

export interface ThoughtLeadershipBrief {
  title: string
  generated: string
  sources: number
  keySignals: KeySignal[]
  directQuotes: DirectQuote[]
  recommendations: string[]
}

export interface KeySignal {
  signal: string
  transcript: string
  implication: string
}

export interface DirectQuote {
  quote: string
  source: string
  timestamp: string
}

export type Severity = 'High' | 'Medium' | 'Low'
export type Horizon = 'Immediate' | 'Near-term' | 'Long-term'

export interface DisruptionSignal {
  id: number
  title: string
  severity: Severity
  horizon: Horizon
  impactedRevenue: string
  defendOffendMove: string
  evidence?: string
  productLine?: string
}

export interface MoatCategory {
  category: string
  signal: string
  evidence: string
  commbankAdvantage: string
  actionableInsight: string
  confidenceLevel: 'High' | 'Medium' | 'Low'
}

export interface MoatIntelligence {
  generated: string
  moats: MoatCategory[]
  analysis: string
}

export interface NewsArticle {
  id: number
  title: string
  source: string
  category: string
  publishedAt: string
  summary: string
  url: string
  relevanceScore: number
}

export interface ApiResponse<T> {
  success: boolean
  data?: T
  error?: string
  message?: string
}

export interface ApiError {
  error: string
  message?: string
  statusCode?: number
}
