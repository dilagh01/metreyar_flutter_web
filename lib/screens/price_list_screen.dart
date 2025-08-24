import 'package:flutter/material.dart';
import '../widgets/data_table_widget.dart';

class PriceListScreen extends StatelessWidget {
  const PriceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          Text('Price List', style: TextStyle(fontSize: 18)),
          SizedBox(height: 16),
          DataTableWidget(),
        ],
      ),
    );
  }
}
