import 'package:flutter/material.dart';
import 'screens/screens_list.dart'; // برای ScreensGrid

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dynamic Screens App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScreensGrid(), // صفحه داشبورد
    );
  }
}
