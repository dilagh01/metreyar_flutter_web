import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class EstimationScreen extends StatefulWidget {
  const EstimationScreen({super.key});

  @override
  State<EstimationScreen> createState() => _EstimationScreenState();
}

class _EstimationScreenState extends State<EstimationScreen> {
  List<Map<String, dynamic>> rows = [];
  final List<TextEditingController> _quantityControllers = [];
  final List<TextEditingController> _unitPriceControllers = [];

  int calcTotal(int qty, int unitPrice) => qty * unitPrice;

  void addRow() {
    setState(() {
      final quantityController = TextEditingController(text: '0');
      final unitPriceController = TextEditingController(text: '0');
      
      _quantityControllers.add(quantityController);
      _unitPriceControllers.add(unitPriceController);
      
      rows.add({
        "ردیف": rows.length + 1,
        "کد فهرست": "----",
        "شرح آیتم": "",
        "واحد": "عدد",
        "مقدار": 0,
        "بهای واحد": 0,
        "quantity_controller": quantityController,
        "unit_price_controller": unitPriceController,
      });
    });
  }

  void deleteRow(int index) {
    setState(() {
      _quantityControllers[index].dispose();
      _unitPriceControllers[index].dispose();
      _quantityControllers.removeAt(index);
      _unitPriceControllers.removeAt(index);
      
      rows.removeAt(index);
      for (int i = 0; i < rows.length; i++) {
        rows[i]["ردیف"] = i + 1;
      }
    });
  }

  int get grandTotal {
    int sum = 0;
    for (var row in rows) {
      sum += calcTotal(row["مقدار"], row["بهای واحد"]);
    }
    return sum;
  }

  @override
  void dispose() {
    for (var controller in _quantityControllers) {
      controller.dispose();
    }
    for (var controller in _unitPriceControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("جدول متره قابل ویرایش"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "افزودن ردیف جدید",
            onPressed: addRow,
          ),
        ],
      ),
      body: const Center(
        child: Text('صفحه برآورد - نسخه ساده'),
      ),
    );
  }
}
