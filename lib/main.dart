import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Import صفحات
import 'screens/dashboard_screen.dart';
import 'screens/features_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/workflow_screen.dart';
import 'screens/home_screen.dart';
import 'screens/analysis_screen.dart';
import 'screens/contracts_screen.dart';
import 'screens/projects_screen.dart';
import 'screens/report_screen.dart';
import 'screens/price_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => DashboardScreen(), // Stateful => no const
        ),
        GoRoute(
          path: '/features',
          builder: (context, state) => FeaturesScreen(), // Stateful => no const
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => SettingsScreen(), // Stateful => no const
        ),
        GoRoute(
          path: '/workflow',
          builder: (context, state) => WorkflowScreen(), // Stateful => no const
        ),
        GoRoute(
          path: '/analysis',
          builder: (context, state) => const AnalysisScreen(),
        ),
        GoRoute(
          path: '/contracts',
          builder: (context, state) => const ContractsScreen(),
        ),
        GoRoute(
          path: '/projects',
          builder: (context, state) => const ProjectsScreen(),
        ),
        GoRoute(
          path: '/report',
          builder: (context, state) => const ReportScreen(),
        ),
        GoRoute(
          path: '/price-list',
          builder: (context, state) => const PriceListScreen(),
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: _router,
      title: 'Metreyar Flutter Web',
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
