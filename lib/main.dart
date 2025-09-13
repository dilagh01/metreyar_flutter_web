// lib/main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MetreyarApp());
}

class MetreyarApp extends StatelessWidget {
  const MetreyarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'متره یار',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Vazirmatn',
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('متره یار - سیستم برآورد پروژه'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.construction,
              size: 64,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              'به متره یار خوش آمدید!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'سیستم مدیریت برآورد پروژه‌های ساختمانی',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to estimation page
              },
              child: const Text('شروع برآورد پروژه'),
            ),
          ],
        ),
      ),
    );
  }
}

