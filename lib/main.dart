import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// مسیر جدید برای screens
import 'screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
        GoRoute(path: '/features', builder: (context, state) => const FeaturesScreen()),
        GoRoute(path: '/price-list', builder: (context, state) => const PriceListScreen()),
        GoRoute(path: '/analysis', builder: (context, state) => const AnalysisScreen()),
        GoRoute(path: '/contracts', builder: (context, state) => const ContractsScreen()),
        GoRoute(path: '/workflow', builder: (context, state) => const WorkflowScreen()),
        GoRoute(path: '/dashboard', builder: (context, state) => const DashboardScreen()),
        GoRoute(path: '/report', builder: (context, state) => const ReportScreen()),
        GoRoute(path: '/projects', builder: (context, state) => const ProjectsScreen()),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      title: 'Metreyar Flutter Web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
