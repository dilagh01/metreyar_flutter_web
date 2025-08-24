
import 'package:flutter/material.dart';
import 'screens/screens_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'اپلیکیشن پویا',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ScreensList(),
    );
  }
}

