import 'package:flutter/material.dart';

// screens
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

void main() {
  runApp(MetreyarApp());
}

class MetreyarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metreyar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/projects': (context) => ProjectsScreen(),
        '/contracts': (context) => ContractsScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/features': (context) => FeaturesScreen(),
        '/feature': (context) => FeatureScreen(),
        '/metering': (context) => MeteringScreen(),
        '/price_list': (context) => PriceListScreen(),
        '/report': (context) => ReportScreen(),
        '/settings': (context) => SettingsScreen(),
        '/workflow': (context) => WorkflowScreen(),
      },
    );
  }
}
