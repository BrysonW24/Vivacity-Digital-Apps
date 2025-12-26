'use client'

import { useState } from 'react'

interface YouTubeUrl {
  id: number
  url: string
}

interface ThoughtLeadershipResult {
  executiveSummary: string
  keySignals: Array<{
    title: string
    insight: string
    citation: string
  }>
  strategicImplications: Array<{
    area: string
    recommendation: string
    rationale: string
  }>
  directQuotes: Array<{
    speaker: string
    quote: string
    timestamp: string
    relevance: string
  }>
  citations: Array<{
    source: string
    quote: string
    relevance: string
  }>
}

export default function ThoughtLeadership() {
  const [urls, setUrls] = useState<YouTubeUrl[]>([
    { id: 1, url: 'https://www.youtube.com/watch?v=6NwK-uq16U8' },
    { id: 2, url: 'https://www.youtube.com/watch?v=nvXj4HTiYqA' },
    { id: 3, url: 'https://www.youtube.com/watch?v=...' },
  ])
  const [isGenerating, setIsGenerating] = useState(false)
  const [result, setResult] = useState<ThoughtLeadershipResult | null>(null)

  const addUrl = () => {
    const newId = urls.length > 0 ? Math.max(...urls.map(u => u.id)) + 1 : 1
    setUrls([...urls, { id: newId, url: 'https://www.youtube.com/watch?v=...' }])
  }

  const updateUrl = (id: number, newUrl: string) => {
    setUrls(urls.map(u => u.id === id ? { ...u, url: newUrl } : u))
  }

  const removeUrl = (id: number) => {
    setUrls(urls.filter(u => u.id !== id))
  }

  const handleGenerate = async () => {
    setIsGenerating(true)
    setResult(null)

    try {
      const response = await fetch('/api/thought-leadership', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ urls: urls.map(u => u.url) }),
      })
      const data = await response.json()

      setTimeout(() => {
        setResult(data)
        setIsGenerating(false)
      }, 2000)
    } catch (error) {
      console.error('Error generating brief:', error)
      setIsGenerating(false)
    }
  }

  const clearQueue = () => {
    setUrls([])
  }

  const handleDownloadPDF = () => {
    window.print()
  }

  return (
    <div className="max-w-6xl mx-auto animate-fade-in">
      <div className="mb-10">
        <h2 className="section-header">Thought Leadership</h2>
        <p className="text-commbank-gray-600 text-lg">
          Convert expert interviews into board-ready AI strategy insights
        </p>
      </div>

      <div className="card mb-8 card-hover">
        <div className="flex items-center gap-3 mb-6">
          <div className="w-12 h-12 bg-gradient-to-br from-blue-500 to-indigo-600 rounded-xl flex items-center justify-center shadow-lg">
            <span className="text-2xl">🎯</span>
          </div>
          <div>
            <h3 className="text-2xl font-bold text-commbank-gray-900">
              Thought Leadership Intake
            </h3>
            <p className="text-commbank-gray-600 mt-1">
              Transform expert insights into executive-ready strategy
            </p>
          </div>
        </div>

        <div className="bg-gradient-to-r from-blue-50 to-indigo-50 p-6 rounded-xl mb-6 border-l-4 border-blue-500">
          <p className="text-commbank-gray-700 leading-relaxed">
            Queue the interviews, podcasts, or conference talks we should mine for CommBank AI strategy.
            Every brief cites transcripts using [T# speaker] notation and is optimized for board packs,
            ExCo updates, and investor notes.
          </p>
        </div>

        {isGenerating && (
          <div className="mb-6 p-6 bg-gradient-to-r from-yellow-50 to-orange-50 rounded-xl border-l-4 border-yellow-500 animate-pulse">
            <div className="flex items-center gap-3">
              <div className="animate-spin rounded-full h-6 w-6 border-b-2 border-yellow-600"></div>
              <p className="text-lg font-bold text-yellow-900">Processing transcripts...</p>
            </div>
          </div>
        )}

        <div className="space-y-4 mb-6">
          {urls.map((item, index) => (
            <div key={item.id} className="flex items-start gap-3">
              <span className="text-commbank-gray-500 font-medium mt-2">{index + 1}.</span>
              <div className="flex-1">
                <label className="block text-sm font-medium text-commbank-gray-700 mb-2">
                  YouTube URL
                </label>
                <input
                  type="text"
                  value={item.url}
                  onChange={(e) => updateUrl(item.id, e.target.value)}
                  className="w-full px-4 py-2 border border-commbank-gray-300 rounded-md focus:ring-2 focus:ring-commbank-yellow focus:border-transparent"
                  placeholder="https://www.youtube.com/watch?v=..."
                />
              </div>
              <button
                onClick={() => removeUrl(item.id)}
                className="mt-8 px-3 py-2 text-red-600 hover:bg-red-50 rounded-md transition-colors"
              >
                Remove
              </button>
            </div>
          ))}
        </div>

        <button
          onClick={addUrl}
          className="text-commbank-gray-700 hover:text-commbank-black font-medium mb-6"
        >
          + Add another URL
        </button>

        <div className="flex gap-4 flex-wrap">
          <button
            onClick={handleGenerate}
            disabled={isGenerating || urls.length === 0}
            className="btn-primary disabled:opacity-50 disabled:cursor-not-allowed disabled:hover:scale-100"
          >
            {isGenerating ? 'Generating...' : 'Generate Thought Leadership Brief'}
          </button>
          <button
            onClick={clearQueue}
            className="btn-secondary"
          >
            Clear queue
          </button>
        </div>
      </div>

      {result && (
        <div className="space-y-6 animate-slide-up">
          <div className="flex items-center justify-between mb-4">
            <h3 className="text-2xl font-bold text-commbank-gray-900">Thought Leadership Brief</h3>
            <button
              onClick={handleDownloadPDF}
              className="px-6 py-2 bg-commbank-gray-800 text-white rounded-lg hover:bg-commbank-gray-700 transition-all font-semibold flex items-center gap-2"
            >
              <span>📄</span>
              Download PDF
            </button>
          </div>

          <div className="bg-gradient-to-r from-blue-600 to-indigo-600 text-white p-6 rounded-xl">
            <h4 className="text-xl font-bold mb-2">THOUGHT LEADERSHIP INTELLIGENCE</h4>
            <p className="text-blue-100">Executive AI Strategy Insights</p>
          </div>

          <div className="card bg-gradient-to-br from-blue-50 to-indigo-50 border-blue-300">
            <h4 className="text-lg font-bold text-blue-900 mb-3">Executive Summary</h4>
            <p className="text-commbank-gray-700 leading-relaxed">{result.executiveSummary}</p>
          </div>

          <div className="space-y-6">
            <h4 className="text-xl font-bold text-commbank-gray-900">Key Signals</h4>
            {result.keySignals.map((signal, idx) => (
              <div key={idx} className="card border-l-4 border-blue-500">
                <h5 className="text-lg font-bold text-commbank-gray-900 mb-3">{signal.title}</h5>
                <div className="space-y-3">
                  <div className="p-4 bg-blue-50 rounded-xl">
                    <p className="text-sm font-bold text-blue-900 mb-2">Insight:</p>
                    <p className="text-commbank-gray-700">{signal.insight}</p>
                  </div>
                  <div className="p-4 bg-gray-100 rounded-xl border-l-2 border-gray-400">
                    <p className="text-xs font-bold text-gray-700 mb-2">Citation:</p>
                    <p className="text-sm text-gray-600 italic">{signal.citation}</p>
                  </div>
                </div>
              </div>
            ))}
          </div>

          <div className="space-y-6">
            <h4 className="text-xl font-bold text-commbank-gray-900">Strategic Implications for CommBank</h4>
            {result.strategicImplications.map((implication, idx) => (
              <div key={idx} className="card border-l-4 border-indigo-500">
                <h5 className="text-lg font-bold text-indigo-900 mb-3">{implication.area}</h5>
                <div className="space-y-3">
                  <div className="p-4 bg-indigo-50 rounded-xl">
                    <p className="text-sm font-bold text-indigo-900 mb-2">Recommendation:</p>
                    <p className="text-commbank-gray-700">{implication.recommendation}</p>
                  </div>
                  <div className="p-4 bg-purple-50 rounded-xl">
                    <p className="text-sm font-bold text-purple-900 mb-2">Rationale:</p>
                    <p className="text-commbank-gray-700">{implication.rationale}</p>
                  </div>
                </div>
              </div>
            ))}
          </div>

          <div className="card bg-gradient-to-br from-yellow-50 to-orange-50 border-yellow-300">
            <h4 className="text-lg font-bold text-orange-800 mb-4">Direct Quotes from Transcripts</h4>
            <div className="space-y-4">
              {result.directQuotes.map((quote, idx) => (
                <div key={idx} className="p-4 bg-white rounded-xl border border-orange-200">
                  <div className="flex items-start justify-between mb-2">
                    <p className="font-bold text-orange-900">{quote.speaker}</p>
                    <span className="text-xs text-gray-500">{quote.timestamp}</span>
                  </div>
                  <p className="text-gray-700 italic mb-3">"{quote.quote}"</p>
                  <p className="text-sm text-gray-600">
                    <span className="font-semibold">Relevance:</span> {quote.relevance}
                  </p>
                </div>
              ))}
            </div>
          </div>

          <div className="card">
            <h4 className="text-lg font-bold text-commbank-gray-900 mb-4">Document Citations</h4>
            <ul className="space-y-4">
              {result.citations.map((citation, idx) => (
                <li key={idx} className="p-4 bg-gray-50 rounded-xl">
                  <p className="font-bold text-blue-600 mb-2">{citation.source}</p>
                  <p className="text-sm text-gray-700 italic mb-2">{citation.quote}</p>
                  <p className="text-sm text-gray-600">{citation.relevance}</p>
                </li>
              ))}
            </ul>
          </div>
        </div>
      )}

      {!result && !isGenerating && (
        <div className="card">
          <h3 className="text-lg font-bold text-commbank-gray-900 mb-4">
            Delivery Principles
          </h3>
          <ul className="space-y-3 text-commbank-gray-700">
            <li className="flex gap-2 items-start">
              <span className="text-blue-600 font-bold mt-1">•</span>
              <span><strong>Key Signals</strong> always cite transcripts using the [T# speaker] notation</span>
            </li>
            <li className="flex gap-2 items-start">
              <span className="text-blue-600 font-bold mt-1">•</span>
              <span>Every section is written for a CommBank executive audience with responsible AI guardrails in mind</span>
            </li>
            <li className="flex gap-2 items-start">
              <span className="text-blue-600 font-bold mt-1">•</span>
              <span>Markdown hierarchy is optimised for board packs ExCo updates and investor notes</span>
            </li>
            <li className="flex gap-2 items-start">
              <span className="text-blue-600 font-bold mt-1">•</span>
              <span><strong>Direct Quotes</strong> section surfaces verbatim lines from transcripts with [T#] citations</span>
            </li>
          </ul>

          <div className="mt-6 pt-6 border-t border-commbank-gray-200">
            <h4 className="font-bold text-commbank-gray-900 mb-2">Evidence-first Posture</h4>
            <p className="text-commbank-gray-700">
              Highlight any assumption that is not backed by transcript evidence before circulating.
              Use the chat to pressure-test actions against CommBank risk appetite and customer promises.
            </p>
          </div>
        </div>
      )}
    </div>
  )
}
