// lib/screens/estimation_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:data_table_2/data_table_2.dart';
import '../providers/estimation_provider.dart';
import '../models/row_item.dart';
import '../services/local_storage.dart';
import '../utils/estimation_calculator.dart';
import '../widgets/chart_widget.dart';

class EstimationScreen extends StatefulWidget {
  const EstimationScreen({super.key});

  @override
  State<EstimationScreen> createState() => _EstimationScreenState();
}

class _EstimationScreenState extends State<EstimationScreen> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _unitController = TextEditingController(text: 'عدد');
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController(text: 'عمومی');

  final List<String> _categories = [
    'عمومی',
    'اسکلت بتنی',
    'اسکلت فلزی',
    'نازک کاری',
    'تاسیسات مکانیکی',
    'تاسیسات الکتریکی',
    'نما کاری',
    'محوطه سازی'
  ];

  final List<String> _units = [
    'عدد',
    'متر',
    'متر مربع',
    'متر مکعب',
    'کیلوگرم',
    'تن',
    'دستگاه',
    'نفر-روز'
  ];

  void _addItem(BuildContext context) {
    final provider = Provider.of<EstimationProvider>(context, listen: false);
    
    final item = RowItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      code: _codeController.text.isNotEmpty ? _codeController.text : 'ITEM-${provider.items.length + 1}',
      description: _descController.text,
      unit: _unitController.text,
      quantity: double.tryParse(_qtyController.text) ?? 0,
      unitPrice: double.tryParse(_priceController.text) ?? 0,
      category: _categoryController.text,
    );

    provider.addItem(item);
    _saveToLocalStorage(provider.items);
    _clearForm();
  }

  void _saveToLocalStorage(List<RowItem> items) {
    final data = items.map((item) => item.toMap()).toList();
    LocalStorage().saveEstimations(data);
  }

  void _clearForm() {
    _codeController.clear();
    _descController.clear();
    _qtyController.clear();
    _priceController.clear();
    _unitController.text = 'عدد';
    _categoryController.text = 'عمومی';
  }

  void _deleteItem(BuildContext context, int index) {
    final provider = Provider.of<EstimationProvider>(context, listen: false);
    provider.deleteItem(index);
    _saveToLocalStorage(provider.items);
  }

  void _clearAll(BuildContext context) {
    final provider = Provider.of<EstimationProvider>(context, listen: false);
    provider.clearItems();
    LocalStorage().saveEstimations([]);
  }

  void _loadFromStorage(BuildContext context) async {
    final provider = Provider.of<EstimationProvider>(context, listen: false);
    final data = LocalStorage().getEstimations();
    provider.clearItems();
    
    for (var itemData in data) {
      provider.addItem(RowItem.fromMap(itemData));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadFromStorage(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EstimationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('برآورد متره - تدکار'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _clearAll(context),
            tooltip: 'پاک کردن همه',
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveToLocalStorage(provider.items),
            tooltip: 'ذخیره',
          ),
        ],
      ),
      body: Column(
        children: [
          // فرم ورود داده
          _buildInputForm(context),
          
          // جدول داده‌ها
          Expanded(
            child: _buildDataTable(context, provider.items),
          ),
          
          // خلاصه و نمودار
          _buildSummarySection(context, provider.items),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addItem(context),
        backgroundColor: Colors.blue[800],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildInputForm(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                // کد فهرست
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _codeController,
                    decoration: const InputDecoration(
                      labelText: 'کد فهرست',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                
                // دسته‌بندی
                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField<String>(
                    value: _categoryController.text,
                    decoration: const InputDecoration(
                      labelText: 'دسته‌بندی',
                      border: OutlineInputBorder(),
                    ),
                    items: _categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _categoryController.text = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // شرح آیتم
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'شرح کامل آیتم',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            
            Row(
              children: [
                // مقدار
                Expanded(
                  child: TextField(
                    controller: _qtyController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'مقدار',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                
                // واحد
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _unitController.text,
                    decoration: const InputDecoration(
                      labelText: 'واحد',
                      border: OutlineInputBorder(),
                    ),
                    items: _units.map((unit) {
                      return DropdownMenuItem(
                        value: unit,
                        child: Text(unit),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _unitController.text = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                
                // بهای واحد
                Expanded(
                  child: TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'بهای واحد (ریال)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable(BuildContext context, List<RowItem> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 1000,
        columns: const [
          DataColumn2(label: Text('ردیف'), size: ColumnSize.S),
          DataColumn2(label: Text('کد'), size: ColumnSize.S),
          DataColumn2(label: Text('شرح آیتم'), size: ColumnSize.L),
          DataColumn2(label: Text('دسته‌بندی'), size: ColumnSize.M),
          DataColumn2(label: Text('مقدار'), size: ColumnSize.S),
          DataColumn2(label: Text('واحد'), size: ColumnSize.S),
          DataColumn2(label: Text('بهای واحد'), size: ColumnSize.M),
          DataColumn2(label: Text('جمع'), size: ColumnSize.M),
          DataColumn2(label: Text('عملیات'), size: ColumnSize.S),
        ],
        rows: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          
          return DataRow2(
            cells: [
              DataCell(Text('${index + 1}')),
              DataCell(Text(item.code)),
              DataCell(Text(item.description)),
              DataCell(Text(item.category)),
              DataCell(Text(item.quantity.toString())),
              DataCell(Text(item.unit)),
              DataCell(Text('${item.unitPrice.toStringAsFixed(2)} ریال')),
              DataCell(Text('${item.totalPrice.toStringAsFixed(2)} ریال',
                style: const TextStyle(fontWeight: FontWeight.bold))),
              DataCell(
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteItem(context, index),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

Widget _buildSummarySection(BuildContext context, List<RowItem> items) {
  // اگه آیتمی وجود نداشت
  if (items.isEmpty) {
    return const Center(
      child: Text("هیچ داده‌ای وجود ندارد"),
    );
  }

  // محاسبه جمع کل و دسته‌بندی‌ها
  final grandTotal = EstimationCalculator.calculateTotal(items);
  final categoryTotals = EstimationCalculator.calculateCategoryTotals(items);

  // نمایش نتایج
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "جمع کل: $grandTotal",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        ...categoryTotals.entries.map(
          (entry) => Text(
            "${entry.key}: ${entry.value}",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    ),
  );
}
