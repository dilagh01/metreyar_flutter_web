import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Screens
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/metering/metering_screen.dart';
import 'screens/analysis/analysis_screen.dart';
import 'screens/contracts/contracts_screen.dart';
import 'screens/projects/projects_screen.dart';
import 'screens/workflow/workflow_screen.dart';
import 'screens/settings/settings_screen.dart';

void main() {
  runApp(const MetreyarApp());
}

class MetreyarApp extends StatelessWidget {
  const MetreyarApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (c, s) => const DashboardScreen()),
        GoRoute(path: '/metering', builder: (c, s) => const MeteringScreen()),
        GoRoute(path: '/analysis', builder: (c, s) => const AnalysisScreen()),
        GoRoute(path: '/contracts', builder: (c, s) => const ContractsScreen()),
        GoRoute(path: '/projects', builder: (c, s) => const ProjectsScreen()),
        GoRoute(path: '/workflow', builder: (c, s) => const WorkflowScreen()),
        GoRoute(path: '/settings', builder: (c, s) => const SettingsScreen()),
      ],
    );

    return MaterialApp.router(
      title: 'Metreyar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
