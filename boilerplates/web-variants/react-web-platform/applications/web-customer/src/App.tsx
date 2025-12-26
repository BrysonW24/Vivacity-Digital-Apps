import { Routes, Route } from 'react-router-dom'
import { useAuth } from '@hooks/useAuth'
import Dashboard from '@pages/Dashboard'
import LoginPage from '@pages/LoginPage'
import NotFound from '@pages/NotFound'
import ProtectedRoute from '@components/ProtectedRoute'

export default function App() {
  const { isAuthenticated } = useAuth()

  return (
    <Routes>
      <Route
        path="/login"
        element={<LoginPage />}
      />
      <Route
        path="/"
        element={
          <ProtectedRoute isAuthenticated={isAuthenticated}>
            <Dashboard />
          </ProtectedRoute>
        }
      />
      <Route path="*" element={<NotFound />} />
    </Routes>
  )
}
