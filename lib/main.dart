import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app/router.dart'; // Import صحیح

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'متره یار',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Vazirmatn',
      ),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
