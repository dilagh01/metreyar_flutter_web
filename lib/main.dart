import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// صفحات نمونه
import 'screens/home_screen.dart';
import 'screens/projects_screen.dart';
import 'screens/analysis_screen.dart';
import 'screens/contracts_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // تعریف مسیرها با GoRouter
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/projects',
        builder: (context, state) => ProjectsScreen(),
      ),
      GoRoute(
        path: '/analysis',
        builder: (context, state) => AnalysisScreen(),
      ),
      GoRoute(
        path: '/contracts',
        builder: (context, state) => ContractsScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => SettingsScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Metreyar Flutter Web',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _router,
    );
  }
}

// نمونه صفحات ساده (در فایل های جداگانه screens/*.dart ایجاد شود)
// مثلا screens/home_screen.dart:
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('صفحه اصلی'),
            ElevatedButton(
              onPressed: () => context.go('/projects'),
              child: Text('برو به Projects'),
            ),
          ],
        ),
      ),
    );
  }
}

// screens/projects_screen.dart:
class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Projects')),
      body: Center(child: Text('صفحه Projects')),
    );
  }
}

// screens/analysis_screen.dart:
class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Analysis')),
      body: Center(child: Text('صفحه Analysis')),
    );
  }
}

// screens/contracts_screen.dart:
class ContractsScreen extends StatelessWidget {
  const ContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contracts')),
      body: Center(child: Text('صفحه Contracts')),
    );
  }
}

// screens/settings_screen.dart:
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(child: Text('صفحه Settings')),
    );
  }
}
