import 'package:flutter/material.dart';

// 📌 Import همه‌ی صفحات
import 'screens/home_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/projects_screen.dart';
import 'screens/contracts_screen.dart';
import 'screens/analysis_screen.dart';
import 'screens/features_screen.dart';
import 'screens/feature_screen.dart';
import 'screens/feature_card.dart';
import 'screens/meterring_screen.dart';
import 'screens/price_list_screen.dart';
import 'screens/price_list_page.dart';
import 'screens/report_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/workflow_screen.dart';

// اگر فایل screens.dart یک export کلی از همه صفحات دارد می‌توانستی فقط همونو ایمپورت کنی.

void main() {
  runApp(const MetreyarApp());
}

class MetreyarApp extends StatelessWidget {
  const MetreyarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metreyar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // 📌 صفحه پیش‌فرض
      home: HomeScreen(),

      // 📌 تعریف همه route ها
      routes: {
        '/home': (context) => HomeScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/projects': (context) => ProjectsScreen(),
        '/contracts': (context) => ContractsScreen(),
        '/analysis': (context) => AnalysisScreen(),
        '/features': (context) => FeaturesScreen(),
        '/feature': (context) => FeatureScreen(),
        '/featureCard': (context) => FeatureCard(),
        '/metering': (context) => MeteringScreen(),
        '/priceList': (context) => PriceListScreen(),
        '/priceListPage': (context) => PriceListPage(),
        '/report': (context) => ReportScreen(),
        '/settings': (context) => SettingsScreen(),
        '/workflow': (context) => WorkflowScreen(),
      },
    );
  }
}
