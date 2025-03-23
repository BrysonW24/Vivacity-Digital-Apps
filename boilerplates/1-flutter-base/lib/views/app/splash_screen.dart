import 'package:flutter/material.dart';

/// The initial screen shown when the app starts.
///
/// Can be used for:
/// - Showing a logo while initializing
/// - Running dependency injection or auth checks
/// - Navigating to login/home once ready

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 60),
      ),
    );
  }
}
