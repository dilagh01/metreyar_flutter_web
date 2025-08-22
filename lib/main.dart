import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// جلوگیری از تداخل اسم
import 'screens/projects/projects_screen.dart' as projects_module;

import 'screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/projects', builder: (context, state) => const projects_module.ProjectsScreen()),
      GoRoute(path: '/metering', builder: (context, state) => const MeteringScreen()),
      GoRoute(path: '/analysis', builder: (context, state) => const AnalysisScreen()),
      GoRoute(path: '/contracts', builder: (context, state) => const ContractsScreen()),
      GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
      GoRoute(path: '/workflow', builder: (context, state) => const WorkflowScreen()),
      GoRoute(path: '/dashboard', builder: (context, state) => const DashboardScreen()),
      GoRoute(path: '/price-list', builder: (context, state) => const PriceListScreen()),
      GoRoute(path: '/report', builder: (context, state) => const ReportScreen()),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Metreyar Flutter Web',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
