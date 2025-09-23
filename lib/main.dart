import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ExcelUploader extends StatefulWidget {
  @override
  _ExcelUploaderState createState() => _ExcelUploaderState();
}

class _ExcelUploaderState extends State<ExcelUploader> {
  List<Map<String, dynamic>> excelData = [];

  Future<void> pickAndReadExcel() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      Uint8List bytes = result.files.first.bytes!;
      final excel = Excel.decodeBytes(bytes);

      List<Map<String, dynamic>> rows = [];

      // فرض: فقط شیت اول
      final sheet = excel.tables.keys.first;
      for (var row in excel.tables[sheet]!.rows) {
        rows.add({
          "col1": row[0]?.value,
          "col2": row[1]?.value,
          "col3": row[2]?.value,
        });
      }

      setState(() {
        excelData = rows;
      });

      print("📂 Excel data: $excelData");

      // ارسال به بک‌اند
      await sendToBackend(rows);
    }
  }

  Future<void> sendToBackend(List<Map<String, dynamic>> data) async {
    final url = Uri.parse("http://localhost:8000/upload_excel"); // آدرس API
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"data": data}),
    );

    if (response.statusCode == 200) {
      print("✅ پاسخ بک‌اند: ${response.body}");
    } else {
      print("❌ خطا در ارسال: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("📊 آپلود اکسل")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: pickAndReadExcel,
              child: Text("📂 انتخاب فایل اکسل"),
            ),
            SizedBox(height: 20),
            excelData.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: excelData.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(excelData[index].toString()),
                        );
                      },
                    ),
                  )
                : Text("هیچ داده‌ای بارگذاری نشده"),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Metreyar Excel Uploader',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ExcelUploader(),
    );
  }
}
