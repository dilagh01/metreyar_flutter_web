// در فایل estimation_screen.dart
// اضافه کردن importهای لازم
import 'package:file_picker/file_picker.dart';
import 'services/file_service.dart';
import 'services/pdf_service.dart';

// اضافه کردن دکمه‌های جدید در AppBar
AppBar(
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

// اضافه کردن متدهای جدید در کلاس _EstimationScreenState
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

// در کلاس _EstimationScreenState
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
