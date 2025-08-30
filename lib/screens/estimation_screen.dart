import 'package:flutter/material.dart';
import '../models/row_item.dart';
import '../utils/estimation_calculator.dart';
import '../widgets/data_table_widget.dart';
import '../widgets/chart_widget.dart';

class EstimationScreen extends StatefulWidget {
  EstimationScreen({super.key});

  @override
  State<EstimationScreen> createState() => _EstimationScreenState();
}

class _EstimationScreenState extends State<EstimationScreen> {
  final List<RowItem> _items = [];
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _addItem() {
    final newItem = RowItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      code: 'ITEM-${_items.length + 1}',
      description: _descController.text,
      unit: 'عدد',
      quantity: double.tryParse(_qtyController.text) ?? 0,
      unitPrice: double.tryParse(_priceController.text) ?? 0,
      category: 'عمومی',
    );

    setState(() {
      _items.add(newItem);
    });

    _descController.clear();
    _qtyController.clear();
    _priceController.clear();
  }

  double get _grandTotal {
    return EstimationCalculator.calculateTotal(_items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('برآورد متره')),
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
                        decoration: InputDecoration(labelText: 'بهای و��حد'),
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _addItem,
                      child: Text('افزودن'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            
            // جدول داده‌ها
            Expanded(
              child: DataTableWidget(items: _items),
            ),
            
            // خلاصه مالی
            ChartWidget(items: _items),
            
            // جمع کل
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'جمع کل: ${_grandTotal.toStringAsFixed(2)} ریال',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
