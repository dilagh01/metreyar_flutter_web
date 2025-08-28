import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class EstimationScreen extends StatelessWidget {
  const EstimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("متره و برآورد - نسخه اکسل"),
        backgroundColor: Colors.blue[700],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: ExcelStyleEstimationTable(),
      ),
    );
  }
}

class ExcelStyleEstimationTable extends StatefulWidget {
  const ExcelStyleEstimationTable({super.key});

  @override
  _ExcelStyleEstimationTableState createState() => _ExcelStyleEstimationTableState();
}

class _ExcelStyleEstimationTableState extends State<ExcelStyleEstimationTable> {
  final List<EstimationItem> _items = []; // لیست خالی

  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  void _addItem() {
    setState(() {
      final newItem = EstimationItem(
        rowNumber: _items.length + 1,
        code: "",
        description: "",
        unit: "عدد", // مقدار پیش‌فرض
        quantity: 1,
        unitPrice: 0,
      );
      _items.add(newItem);
    });
  }

  void _removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      setState(() {
        _items.removeAt(index);
        // به روز رسانی شماره ردیف‌ها
        _updateRowNumbers();
      });
    }
  }

  void _insertItem(int index) {
    if (index >= 0 && index <= _items.length) {
      setState(() {
        final newItem = EstimationItem(
          rowNumber: index + 1,
          code: "",
          description: "",
          unit: "عدد",
          quantity: 1,
          unitPrice: 0,
        );
        _items.insert(index, newItem);
        // به روز رسانی شماره ردیف‌ها
        _updateRowNumbers();
      });
    }
  }

  void _updateRowNumbers() {
    for (int i = 0; i < _items.length; i++) {
      _items[i].rowNumber = i + 1;
    }
  }

  double get _grandTotal {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  String _formatNumber(double number) {
    if (number == 0) return "0";
    return number.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 200,
      color: Colors.grey[50],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.table_chart_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              "هیچ آیتمی وجود ندارد",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "برای شروع، یک ردیف جدید اضافه کنید",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
              label: const Text("افزودن اولین ردیف"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExcelHeader() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: Row(
        children: [
          // ستون شماره ردیف
          Container(
            width: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey[400]!)),
            ),
            child: const Center(
              child: Text(
                "ردیف",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // ستون کد فهرست
          Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey[400]!)),
            ),
            child: const Center(
              child: Text(
                "کد فهرست",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // ستون شرح
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey[400]!)),
              ),
              child: const Center(
                child: Text(
                  "شرح آیتم",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // ستون واحد
          Container(
            width: 80,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey[400]!)),
            ),
            child: const Center(
              child: Text(
                "واحد",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // ستون مقدار
          Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey[400]!)),
            ),
            child: const Center(
              child: Text(
                "مقدار",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // ستون بهای واحد
          Container(
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey[400]!)),
            ),
            child: const Center(
              child: Text(
                "بهای واحد (ریال)",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // ستون بهای کل
          Container(
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey[400]!)),
            ),
            child: const Center(
              child: Text(
                "بهای کل (ریال)",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // ستون عملیات
          Container(
            width: 80,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: const Center(
              child: Text(
                "عملیات",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExcelRow(EstimationItem item, int index) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: index.isEven ? Colors.white : Colors.grey[50],
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          // ستون شماره ردیف
          Container(
            width: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Center(child: Text(item.rowNumber.toString())),
          ),
          // ستون کد فهرست
          Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey[300]!)),
            ),
            child: TextFormField(
              initialValue: item.code,
              onChanged: (val) => setState(() => item.code = val),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: "کد",
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          // ستون شرح
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey[300]!)),
              ),
              child: TextFormField(
                initialValue: item.description,
                onChanged: (val) => setState(() => item.description = val),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: "شرح آیتم",
                  hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          // ستون واحد
          Container(
            width: 80,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey[300]!)),
            ),
            child: TextFormField(
              initialValue: item.unit,
              onChanged: (val) => setState(() => item.unit = val),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: "واحد",
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          // ستون مقدار
          Container(
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey[300]!)),
            ),
            child: TextFormField(
              initialValue: item.quantity.toString(),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                setState(() {
                  item.quantity = double.tryParse(val) ?? item.quantity;
                });
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: "0",
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          // ستون بهای واحد
          Container(
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey[300]!)),
            ),
            child: TextFormField(
              initialValue: item.unitPrice == 0 ? "" : _formatNumber(item.unitPrice),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                setState(() {
                  final cleanValue = val.replaceAll(',', '');
                  item.unitPrice = double.tryParse(cleanValue) ?? item.unitPrice;
                });
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: "0",
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),
          // ستون بهای کل
          Container(
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Center(
              child: Text(
                _formatNumber(item.totalPrice),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: item.totalPrice > 0 ? Colors.blue : Colors.grey,
                ),
              ),
            ),
          ),
          // ستون عملیات
          Container(
            width: 80,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.add, size: 18),
                  onPressed: () => _insertItem(index + 1),
                  tooltip: "درج ردیف",
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                  onPressed: () => _removeItem(index),
                  tooltip: "حذف ردیف",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // هدر ثابت
        if (_items.isNotEmpty) _buildExcelHeader(),
        
        // بدنه جدول با اسکرول یا حالت خالی
        Expanded(
          child: _items.isEmpty
              ? _buildEmptyState()
              : Scrollbar(
                  controller: _verticalScrollController,
                  thumbVisibility: true,
                  child: Scrollbar(
                    controller: _horizontalScrollController,
                    thumbVisibility: true,
                    notificationPredicate: (notification) => notification.depth == 0,
                    child: SingleChildScrollView(
                      controller: _verticalScrollController,
                      child: SingleChildScrollView(
                        controller: _horizontalScrollController,
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width,
                          ),
                          child: Column(
                            children: [
                              // ردیف‌های داده
                              ..._items.asMap().entries.map((entry) {
                                return _buildExcelRow(entry.value, entry.key);
                              }).toList(),
                              
                              // ردیف جمع کل
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  border: Border.all(color: Colors.blue[200]!),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: const Center(child: Text("جمع")),
                                    ),
                                    Container(
                                      width: 100,
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                      ),
                                    ),
                                    Container(width: 80),
                                    Container(width: 100),
                                    Container(width: 120),
                                    Container(
                                      width: 120,
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Center(
                                        child: Text(
                                          _formatNumber(_grandTotal),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(width: 80),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
        
        // نوار ابزار پایین
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border(top: BorderSide(color: Colors.grey[300]!)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: _addItem,
                icon: const Icon(Icons.add),
                label: Text(_items.isEmpty ? "افزودن اولین ردیف" : "افزودن ردیف جدید"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
              if (_items.isNotEmpty)
                Text(
                  "تعداد ردیف‌ها: ${_items.length} | جمع کل: ${_formatNumber(_grandTotal)} ریال",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class EstimationItem {
  int rowNumber;
  String code;
  String description;
  String unit;
  double quantity;
  double unitPrice;

  EstimationItem({
    required this.rowNumber,
    required this.code,
    required this.description,
    required this.unit,
    required this.quantity,
    required this.unitPrice,
  });

  double get totalPrice => quantity * unitPrice;
}
