import 'package:flutter/material.dart';
import '../widgets/chart_widget.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Home / Sample Chart', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: ChartWidget(
              barData: [
                BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 5, color: Colors.blue)]),
                BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 3, color: Colors.red)]),
                BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 7, color: Colors.green)]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
