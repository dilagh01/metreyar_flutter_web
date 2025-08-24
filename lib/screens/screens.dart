import 'package:flutter/material.dart';

// Import تمام صفحات
import 'features_screen.dart';
import 'feature_screen.dart';
import 'home_screen.dart';
import 'metering_screen.dart';
import 'projects_screen.dart';
import 'analysis_screen.dart';
import 'contracts_screen.dart';
import 'dashboard_screen.dart';
import 'price_list_screen.dart';
import 'report_screen.dart';
import 'settings_screen.dart';
import 'workflow_screen.dart';

// کلاس AppPage برای تعریف هر صفحه
class AppPage {
  final String title;
  final IconData icon;
  final Widget page;

  AppPage({required this.title, required this.icon, required this.page});
}

// لیست تمام صفحات برای نمایش در Grid
final List<AppPage> appPages = [
  AppPage(title: "خانه", icon: Icons.home, page: HomeScreen()),
  AppPage(title: "ویژگی‌ها", icon: Icons.star, page: FeaturesScreen()),
  AppPage(title: "Feature", icon: Icons.featured_play_list, page: FeatureScreen()),
  AppPage(title: "اندازه‌گیری", icon: Icons.speed, page: MeteringScreen()),
  AppPage(title: "پروژه‌ها", icon: Icons.folder, page: ProjectsScreen()),
  AppPage(title: "تحلیل", icon: Icons.analytics, page: AnalysisScreen()),
  AppPage(title: "قراردادها", icon: Icons.assignment, page: ContractsScreen()),
  AppPage(title: "داشبورد", icon: Icons.dashboard, page: DashboardScreen()),
  AppPage(title: "لیست قیمت", icon: Icons.list, page: PriceListScreen()),
  AppPage(title: "گزارش‌ها", icon: Icons.report, page: ReportScreen()),
  AppPage(title: "تنظیمات", icon: Icons.settings, page: SettingsScreen()),
  AppPage(title: "Workflow", icon: Icons.work, page: WorkflowScreen()),
];
