import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/boq_provider.dart';
import '../widgets/custom_table.dart';
import '../models/boq_item.dart';

class BOQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BOQProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("متره و برآورد")),
      body: Column(
        children: [
          Expanded(child: CustomTable()),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("جمع کل: ${provider.totalCost.toStringAsFixed(0)}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text("ردیف جدید"),
                  onPressed: () => provider.addItem(BOQItem(
                      id: provider.items.length + 1,
                      description: "",
                      unit: "",
                      quantity: 0,
                      unitPrice: 0)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
