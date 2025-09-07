import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/boq_provider.dart';
import 'screens/boq_screen.dart';

void main() {
  runApp(const MetreyarApp());
}

class MetreyarApp extends StatelessWidget {
  const MetreyarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BOQProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Metreyar',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green).copyWith(
            secondary: Colors.greenAccent,
          ),
        ),
        home: const BOQScreen(),
      ),
    );
  }
}
