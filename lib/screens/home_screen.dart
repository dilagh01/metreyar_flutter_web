import 'package:flutter/material.dart';
import '../widgets/row_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحه اصلی'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            RowItem(col1: 'ردیف 1', col2: 'مقدار 1'),
            RowItem(col1: 'ردیف 2', col2: 'مقدار 2'),
            RowItem(col1: 'ردیف 3', col2: 'مقدار 3'),
          ],
        ),
      ),
    );
  }
}
