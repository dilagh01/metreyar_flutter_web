import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/home_page.dart';
import 'screens/price_list_page.dart';
import 'screens/estimation_page.dart';
import 'screens/reports_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => HomePage()),
      GoRoute(path: '/price-list', builder: (context, state) => PriceListPage()),
      GoRoute(path: '/estimation', builder: (context, state) => EstimationPage()),
      GoRoute(path: '/reports', builder: (context, state) => ReportsPage()),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TADKAR Demo',
      routerConfig: _router,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
