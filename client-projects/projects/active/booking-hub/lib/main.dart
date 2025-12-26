import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io' show Platform;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'injection.dart';
import 'app.dart';
import 'services/logger_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Load environment variables
    const environment = String.fromEnvironment('ENVIRONMENT', defaultValue: 'development');
    await dotenv.load(fileName: '.env.$environment');

    // Initialize sqflite for desktop platforms
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    // Initialize services
    LoggerService.initialize();

    // Setup dependency injection
    await setupServiceLocator();

    runApp(const MyApp());
  } catch (e) {
    LoggerService.error('Failed to initialize app', error: e);
    rethrow;
  }
}
