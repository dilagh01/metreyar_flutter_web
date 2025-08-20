import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('🏠 Home Page', style: TextStyle(fontSize: 28)),
    );
  }
}

class PriceListScreen extends StatelessWidget {
  const PriceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('💰 Price List Page', style: TextStyle(fontSize: 28)),
    );
  }
}

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('📊 Report Page', style: TextStyle(fontSize: 28)),
    );
  }
}
