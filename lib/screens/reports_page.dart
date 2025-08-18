import 'package:flutter/material.dart';
import '../widgets/responsive_scaffold.dart';
import '../widgets/chart_widget.dart';

class ReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("گزارش‌ها", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    height: 300,
                    child: ChartWidget(),
                  ),
                  SizedBox(height: 24),
                  Container(
                    height: 300,
                    child: ChartWidget(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
