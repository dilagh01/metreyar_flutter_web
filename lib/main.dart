import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/projects_screen.dart';
import 'screens/contracts_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/features_screen.dart';
import 'screens/estimation_screen.dart';
import 'screens/price_list_screen.dart';
import 'screens/report_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/analysis_screen.dart';
import 'screens/workflow_screen.dart';

void main() {
  runApp(const MetreyarApp());
}

class MetreyarApp extends StatelessWidget {
  const MetreyarApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/home', // مسیر پیش‌فرض
    routes: [
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/projects', builder: (context, state) => const ProjectsScreen()),
      GoRoute(path: '/contracts', builder: (context, state) => const ContractsScreen()),
      GoRoute(path: '/dashboard', builder: (context, state) => const DashboardScreen()),
      GoRoute(path: '/analysis', builder: (context, state) => const AnalysisScreen()),
      GoRoute(path: '/features', builder: (context, state) => const FeaturesScreen()),
      GoRoute(path: '/estimation', builder: (context, state) => const EstimationScreen()),
      GoRoute(path: '/price-list', builder: (context, state) => const PriceListScreen()),
      GoRoute(path: '/report', builder: (context, state) => const ReportScreen()),
      GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
      GoRoute(path: '/workflow', builder: (context, state) => const WorkflowScreen()),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "متره یار",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Vazir",
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
