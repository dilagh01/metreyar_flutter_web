import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Screens
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/estimation_screen.dart';

void main() {
  runApp(MetreyarApp());
}

class MetreyarApp extends StatelessWidget {
  MetreyarApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/', // تغییر به صفحه اصلی
    routes: [
      GoRoute(path: '/', builder: (context, state) => LoginScreen()), // صفحه لاگین به عنوان صفحه اصلی
      GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
      GoRoute(path: '/estimation', builder: (context, state) => EstimationScreen()),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "متره یار",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Vazir",
      ),
      routerConfig: _router,
    );
  }
}
