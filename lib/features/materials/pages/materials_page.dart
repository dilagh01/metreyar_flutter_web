import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MaterialsPage extends StatelessWidget {
  const MaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مدیریت مصالح'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/welcome'),
        ),
      ),
      body: const Center(
        child: Text('صفحه مدیریت مصالح'),
      ),
    );
  }
}
