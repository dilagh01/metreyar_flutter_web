import 'screens/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
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
      ),
    );
  }
}
