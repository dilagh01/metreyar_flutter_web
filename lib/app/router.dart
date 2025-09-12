import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

// صفحات پایه
import '../../features/dashboard/pages/dashboard_page.dart';
import '../../features/estimation/pages/estimation_list_page.dart';

// صفحه خطا
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

    // 📦 مصالح (صفحه ساده)
    GoRoute(
      path: '/materials',
      name: 'materials',
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('مدیریت مصالح')),
        body: const Center(child: Text('صفحه مدیریت مصالح')),
      ),
    ),

    // 🏗️ پروژه‌ها (صفحه ساده)
    GoRoute(
      path: '/projects',
      name: 'projects',
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('پروژه‌ها')),
        body: const Center(child: Text('صفحه مدیریت پروژه‌ها')),
      ),
    ),

    // 📊 تحلیل (صفحه ساده)
    GoRoute(
      path: '/analysis',
      name: 'analysis',
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('تحلیل و گزارش')),
        body: const Center(child: Text('صفحه تحلیل و گزارش')),
      ),
    ),

    // ⚙️ تنظیمات (صفحه ساده)
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('تنظیمات')),
        body: const Center(child: Text('صفحه تنظیمات')),
      ),
    ),
  ],

  // 📍 مدیریت خطا
  errorBuilder: (context, state) => const ErrorPage(),
);
