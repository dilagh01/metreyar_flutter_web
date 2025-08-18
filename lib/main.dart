import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chart Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Sample Bar Chart',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ChartWidget(
                barData: [
                  BarChartGroupData(
                      x: 0,
                      barRods: [BarChartRodData(toY: 5, color: Colors.blue)]),
                  BarChartGroupData(
                      x: 1,
                      barRods: [BarChartRodData(toY: 3, color: Colors.red)]),
                  BarChartGroupData(
                      x: 2,
                      barRods: [BarChartRodData(toY: 7, color: Colors.green)]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartWidget extends StatelessWidget {
  final List<BarChartGroupData> barData;

  const ChartWidget({Key? key, required this.barData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _findMaxY(),
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
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
    return maxY + 1; // کمی فضای بالا اضافه می‌کنیم
  }
}
