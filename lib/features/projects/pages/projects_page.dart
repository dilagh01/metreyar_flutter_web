import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مدیریت پروژه‌ها'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/welcome'),
        ),
      ),
      body: const Center(
        child: Text('صفحه مدیریت پروژه‌ها'),
      ),
    );
  }
}
