import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';

class ProjectsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("پروژه‌ها")),
      body: const Center(
        child: Text("اینجا لیست پروژه‌ها نشون داده میشه"),
      ),
    );
  }
}
