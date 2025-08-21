import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens.dart'; // همه صفحات رو از اینجا می‌گیریم

void main() {
  runApp(const MetreyarApp());
}

class MetreyarApp extends StatelessWidget {
  const MetreyarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Metreyar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),

    // --- ماژول‌ها
    GoRoute(path: '/dashboard', builder: (context, state) => const DashboardScreen()),
    GoRoute(path: '/projects', builder: (context, state) => const ProjectsModuleScreen()),
    GoRoute(path: '/metering', builder: (context, state) => const MeteringScreen()),
    GoRoute(path: '/analysis', builder: (context, state) => const AnalysisScreen()),
    GoRoute(path: '/contracts', builder: (context, state) => const ContractsScreen()),
    GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
    GoRoute(path: '/workflow', builder: (context, state) => const WorkflowScreen()),

    // --- صفحات فرعی
    GoRoute(path: '/reports', builder: (context, state) => const ReportScreen()),
    GoRoute(path: '/price-list', builder: (context, state) => const PriceListScreen()),
    GoRoute(path: '/projects-old', builder: (context, state) => const ProjectsScreen()),
  ],
);
