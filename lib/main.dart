import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// import barrel file
import 'screens/screens.dart'; // همه اسکرین‌ها + navbar + footer

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const PageWrapper(child: HomeScreen())),
      GoRoute(path: '/projects', builder: (context, state) => const PageWrapper(child: ProjectsScreen())),
      GoRoute(path: '/metering', builder: (context, state) => const PageWrapper(child: MeteringScreen())),
      GoRoute(path: '/analysis', builder: (context, state) => const PageWrapper(child: AnalysisScreen())),
      GoRoute(path: '/contracts', builder: (context, state) => const PageWrapper(child: ContractsScreen())),
      GoRoute(path: '/settings', builder: (context, state) => const PageWrapper(child: SettingsScreen())),
      GoRoute(path: '/workflow', builder: (context, state) => const PageWrapper(child: WorkflowScreen())),
      GoRoute(path: '/dashboard', builder: (context, state) => const PageWrapper(child: DashboardScreen())),
      GoRoute(path: '/price-list', builder: (context, state) => const PageWrapper(child: PriceListScreen())),
      GoRoute(path: '/report', builder: (context, state) => const PageWrapper(child: ReportScreen())),
      GoRoute(path: '/features', builder: (context, state) => const PageWrapper(child: FeaturesScreen())),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Metreyar Flutter Web',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _router,
    );
  }
}

/// این ویجت وظیفه داره همه صفحات رو با NavBar و Footer بپیچه
class PageWrapper extends StatelessWidget {
  final Widget child;
  const PageWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const NavBar(),
          Expanded(child: child),
          const Footer(),
        ],
      ),
    );
  }
}
