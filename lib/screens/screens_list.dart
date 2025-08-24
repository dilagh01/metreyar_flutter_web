import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'features_screen.dart';
import 'feature_card.dart';
import 'feature_screen.dart';
import 'home_screen.dart';
import 'metering_screen.dart';
import 'price_list_screen.dart';
import 'price_list_page.dart';
import 'projects_screen.dart';
import 'report_screen.dart';
import 'settings_screen.dart';
import 'workflow_screen.dart';

class ScreensList extends StatelessWidget {
  const ScreensList({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      {'title': 'داشبورد', 'page': const DashboardScreen()},
      {'title': 'ویژگی‌ها', 'page': const FeaturesScreen()},
      {'title': 'ویژگی کارت', 'page': const FeatureCardScreen()},
      {'title': 'ویژگی صفحه', 'page': const FeatureScreen()},
      {'title': 'خانه', 'page': const HomeScreen()},
      {'title': 'اندازه‌گیری', 'page': const MeteringScreen()},
      {'title': 'لیست قیمت‌ها', 'page': const PriceListScreen()},
      {'title': 'صفحه لیست قیمت', 'page': const PriceListPage()},
      {'title': 'پروژه‌ها', 'page': const ProjectsScreen()},
      {'title': 'گزارش‌ها', 'page': const ReportScreen()},
      {'title': 'تنظیمات', 'page': const SettingsScreen()},
      {'title': 'گردش کار', 'page': const WorkflowScreen()},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('لیست صفحات')),
      body: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final page = pages[index];
          return ListTile(
            title: Text(page['title'] as String),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => page['page'] as Widget),
              );
            },
          );
        },
      ),
    );
  }
}
