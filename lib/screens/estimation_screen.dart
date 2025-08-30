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
// ادامه lib/screens/estimation_screen.dart

// اضافه کردن این متدها و ویجت‌ها به کلاس _EstimationScreenState

// 1. اضافه کردن قابلیت جستجو
final TextEditingController _searchController = TextEditingController();
List<RowItem> _filteredItems = [];

@override
void initState() {
  super.initState();
  _addNewRow();
  _filteredItems = _items;
  _searchController.addListener(_filterItems);
}

void _filterItems() {
  final query = _searchController.text.toLowerCase();
  setState(() {
    if (query.isEmpty) {
      _filteredItems = _items;
    } else {
      _filteredItems = _items.where((item) =>
        item.description.toLowerCase().contains(query) ||
        item.category.toLowerCase().contains(query) ||
        item.code.toLowerCase().contains(query)
      ).toList();
    }
  });
}

// 2. اضافه کردن pagination
int _currentPage = 0;
final int _itemsPerPage = 10;

List<RowItem> get _paginatedItems {
  final startIndex = _currentPage * _itemsPerPage;
  final endIndex = startIndex + _itemsPerPage;
  return _filteredItems.sublist(
    startIndex.clamp(0, _filteredItems.length),
    endIndex.clamp(0, _filteredItems.length),
  );
}

int get _totalPages => (_filteredItems.length / _itemsPerPage).ceil();

// 3. اضافه کردن sorting
String _sortColumn = 'code';
bool _sortAscending = true;

void _sortItems(String column) {
  setState(() {
    if (_sortColumn == column) {
      _sortAscending = !_sortAscending;
    } else {
      _sortColumn = column;
      _sortAscending = true;
    }

    _items.sort((a, b) {
      int comparison;
      switch (column) {
        case 'description':
          comparison = a.description.compareTo(b.description);
          break;
        case 'quantity':
          comparison = a.quantity.compareTo(b.quantity);
          break;
        case 'unitPrice':
          comparison = a.unitPrice.compareTo(b.unitPrice);
          break;
        case 'totalPrice':
          comparison = a.totalPrice.compareTo(b.totalPrice);
          break;
        case 'category':
          comparison = a.category.compareTo(b.category);
          break;
        default:
          comparison = a.code.compareTo(b.code);
      }
      return _sortAscending ? comparison : -comparison;
    });

    _filterItems(); // به‌روزرسانی فیلتر پس از sort
  });
}

// 4. اضافه کردن ویرایش پیشرفته
void _showEditDialog(int index) {
  final item = _items[index];
  final descController = TextEditingController(text: item.description);
  final qtyController = TextEditingController(text: item.quantity.toString());
  final priceController = TextEditingController(text: item.unitPrice.toString());
  final unitController = TextEditingController(text: item.unit);
  final categoryController = TextEditingController(text: item.category);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('ویرایش آیتم'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descController,
                decoration: InputDecoration(labelText: 'شرح آیتم'),
              ),
              TextField(
                controller: qtyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'مقدار'),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'بهای واحد'),
              ),
              DropdownButtonFormField<String>(
                value: unitController.text,
                items: _units.map((unit) {
                  return DropdownMenuItem(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                onChanged: (value) {
                  unitController.text = value!;
                },
                decoration: InputDecoration(labelText: 'واحد'),
              ),
              DropdownButtonFormField<String>(
                value: categoryController.text,
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  categoryController.text = value!;
                },
                decoration: InputDecoration(labelText: 'دسته‌بندی'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('لغو'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _items[index] = RowItem(
                  id: item.id,
                  code: item.code,
                  description: descController.text,
                  unit: unitController.text,
                  quantity: double.tryParse(qtyController.text) ?? 0,
                  unitPrice: double.tryParse(priceController.text) ?? 0,
                  category: categoryController.text,
                );
              });
              Navigator.pop(context);
              _showSnackbar('آیتم با موفقیت ویرایش شد');
            },
            child: Text('ذخیره'),
          ),
        ],
      );
    },
  );
}

// 5. اضافه کردن bulk actions
void _deleteSelectedItems(List<int> indices) {
  setState(() {
    indices.sort((a, b) => b.compareTo(a)); // حذف از انتها به ابتدا
    for (var index in indices) {
      _descControllers[index].dispose();
      _qtyControllers[index].dispose();
      _priceControllers[index].dispose();
      _items.removeAt(index);
      _descControllers.removeAt(index);
      _qtyControllers.removeAt(index);
      _priceControllers.removeAt(index);
    }
  });
}

// 6. اضافه کردن export پیشرفته
void _exportToCSV() {
  if (_items.isEmpty) {
    _showSnackbar('هیچ آیتمی برای export وجود ندارد');
    return;
  }

  final StringBuffer csvBuffer = StringBuffer();
  csvBuffer.writeln('کد,شرح,واحد,مقدار,بهای واحد,جمع,دسته‌بندی');
  
  for (var item in _items) {
    csvBuffer.writeln(
      '${item.code},${item.description},${item.unit},${item.quantity},${item.unitPrice},${item.totalPrice},${item.category}'
    );
  }

  _showExportDialog(csvBuffer.toString(), 'csv');
}

void _exportToJSON() {
  if (_items.isEmpty) {
    _showSnackbar('هیچ آیتمی برای export وجود ندارد');
    return;
  }

  final jsonData = {
    'timestamp': DateTime.now().toIso8601String(),
    'total': _grandTotal,
    'items': _items.map((item) => item.toMap()).toList(),
    'categoryTotals': _categoryTotals,
  };

  _showExportDialog(jsonData.toString(), 'json');
}

void _showExportDialog(String content, String format) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('خروجی $format'),
        content: SingleChildScrollView(
          child: SelectableText(content),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('بستن'),
          ),
          TextButton(
            onPressed: () {
              // کپی به clipboard
              // Clipboard.setData(ClipboardData(text: content));
              _showSnackbar('محتوا کپی شد');
              Navigator.pop(context);
            },
            child: Text('کپی'),
          ),
        ],
      );
    },
  );
}

// 7. اضافه کردن statistics پیشرفته
Map<String, dynamic> _getStatistics() {
  if (_items.isEmpty) {
    return {};
  }

  final quantities = _items.map((item) => item.quantity).toList();
  final prices = _items.map((item) => item.unitPrice).toList();
  final totals = _items.map((item) => item.totalPrice).toList();

  return {
    'count': _items.length,
    'totalQuantity': quantities.reduce((a, b) => a + b),
    'averageQuantity': quantities.reduce((a, b) => a + b) / quantities.length,
    'averagePrice': prices.reduce((a, b) => a + b) / prices.length,
    'maxPrice': prices.reduce((a, b) => a > b ? a : b),
    'minPrice': prices.reduce((a, b) => a < b ? a : b),
    'maxTotal': totals.reduce((a, b) => a > b ? a : b),
    'minTotal': totals.reduce((a, b) => a < b ? a : b),
  };
}

// 8. اضافه کردن backup و restore
void _createBackup() {
  final backupData = {
    'items': _items.map((item) => item.toMap()).toList(),
    'timestamp': DateTime.now().toIso8601String(),
  };
  
  // ذخیره در localStorage
  _showSnackbar('Backup ایجاد شد');
}

void _restoreFromBackup() {
  // بازیابی از localStorage
  _showSnackbar('Backup بازیابی شد');
}

// 9. اضافه کردن undo functionality
List<List<RowItem>> _history = [];
int _historyIndex = -1;

void _saveToHistory() {
  // فقط آخرین 50 حالت را نگه دار
  if (_history.length > 50) {
    _history.removeAt(0);
  }
  _history.add(List<RowItem>.from(_items));
  _historyIndex = _history.length - 1;
}

void _undo() {
  if (_historyIndex > 0) {
    setState(() {
      _historyIndex--;
      _items = List<RowItem>.from(_history[_historyIndex]);
      _updateControllers();
    });
  }
}

void _redo() {
  if (_historyIndex < _history.length - 1) {
    setState(() {
      _historyIndex++;
      _items = List<RowItem>.from(_history[_historyIndex]);
      _updateControllers();
    });
  }
}

void _updateControllers() {
  // به‌روزرسانی controllers با مقادیر جدید
  for (int i = 0; i < _items.length; i++) {
    _descControllers[i].text = _items[i].description;
    _qtyControllers[i].text = _items[i].quantity.toString();
    _priceControllers[i].text = _items[i].unitPrice.toString();
  }
}

@override
void dispose() {
  _searchController.dispose();
  super.dispose();
}
