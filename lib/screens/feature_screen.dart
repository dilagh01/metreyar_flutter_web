import 'package:flutter/material.dart';

class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ویژگی‌ها')),
      body: const Center(child: Text('صفحه ویژگی‌های تدکار')),
    );
  }
}
