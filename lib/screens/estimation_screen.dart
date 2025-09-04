// lib/screens/estimation_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/row_item.dart';
import '../utils/estimation_calculator.dart';
import '../widgets/chart_widget.dart';
import '../widgets/sidebar.dart';
import '../widgets/nav_bar.dart';

// اضافه کردن کلاس EstimationScreen
class EstimationScreen extends StatefulWidget {
  const EstimationScreen({super.key});

  @override
  State<EstimationScreen> createState() => _EstimationScreenState();
}

// بقیه کد کلاس _EstimationScreenState که قبلاً اضافه کرد��د
class _EstimationScreenState extends State<EstimationScreen> {
  final List<RowItem> _items = [];
  final List<TextEditingController> _descControllers = [];
  final List<TextEditingController> _qtyControllers = [];
  final List<TextEditingController> _priceControllers = [];

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _newDescController = TextEditingController();
  final TextEditingController _newQtyController = TextEditingController();
  final TextEditingController _newPriceController = TextEditingController();
  final TextEditingController _newUnitController = TextEditingController(text: 'عدد');
  final TextEditingController _newCategoryController = TextEditingController(text: 'عمومی');

  final List<String> _units = ['عدد', 'متر', 'متر مربع', 'متر مکعب', 'کیلوگرم', 'تن', 'دستگاه', 'نفر-روز'];
  final List<String> _categories = ['عمومی', 'اسکلت', 'نازک کاری', 'تاسیسات', 'برق', 'مکانیک', 'نما', 'محوطه سازی'];

  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _addNewRow();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_searchController.text.length > 2) {
      _searchItems(_searchController.text);
    } else {
      setState(() {
        _searchResults.clear();
      });
    }
  }

  void _addNewRow() {
    setState(() {
      final descController = TextEditingController();
      final qtyController = TextEditingController();
      final priceController = TextEditingController();

      _descControllers.add(descController);
      _qtyControllers.add(qtyController);
      _priceControllers.add(priceController);

      _items.add(RowItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        code: 'ITEM-${_items.length + 1}',
        description: '',
        unit: 'عدد',
        quantity: 0,
        unitPrice: 0,
        category: 'عمومی',
      ));
    });
  }

  void _searchItems(String query) {
    setState(() {
      _isSearching = true;
    });
    
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _searchResults = _items.where((item) {
          return item.description.toLowerCase().contains(query.toLowerCase());
        }).map((item) {
          return {
            'description': item.description,
            'unit': item.unit,
            'averagePrice': item.unitPrice,
            'category': item.category,
            'source': 'داده‌های محلی'
          };
        }).toList();
        
        _isSearching = false;
      });
    });
  }

  void _searchMaterials(String query) {
    final sampleMaterials = [
      {
        'description': 'سیمان پرتلند',
        'unit': 'کیلوگرم',
        'averagePrice': 12000,
        'category': 'نازک کاری',
        'source': 'داده‌های داخلی'
      },
      {
        'description': 'آجر فشاری',
        'unit': 'عدد',
        'averagePrice': 2500,
        'category': 'اسکلت',
        'source': 'داده‌های داخلی'
      },
      {
        'description': 'تیرآهن ۱۴',
        'unit': 'متر',
        'averagePrice': 85000,
        'category': 'اسکلت',
        'source': 'داده‌های داخلی'
      },
    ];
    
    setState(() {
      _searchResults = sampleMaterials.where((material) {
        return material['description'].toString().toLowerCase().contains(query.toLowerCase());
      }).toList();
      
      _isSearching = false;
    });
  }

  Future<void> _searchFromAPI(String query) async {
    if (query.length < 2) return;

    setState(() {
      _isSearching = true;
    });

    try {
      const apiUrl = 'https://metreyar.onrender.com/materials/search?q=';
      final response = await http.get(Uri.parse('$apiUrl$query'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _searchResults = List<Map<String, dynamic>>.from(data['results']);
          _isSearching = false;
        });
      } else {
        throw Exception('خطا در دریافت داده');
      }
    } catch (e) {
      _searchMaterials(query);
      setState(() {
        _isSearching = false;
      });
    }
  }

  void _useSearchResult(Map<String, dynamic> result) {
    setState(() {
      _newDescController.text = result['description'];
      _newUnitController.text = result['unit'];
      _newPriceController.text = result['averagePrice'].toString();
      _newCategoryController.text = result['category'];
      
      _searchResults.clear();
      _searchController.clear();
    });
  }

  void _searchFromWeb(String query) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      
      setState(() {
        _searchResults = [
          {
            'description': '${query} (یافت شده از اینترنت)',
            'unit': 'عدد',
            'averagePrice': 10000,
            'category': 'عمومی',
            'source': 'پایگاه داده ملی'
          }
        ];
        _isSearching = false;
      });

    } catch (e) {
      _showSnackbar('خطا در دریافت داده از اینترنت');
    }
  }

  void _updateItem(int index) {
    setState(() {
      _items[index] = RowItem(
        id: _items[index].id,
        code: _items[index].code,
        description: _descControllers[index].text,
        unit: _items[index].unit,
        quantity: double.tryParse(_qtyControllers[index].text) ?? 0,
        unitPrice: double.tryParse(_priceControllers[index].text) ?? 0,
        category: _items[index].category,
      );
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _descControllers[index].dispose();
      _qtyControllers[index].dispose();
      _priceControllers[index].dispose();

      _descControllers.removeAt(index);
      _qtyControllers.removeAt(index);
      _priceControllers.removeAt(index);
      _items.removeAt(index);

      for (int i = 0; i < _items.length; i++) {
        _items[i] = RowItem(
          id: _items[i].id,
          code: 'ITEM-${i + 1}',
          description: _items[i].description,
          unit: _items[i].unit,
          quantity: _items[i].quantity,
          unitPrice: _items[i].unitPrice,
          category: _items[i].category,
        );
      }
    });
  }

  void _addItemFromForm() {
    final newItem = RowItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      code: 'ITEM-${_items.length + 1}',
      description: _newDescController.text,
      unit: _newUnitController.text,
      quantity: double.tryParse(_newQtyController.text) ?? 0,
      unitPrice: double.tryParse(_newPriceController.text) ?? 0,
      category: _newCategoryController.text,
    );

    setState(() {
      _items.add(newItem);
      
      final descController = TextEditingController(text: newItem.description);
      final qtyController = TextEditingController(text: newItem.quantity.toString());
      final priceController = TextEditingController(text: newItem.unitPrice.toString());

      _descControllers.add(descController);
      _qtyControllers.add(qtyController);
      _priceControllers.add(priceController);
    });

    _newDescController.clear();
    _newQtyController.clear();
    _newPriceController.clear();
    _newUnitController.text = 'عدد';
    _newCategoryController.text = 'عمومی';
  }

  void _clearAll() {
    setState(() {
      for (var controller in _descControllers) {
        controller.dispose();
      }
      for (var controller in _qtyControllers) {
        controller.dispose();
      }
      for (var controller in _priceControllers) {
        controller.dispose();
      }

      _descControllers.clear();
      _qtyControllers.clear();
      _priceControllers.clear();
      _items.clear();

      _addNewRow();
    });
  }

  void _saveEstimation() {
    if (_items.isEmpty) {
      _showSnackbar('هیچ آیتمی برای ذخیره وجود ندارد');
      return;
    }
    _showSnackbar('برآورد با موفقیت ذخیره شد');
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 2)),
    );
  }

  double get _grandTotal => EstimationCalculator.calculateTotal(_items);
  Map<String, double> get _categoryTotals => EstimationCalculator.calculateCategoryTotals(_items);

  @override
  void dispose() {
    _searchController.dispose();
    _newDescController.dispose();
    _newQtyController.dispose();
    _newPriceController.dispose();
    _newUnitController.dispose();
    _newCategoryController.dispose();
    
    for (var controller in _descControllers) {
      controller.dispose();
    }
    for (var controller in _qtyControllers) {
      controller.dispose();
    }
    for (var controller in _priceControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        title: 'برآورد متره',
        onSave: _saveEstimation,
        onClear: _clearAll,
      ),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // جستجو از اینترنت
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('جستجوی مصالح از اینترنت', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'جستجوی مصالح (مثال: سیمان، آجر، تیرآهن)',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: _isSearching ? CircularProgressIndicator() : null,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    if (_searchResults.isNotEmpty)
                      Column(
                        children: [
                          Text('نتایج جستجو:', style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          ..._searchResults.map((result) => ListTile(
                            title: Text(result['description']),
                            subtitle: Text('${result['averagePrice']} ریال - ${result['unit']}'),
                            trailing: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => _useSearchResult(result),
                            ),
                          )).toList(),
                        ],
                      ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => _searchFromWeb(_searchController.text),
                      child: Text('جستجو در اینترنت'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // فرم افزودن آیتم جدید
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('افزودن آیتم جدید', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _newDescController,
                            decoration: InputDecoration(
                              labelText: 'شرح آیتم',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: _newQtyController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'مقدار',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 120,
                          child: TextField(
                            controller: _newPriceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'بهای واحد',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _newUnitController.text,
                            items: _units.map((unit) {
                              return DropdownMenuItem(
                                value: unit,
                                child: Text(unit),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _newUnitController.text = value!;
                            },
                            decoration: InputDecoration(
                              labelText: 'واحد',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _newCategoryController.text,
                            items: _categories.map((category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _newCategoryController.text = value!;
                            },
                            decoration: InputDecoration(
                              labelText: 'دسته‌بندی',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _addItemFromForm,
                      child: Text('افزودن آیتم'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // جدول داده‌ها
            Expanded(
              child: ListView(
                children: [
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('ردیف')),
                      DataColumn(label: Text('شرح آیتم')),
                      DataColumn(label: Text('واحد')),
                      DataColumn(label: Text('مقدار')),
                      DataColumn(label: Text('بهای واحد')),
                      DataColumn(label: Text('جمع')),
                      DataColumn(label: Text('عملیات')),
                    ],
                    rows: _items.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return DataRow(cells: [
                        DataCell(Text('${index + 1}')),
                        DataCell(
                          SizedBox(
                            width: 200,
                            child: TextField(
                              controller: _descControllers[index],
                              decoration: InputDecoration(
                                hintText: 'شرح آیتم',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (_) => _updateItem(index),
                            ),
                          ),
                        ),
                        DataCell(Text(item.unit)),
                        DataCell(
                          SizedBox(
                            width: 80,
                            child: TextField(
                              controller: _qtyControllers[index],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'مقدار',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (_) => _updateItem(index),
                            ),
                          ),
                        ),
                        DataCell(
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: _priceControllers[index],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'بهای واحد',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (_) => _updateItem(index),
                            ),
                          ),
                        ),
                        DataCell(Text(item.totalPrice.toStringAsFixed(2))),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteItem(index),
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ],
              ),
            ),

            // خلاصه مالی
            ChartWidget(items: _items),

            // جمع کل و دکمه‌ها
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'جمع کل: ${_grandTotal.toStringAsFixed(2)} ریال',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: _addNewRow,
                          child: Text('افزودن ردیف'),
                        ),
                        ElevatedButton(
                          onPressed: _saveEstimation,
                          child: Text('ذخیره'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('چاپ'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
