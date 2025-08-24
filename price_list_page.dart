import 'package:flutter/material.dart';
import '../widgets/responsive_scaffold.dart';
import '../widgets/data_table_widget.dart';

class PriceListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: DataTableWidget(),
      ),
    );
  }
}
