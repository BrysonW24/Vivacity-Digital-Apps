import { NextRequest, NextResponse } from 'next/server'

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const category = searchParams.get('category') || 'all'
    const limit = parseInt(searchParams.get('limit') || '10')

    const mockNewsData = [
      {
        id: 1,
        title: 'Federal Reserve signals AI-driven monetary policy analysis',
        source: 'Financial Times',
        category: 'central-banking',
        publishedAt: new Date().toISOString(),
        summary: 'Fed exploring machine learning models to enhance economic forecasting',
        url: 'https://example.com/article1',
        relevanceScore: 0.92
      },
      {
        id: 2,
        title: 'Major banks announce AI ethics consortium',
        source: 'Bloomberg',
        category: 'ai-governance',
        publishedAt: new Date(Date.now() - 86400000).toISOString(),
        summary: 'Top global banks collaborate on responsible AI deployment standards',
        url: 'https://example.com/article2',
        relevanceScore: 0.88
      },
      {
        id: 3,
        title: 'Fintech unicorn raises 500M for AI lending platform',
        source: 'TechCrunch',
        category: 'fintech',
        publishedAt: new Date(Date.now() - 172800000).toISOString(),
        summary: 'Alternative lender uses AI to approve loans in under 60 seconds',
        url: 'https://example.com/article3',
        relevanceScore: 0.85
      },
      {
        id: 4,
        title: 'APRA releases guidance on AI risk management',
        source: 'Australian Financial Review',
        category: 'regulation',
        publishedAt: new Date(Date.now() - 259200000).toISOString(),
        summary: 'Australian regulators outline expectations for AI governance in banking',
        url: 'https://example.com/article4',
        relevanceScore: 0.95
      },
      {
        id: 5,
        title: 'Customer expectations shift toward conversational banking',
        source: 'McKinsey Report',
        category: 'customer-experience',
        publishedAt: new Date(Date.now() - 345600000).toISOString(),
        summary: 'Study shows 70% of customers prefer AI chat over traditional channels',
        url: 'https://example.com/article5',
        relevanceScore: 0.81
      }
    ]

    const filteredNews = category === 'all' 
      ? mockNewsData 
      : mockNewsData.filter(item => item.category === category)

    return NextResponse.json({
      success: true,
      count: filteredNews.length,
      news: filteredNews.slice(0, limit)
    })
  } catch (error) {
    console.error('Error fetching news:', error)
    return NextResponse.json(
      { error: 'Failed to fetch news' },
      { status: 500 }
    )
  }
}
