import { useQuery } from '@tanstack/react-query'
import { useAuthStore } from '@stores/auth'
import { apiClient } from '@services/apiClient'

interface User {
  id: string
  email: string
  name: string
  role: string
}

interface AuthState {
  user: User | null
  isAuthenticated: boolean
  isLoading: boolean
}

export function useAuth(): AuthState {
  const { user, setUser, clearAuth } = useAuthStore()

  const { isLoading } = useQuery({
    queryKey: ['auth', 'user'],
    queryFn: async () => {
      try {
        const response = await apiClient.get('/api/auth/me')
        setUser(response.data)
        return response.data
      } catch (error) {
        clearAuth()
        throw error
      }
    },
    retry: 1,
    enabled: !user,
  })

  return {
    user: user || null,
    isAuthenticated: !!user,
    isLoading,
  }
}
