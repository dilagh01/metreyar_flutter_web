import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/projects_screen.dart';
import 'screens/contracts_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/features_screen.dart';
import 'screens/feature_screen.dart';
import 'screens/metering_screen.dart';
import 'screens/price_list_screen.dart';
import 'screens/report_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/workflow_screen.dart';
import 'screens/analysis_screen.dart'; // یادت نره بسازی

void main() {
  runApp(MetreyarApp());
}

class MetreyarApp extends StatelessWidget {
  MetreyarApp({super.key});

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/projects', builder: (context, state) => const ProjectsScreen()),
      GoRoute(path: '/contracts', builder: (context, state) => const ContractsScreen()),
      GoRoute(path: '/dashboard', builder: (context, state) => const DashboardScreen()),
      GoRoute(path: '/analysis', builder: (context, state) => const AnalysisScreen()),
      GoRoute(path: '/features', builder: (context, state) => const FeaturesScreen()),
      GoRoute(path: '/feature', builder: (context, state) => const FeatureScreen()),
      GoRoute(path: '/metering', builder: (context, state) => const MeteringScreen()),
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
      ),
      routerConfig: _router,
    );
  }
}
