import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تحلیل"),
        centerTitle: true,
      ),
      drawer: SideBar(
        onItemTap: (route) {
          Navigator.pushNamed(context, route);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "صفحه تحلیل",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "اینجا نتایج تحلیل داده‌ها نمایش داده خواهد شد.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            // بعداً میشه نمودارها و جدول‌های تحلیل رو اینجا اضافه کرد
          ],
        ),
      ),
    );
  }
}
