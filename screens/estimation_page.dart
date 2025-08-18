import 'package:flutter/material.dart';
import '../widgets/responsive_scaffold.dart';
import '../widgets/data_table_widget.dart';

class EstimationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("متره و برآورد", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Expanded(child: DataTableWidget()),
          ],
        ),
      ),
    );
  }
}
