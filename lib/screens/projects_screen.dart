// lib/screens/projects_screen.dart
import 'package:flutter/material.dart';

class ProjectsScreen extends StatelessWidget {
  ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('مدیریت پروژه‌ها')),
      body: ListView(
        children: [
          ListTile(title: Text('پروژه ساختمان مسکونی')),
          ListTile(title: Text('پروژه تجاری')),
          ListTile(title: Text('پروژه اداری')),
        ],
      ),
    );
  }
}
