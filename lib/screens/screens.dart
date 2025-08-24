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
import 'price_list_page.dart';
import 'report_screen.dart';
import 'features_screen.dart';
import 'feature_card.dart';

// تعریف Map صفحات
final Map<String, Widget Function()> pagesMap = {
  "داشبورد": () => const DashboardScreen(),
  "خانه": () => const HomeScreen(),
  "پروژه‌ها": () => const ProjectsScreen(),
  "متره": () => const MeteringScreen(),
  "تحلیل": () => const AnalysisScreen(),
  "قراردادها": () => const ContractsScreen(),
  "تنظیمات": () => const SettingsScreen(),
  "جریان‌کار": () => const WorkflowScreen(),
  "لیست قیمت": () => const PriceListScreen(),
  "صفحه لیست قیمت": () => const PriceListPage(),
  "گزارش": () => const ReportScreen(),
  "ویژگی‌ها": () => const FeaturesScreen(),
  "ویژگی کارت": () => const FeatureCardScreen(),
};

// ساخت لیست AppPage پویا از Map
class AppPage {
  final String title;
  final IconData icon;
  final Widget page;

  AppPage({required this.title, required this.icon, required this.page});
}

// 📌 ساخت لیست پویا از Map
final List<AppPage> appPages = pagesMap.entries.map((entry) {
  IconData icon;
  switch (entry.key) {
    case "داشبورد":
      icon = Icons.dashboard;
      break;
    case "خانه":
      icon = Icons.home;
      break;
    case "پروژه‌ها":
      icon = Icons.work;
      break;
    case "متره":
      icon = Icons.calculate;
      break;
    case "تحلیل":
      icon = Icons.analytics;
      break;
    case "قراردادها":
      icon = Icons.description;
      break;
    case "تنظیمات":
      icon = Icons.settings;
      break;
    case "جریان‌کار":
      icon = Icons.timeline;
      break;
    case "لیست قیمت":
    case "صفحه لیست قیمت":
      icon = Icons.list_alt;
      break;
    case "گزارش":
      icon = Icons.bar_chart;
      break;
    case "ویژگی‌ها":
      icon = Icons.star;
      break;
    case "ویژگی کارت":
      icon = Icons.credit_card;
      break;
    default:
      icon = Icons.pages;
  }

  return AppPage(title: entry.key, icon: icon, page: entry.value());
}).toList();
