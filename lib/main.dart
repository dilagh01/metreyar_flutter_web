// lib/main.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// Screens
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/estimation_screen.dart';
import 'screens/analysis_screen.dart';

// Providers
import 'providers/estimation_provider.dart';

// Services
import 'services/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage().init();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EstimationProvider()),
      ],
      child: MetreyarApp(),
    ),
  );
}

class MetreyarApp extends StatelessWidget {
  MetreyarApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
      GoRoute(path: '/estimation', builder: (context, state) => EstimationScreen()),
      GoRoute(path: '/analysis', builder: (context, state) => AnalysisScreen()),
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
