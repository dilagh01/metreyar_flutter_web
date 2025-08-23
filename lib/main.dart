import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// import screens
import 'screens/screens.dart'; // فایل بارل توی screens

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
        path: '/projects',
        builder: (context, state) => ProjectsScreen(),
      ),
      GoRoute(
        path: '/metering',
        builder: (context, state) => MeteringScreen(),
      ),
      GoRoute(
        path: '/analysis',
        builder: (context, state) => AnalysisScreen(),
      ),
      GoRoute(
        path: '/contracts',
        builder: (context, state) => ContractsScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => SettingsScreen(),
      ),
      GoRoute(
        path: '/workflow',
        builder: (context, state) => WorkflowScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => DashboardScreen(),
      ),
      GoRoute(
        path: '/price-list',
        builder: (context, state) => PriceListScreen(),
      ),
      GoRoute(
        path: '/report',
        builder: (context, state) => ReportScreen(),
      ),
      // features
      GoRoute(
        path: '/features',
        builder: (context, state) => FeaturesScreen(),
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
