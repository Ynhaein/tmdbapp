import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmdb_app/config/theme/app_theme.dart'; 
import 'package:tmdb_app/core/presentation/page/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(AppTheme.systemUiOverlayStyle);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      themeMode: ThemeMode.dark, 
      theme: AppTheme.baseTheme(), 
      home: const SplashScreen() 
    );
  }
}