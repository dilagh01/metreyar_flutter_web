import 'package:flutter/material.dart';

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

// Widgets
import 'widgets/sidebar.dart';
import 'widgets/footer.dart';
import 'widgets/header.dart';
import 'widgets/nav_bar.dart';
import 'widgets/responsive_scaffold.dart';
import 'widgets/row_item.dart';
import 'widgets/row_editor.dart';
import 'widgets/data_table_widget.dart';
import 'widgets/chart_widget.dart';
import 'widgets/feature_card.dart';
import 'widgets/new_widget.dart';

void main() {
  runApp(MetreyarApp());
}

class MetreyarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "متره یار",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Vazir",
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
