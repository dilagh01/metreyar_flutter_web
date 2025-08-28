import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:file_picker/file_picker.dart';
import 'services/file_service.dart';
import 'services/pdf_service.dart';

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

  void _importFromExcel() async {
    final importedData = await FileService.importFromExcel();
    if (importedData.isNotEmpty) {
      setState(() {
        // پاک کردن کنترلرهای قبلی
        for (var controller in _quantityControllers) {
          controller.dispose();
        }
        for (var controller in _unitPriceControllers) {
          controller.dispose();
        }
        _quantityControllers.clear();
        _unitPriceControllers.clear();
        
        // اضافه کردن داده‌های جدید
        rows.clear();
        for (var item in importedData) {
          final quantityController = TextEditingController(text: item['مقدار'].toString());
          final unitPriceController = TextEditingController(text: item['بهای واحد'].toString());
          
          _quantityControllers.add(quantityController);
          _unitPriceControllers.add(unitPriceController);
          
          rows.add({
            "ردیف": rows.length + 1,
            "کد فهرست": item['کد فهرست'],
            "شرح آیتم": item['شرح آیتم'],
            "واحد": item['واحد'],
            "مقدار": item['مقدار'],
            "بهای واحد": item['بهای واحد'],
            "quantity_controller": quantityController,
            "unit_price_controller": unitPriceController,
          });
        }
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${importedData.length} ردیف با موفقیت ایمپورت شد')),
      );
    }
  }

  void _exportToExcel() async {
    if (rows.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('داده‌ای برای اکسپورت وجود ندارد')),
      );
      return;
    }
    
    await FileService.exportToExcel(rows);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('فایل اکسل با موفقیت ذخیره شد')),
    );
  }

  void _saveAsPdf() async {
    if (rows.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('داده‌ای برای تولید گزارش وجود ندارد')),
      );
      return;
    }
    
    await PdfService.generatePdfReport(rows, 'گزارش برآورد متره');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('گزارش PDF با موفقیت ذخیره شد')),
    );
  }

  void _showAdvancedSettings() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تنظیمات پیشرفته محاسبات'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'درصد اتلاف (%)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    // ذخیره درصد اتلاف
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'درصد مالیات (%)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    // ذخیره درصد مالیات
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'درصد سود (%)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    // ذخیره درصد سود
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('انصراف'),
            ),
            TextButton(
              onPressed: () {
                // اعمال تنظیمات
                Navigator.pop(context);
              },
              child: const Text('اعمال'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("جدول متره قابل ویرایش"),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            tooltip: "ایمپورت از اکسل",
            onPressed: _importFromExcel,
          ),
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: "اکسپورت به اکسل",
            onPressed: _exportToExcel,
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: "ذخیره به PDF",
            onPressed: _saveAsPdf,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "افزودن ردیف جدید",
            onPressed: addRow,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: DataTable2(
          border: TableBorder.all(color: Colors.grey),
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 900,
          headingRowColor: WidgetStateProperty.all(Colors.blueGrey[50]),
          columns: const [
            DataColumn(label: Text('ردیف', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('کد فهرست', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('شرح آیتم', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('واحد', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('مقدار', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('بهای واحد', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('بهای کل', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('عملیات', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: [
            ...List<DataRow>.generate(
              rows.length,
              (index) => DataRow(
                cells: [
                  DataCell(
                    Text(
                      rows[index]["ردیف"].toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    TextFormField(
                      initialValue: rows[index]["کد فهرست"],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      onChanged: (val) {
                        setState(() => rows[index]["کد فهرست"] = val);
                      },
                    ),
                  ),
                  DataCell(
                    TextFormField(
                      initialValue: rows[index]["شرح آیتم"],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      onChanged: (val) {
                        setState(() => rows[index]["شرح آیتم"] = val);
                      },
                    ),
                  ),
                  DataCell(
                    TextFormField(
                      initialValue: rows[index]["واحد"],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      onChanged: (val) {
                        setState(() => rows[index]["واحد"] = val);
                      },
                    ),
                  ),
                  DataCell(
                    TextFormField(
                      controller: rows[index]["quantity_controller"],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      onChanged: (val) {
                        setState(() {
                          rows[index]["مقدار"] = int.tryParse(val) ?? 0;
                        });
                      },
                    ),
                  ),
                  DataCell(
                    TextFormField(
                      controller: rows[index]["unit_price_controller"],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                      onChanged: (val) {
                        setState(() {
                          rows[index]["بهای واحد"] = int.tryParse(val) ?? 0;
                        });
                      },
                    ),
                  ),
                  DataCell(
                    Text(
                      calcTotal(rows[index]["مقدار"], rows[index]["بهای واحد"]).toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      tooltip: "حذف ردیف",
                      onPressed: () => deleteRow(index),
                    ),
                  ),
                ],
              ),
            ),
            // ردیف جمع کل
            DataRow(
              color: WidgetStateProperty.all(Colors.grey.shade300),
              cells: [
                const DataCell(Text("")),
                const DataCell(Text("")),
                const DataCell(Text("")),
                DataCell(Text(
                  "جمع کل",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue[800],
                  ),
                )),
                const DataCell(Text("")),
                const DataCell(Text("")),
                DataCell(Text(
                  grandTotal.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue[800],
                  ),
                )),
                const DataCell(Text("")),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addRow,
        icon: const Icon(Icons.add),
        label: const Text("افزودن ردیف جدید"),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
