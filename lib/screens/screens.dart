// Screens
export 'home_screen.dart';
export 'projects_screen.dart';
export 'metering_screen.dart';
export 'analysis_screen.dart';
export 'contracts_screen.dart';
export 'settings_screen.dart';
export 'workflow_screen.dart';
export 'dashboard_screen.dart';
export 'price_list_screen.dart';
export 'report_screen.dart';

// Features
export 'features_screen.dart';

// Widgets
export '../widgets/footer.dart';
export '../widgets/nav_bar.dart';

// --- تعریف لیست صفحات پویا ---
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'projects_screen.dart';
import 'metering_screen.dart';
import 'analysis_screen.dart';
import 'contracts_screen.dart';
import 'settings_screen.dart';
import 'workflow_screen.dart';
import 'dashboard_screen.dart';
import 'price_list_screen.dart';
import 'report_screen.dart';
import 'features_screen.dart';

class AppPage {
  final String title;
  final IconData icon;
  final Widget page;

  const AppPage({required this.title, required this.icon, required this.page});
}

// 📌 لیست پویا از تمام صفحات
final List<AppPage> appPages = [
  AppPage(title: "داشبورد", icon: Icons.dashboard, page: const DashboardScreen()),
  AppPage(title: "خانه", icon: Icons.home, page: const HomeScreen()),
  AppPage(title: "پروژه‌ها", icon: Icons.work, page: const ProjectsScreen()),
  AppPage(title: "متره", icon: Icons.calculate, page: const MeteringScreen()),
  AppPage(title: "تحلیل", icon: Icons.analytics, page: const AnalysisScreen()),
  AppPage(title: "قراردادها", icon: Icons.description, page: const ContractsScreen()),
  AppPage(title: "تنظیمات", icon: Icons.settings, page: const SettingsScreen()),
  AppPage(title: "جریان‌کار", icon: Icons.timeline, page: const WorkflowScreen()),
  AppPage(title: "لیست قیمت", icon: Icons.list_alt, page: const PriceListScreen()),
  AppPage(title: "گزارش", icon: Icons.bar_chart, page: const ReportScreen()),
  AppPage(title: "ویژگی‌ها", icon: Icons.star, page: const FeaturesScreen()),
];
