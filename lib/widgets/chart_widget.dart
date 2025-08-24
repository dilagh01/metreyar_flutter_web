import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartWidget extends StatelessWidget {
  final List<BarChartGroupData> barData;

  const ChartWidget({super.key, required this.barData});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: _findMaxY(),
        barTouchData: BarTouchData(enabled: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index >= 0 && index < barData.length) {
                  return Text(barData[index].x.toString());
                }
                return const Text('');
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: barData,
      ),
    );
  }

  double _findMaxY() {
    double maxY = 0;
    for (var group in barData) {
      for (var rod in group.barRods) {
        if (rod.toY > maxY) maxY = rod.toY;
      }
    }
    return maxY + 1;
  }
}
