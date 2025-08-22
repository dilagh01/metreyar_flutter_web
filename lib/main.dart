import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// صفحه Features
class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({super.key}); // سازنده const

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Features')),
      body: const Center(child: Text('Features Screen')),
    );
  }
}

// صفحه Home
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/features'),
          child: const Text('Go to Features'),
        ),
      ),
    );
  }
}

void main() {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/features',
        builder: (context, state) => const FeaturesScreen(),
      ),
    ],
  );

  runApp(MyApp(router: _router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Metreyar Flutter Web',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
