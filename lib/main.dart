import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'متره یار',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Vazirmatn',
      ),
      home: const Scaffold(
        body: Center(
          child: Text(
            'به متره یار خوش آمدید! 🚀',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
