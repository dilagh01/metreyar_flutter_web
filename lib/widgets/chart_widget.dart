import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartWidget extends StatelessWidget {
  final List<charts.Series> seriesList = [
    charts.Series<int, String>(
      id: 'Progress',
      domainFn: (int progress, _) => 'مرحله ${_ + 1}',
      measureFn: (int progress, _) => progress,
      data: [10, 30, 50, 70, 90],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(seriesList, animate: true);
  }
}
