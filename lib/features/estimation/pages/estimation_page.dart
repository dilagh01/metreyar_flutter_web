import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EstimationPage extends StatelessWidget {
  const EstimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('برآورد پروژه'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/welcome'),
        ),
      ),
      body: const Center(
        child: Text('صفحه برآورد پروژه'),
      ),
    );
  }
}
