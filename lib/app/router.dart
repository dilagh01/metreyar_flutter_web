import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

// Import صفحات خود را اینجا اضافه کنید
import '../../features/dashboard/pages/dashboard_page.dart';
import '../../features/auth/pages/login_page.dart';
import '../../features/estimation/pages/estimation_list_page.dart';
import '../../features/materials/pages/materials_page.dart';
import '../../features/projects/pages/projects_page.dart';
import '../../features/analysis/pages/analysis_page.dart';
import '../../features/settings/pages/settings_page.dart';

// صفحه خطا برای routing
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('خطا')),
      body: const Center(
        child: Text('صفحه مورد نظر یافت نشد'),
      ),
    );
  }
}

// تعریف router اصلی
final GoRouter appRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    // 🔐 صفحه ورود
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),

    // 🏠 صفحه اصلی
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardPage(),
    ),

    // 📋 برآوردها
    GoRoute(
      path: '/estimations',
      name: 'estimations',
      builder: (context, state) => const EstimationListPage(),
    ),

    // 📦 مصالح
    GoRoute(
      path: '/materials',
      name: 'materials',
      builder: (context, state) => const MaterialsPage(),
    ),

    // 🏗️ پروژه‌ها
    GoRoute(
      path: '/projects',
      name: 'projects',
      builder: (context, state) => const ProjectsPage(),
    ),

    // 📊 تحلیل
    GoRoute(
      path: '/analysis',
      name: 'analysis',
      builder: (context, state) => const AnalysisPage(),
    ),

    // ⚙️ تنظیمات
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],

  // 📍 مدیریت خطا
  errorBuilder: (context, state) => const ErrorPage(),
);
