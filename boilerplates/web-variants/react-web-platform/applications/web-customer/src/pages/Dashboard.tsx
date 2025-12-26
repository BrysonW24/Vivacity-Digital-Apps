import { useAuth } from '@hooks/useAuth'
import { useQuery } from '@tanstack/react-query'
import { apiClient } from '@services/apiClient'

interface DashboardData {
  title: string
  description: string
}

export default function Dashboard() {
  const { user } = useAuth()

  const { data, isLoading, error } = useQuery<DashboardData>({
    queryKey: ['dashboard-data'],
    queryFn: async () => {
      const response = await apiClient.get('/api/dashboard')
      return response.data
    },
  })

  if (isLoading) {
    return <div className="p-8">Loading...</div>
  }

  if (error) {
    return <div className="p-8 text-red-600">Error loading dashboard</div>
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <div className="max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:px-8">
        <div className="bg-white rounded-lg shadow">
          <div className="px-4 py-5 sm:px-6">
            <h1 className="text-2xl font-bold text-gray-900">
              Welcome, {user?.name}
            </h1>
            <p className="mt-2 text-gray-600">{data?.description}</p>
          </div>
        </div>
      </div>
    </div>
  )
}
