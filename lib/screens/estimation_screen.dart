// lib/screens/estimation_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/estimation_provider.dart';
import '../models/row_item.dart';
import '../widgets/data_table_widget.dart';
import '../widgets/chart_widget.dart';

class EstimationScreen extends StatefulWidget {
  EstimationScreen({super.key});

  @override
  State<EstimationScreen> createState() => _EstimationScreenState();
}

class _EstimationScreenState extends State<EstimationScreen> {
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _addItem(BuildContext context) {
    final provider = Provider.of<EstimationProvider>(context, listen: false);
    
    final item = RowItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      code: 'ITEM-${provider.items.length + 1}',
      description: _descController.text,
      unit: 'عدد',
      quantity: double.tryParse(_qtyController.text) ?? 0,
      unitPrice: double.tryParse(_priceController.text) ?? 0,
      category: 'عمومی',
    );

    provider.addItem(item);
    
    _descController.clear();
    _qtyController.clear();
    _priceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EstimationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('برآورد متره'),
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // فرم افزودن آیتم
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _descController,
                        decoration: InputDecoration(labelText: 'شرح آیتم'),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        controller: _qtyController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'مقدار'),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 120,
                      child: TextField(
                        controller: _priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'بهای واحد'),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _addItem(context),
                      child: Text('افزودن'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            
            // جدول داده‌ها
            Expanded(
              child: DataTableWidget(items: provider.items),
            ),
            
            // نمودار و جمع کل
            ChartWidget(items: provider.items),
          ],
        ),
      ),
    );
  }
}
