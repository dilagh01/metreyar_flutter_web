import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartWidget extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;

  ChartWidget({Key? key, List<charts.Series<dynamic, String>>? series})
      : seriesList = series ?? _createSampleData(),
        super(key: key);

  static List<charts.Series<dynamic, String>> _createSampleData() {
    final data = [
      {"مرحله": "مرحله 1", "مقدار": 20},
      {"مرحله": "مرحله 2", "مقدار": 40},
      {"مرحله": "مرحله 3", "مقدار": 60},
      {"مرحله": "مرحله 4", "مقدار": 80},
    ];

    return [
      charts.Series<dynamic, String>(
        id: 'Progress',
        domainFn: (datum, _) => datum["مرحله"],
        measureFn: (datum, _) => datum["مقدار"],
        data: data,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(seriesList, animate: true);
  }
}
