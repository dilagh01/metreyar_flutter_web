import 'package:flutter/material.dart';
import '../widgets/responsive_scaffold.dart';
import '../widgets/chart_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("داشبورد پروژه‌ها", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Expanded(child: ChartWidget()),
          ],
        ),
      ),
    );
  }
}
