import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/routes.dart';
import 'config/theme_config.dart';
import 'providers/app_state_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/connectivity_provider.dart';
import 'screens/splash/splash_screen.dart';

/// Root application widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // App state providers
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
      ],
      child: Consumer2<ThemeProvider, AppStateProvider>(
        builder: (context, themeProvider, appState, _) {
          return MaterialApp(
            title: 'Small App',
            debugShowCheckedModeBanner: false,
            theme: ThemeConfig.lightTheme,
            darkTheme: ThemeConfig.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const SplashScreen(),
            onGenerateRoute: RouteGenerator.generateRoute,
            navigatorObservers: [
              // Add analytics or logging observers here
            ],
          );
        },
      ),
    );
  }
}
