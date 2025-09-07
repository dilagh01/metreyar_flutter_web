import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/estimation_provider.dart';
import 'screens/materials_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EstimationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Metreyar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Vazirmatn', // فونت مدرن فارسی
      ),
      home: MaterialsScreen(),
    );
  }
}
