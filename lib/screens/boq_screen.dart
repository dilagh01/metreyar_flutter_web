import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/boq_item.dart';
import '../providers/boq_provider.dart';

class BOQScreen extends StatelessWidget {
  const BOQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BOQProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('صورت وضعیت (BOQ)'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: provider.items.length,
              itemBuilder: (context, index) {
                final item = provider.items[index];
                return ListTile(
                  title: Text(item.description),
                  subtitle: Text(
                      '${item.quantity} ${item.unit} × ${item.unitPrice} = ${item.totalPrice.toStringAsFixed(0)} تومان'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => provider.removeItemAt(index),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              'جمع کل: ${provider.totalCost.toStringAsFixed(0)} تومان',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.addItem(BOQItem(
            id: provider.items.length + 1,
            description: "آیتم نمونه",
            unit: "متر",
            quantity: 10,
            unitPrice: 5000,
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
