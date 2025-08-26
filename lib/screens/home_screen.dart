import 'package:flutter/material.dart';
import '../widgets/responsive_scaffold.dart';
import '../widgets/metreyar_table.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('داشبورد پروژه‌ها', style: Theme.of(context).textTheme.headline5),
            SizedBox(height: 20),
            MetreyarTable(), // جدول نمونه
          ],
        ),
      ),
    );
  }
}
