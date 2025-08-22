import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/features_screen.dart';
import 'screens/about_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/features',
        builder: (context, state) => FeaturesScreen(),
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => AboutScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Metreyar Flutter Web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}
