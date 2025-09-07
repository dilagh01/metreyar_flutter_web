import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import‌های placeholder (بعداً با مسیر واقعی پروژه جایگزین کن)
import 'providers/estimation_provider.dart';
import 'screens/materials_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EstimationProvider()),
      ],
      child: const MetreyarApp(),
    ),
  );
}

class MetreyarApp extends StatelessWidget {
  const MetreyarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metreyar Flutter Web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const MaterialsScreen(),
    );
  }
}
