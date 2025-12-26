import 'package:get_it/get_it.dart';
import 'services/api/api_client.dart';
import 'services/auth_service.dart';
import 'services/storage_service.dart';
import 'services/secure_storage_service.dart';
import 'services/connectivity_service.dart';
import 'services/notification_service.dart';
import 'services/logger_service.dart';
import 'repositories/auth_repository.dart';
import 'repositories/user_repository.dart';
import 'repositories/settings_repository.dart';
import 'repositories/notification_repository.dart';

/// Service locator instance
final getIt = GetIt.instance;

/// Setup service locator with all dependencies
Future<void> setupServiceLocator() async {
  // Register services (singletons)
  getIt.registerSingleton<ApiClient>(ApiClient());
  getIt.registerSingleton<StorageService>(StorageService());
  getIt.registerSingleton<SecureStorageService>(SecureStorageService());
  getIt.registerSingleton<ConnectivityService>(ConnectivityService());
  getIt.registerSingleton<NotificationService>(NotificationService());
  getIt.registerSingleton<LoggerService>(LoggerService());

  // Register services that depend on other services
  getIt.registerSingleton<AuthService>(
    AuthService(
      apiClient: getIt<ApiClient>(),
      secureStorage: getIt<SecureStorageService>(),
    ),
  );

  // Register repositories
  getIt.registerSingleton<AuthRepository>(
    AuthRepository(
      apiClient: getIt<ApiClient>(),
      authService: getIt<AuthService>(),
    ),
  );

  getIt.registerSingleton<UserRepository>(
    UserRepository(
      apiClient: getIt<ApiClient>(),
    ),
  );

  getIt.registerSingleton<SettingsRepository>(
    SettingsRepository(
      apiClient: getIt<ApiClient>(),
      storage: getIt<StorageService>(),
    ),
  );

  getIt.registerSingleton<NotificationRepository>(
    NotificationRepository(
      apiClient: getIt<ApiClient>(),
    ),
  );

  LoggerService.info('Service locator initialized');
}
