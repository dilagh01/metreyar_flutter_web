import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/dashboard_screen.dart';
import 'screens/projects_screen.dart';
import 'screens/metering_screen.dart';
import 'screens/analysis_screen.dart';
import 'screens/contracts_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/workflow_screen.dart';
import 'screens/price_list_screen.dart';
import 'screens/report_screen.dart';
import 'screens/features_screen.dart';
import 'widgets/nav_bar.dart';
import 'widgets/footer.dart';

void main() {
  runApp(const MetreyarApp());
}

class MetreyarApp extends StatelessWidget {
  const MetreyarApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/dashboard',
      routes: [
        ShellRoute(
          builder: (context, state, child) => AppScaffold(child: child),
          routes: [
            GoRoute(path: '/dashboard', builder: (c, s) => const DashboardScreen()),
            GoRoute(path: '/projects', builder: (c, s) => const ProjectsScreen()),
            GoRoute(path: '/metering', builder: (c, s) => const MeteringScreen()),
            GoRoute(path: '/analysis', builder: (c, s) => const AnalysisScreen()),
            GoRoute(path: '/contracts', builder: (c, s) => const ContractsScreen()),
            GoRoute(path: '/settings', builder: (c, s) => const SettingsScreen()),
            GoRoute(path: '/workflow', builder: (c, s) => const WorkflowScreen()),
            GoRoute(path: '/price-list', builder: (c, s) => const PriceListScreen()),
            GoRoute(path: '/report', builder: (c, s) => const ReportScreen()),
            GoRoute(path: '/features', builder: (c, s) => const FeaturesScreen()),
          ],
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Metreyar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        fontFamily: 'IRANSans',
      ),
      routerConfig: router,
    );
  }
}

/// Scaffold اصلی با NavBar و Footer
class AppScaffold extends StatelessWidget {
  final Widget child;
  const AppScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: const NavBar(),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
