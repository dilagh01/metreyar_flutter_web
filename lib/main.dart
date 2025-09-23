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

      // فقط شیت اول
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
    }
  }

  Future<void> sendToBackend() async {
    final url = Uri.parse("http://localhost:8000/upload_excel"); // آدرس API
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"data": excelData}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ داده‌ها با موفقیت ارسال شدند")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ خطا در ارسال: ${response.statusCode}")),
      );
    }
  }

  void resetData() {
    setState(() {
      excelData = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("📊 آپلود اکسل")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickAndReadExcel,
              child: Text("📂 انتخاب فایل اکسل"),
            ),
            SizedBox(height: 20),

            // نمایش داده‌ها
            excelData.isNotEmpty
                ? Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: excelData.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(excelData[index].toString()),
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              onPressed: sendToBackend,
                              icon: Icon(Icons.cloud_upload),
                              label: Text("ارسال به بک‌اند"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: resetData,
                              icon: Icon(Icons.refresh),
                              label: Text("بازگشت/پاک کردن"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : Text("هیچ داده‌ای بارگذاری نشده"),
          ],
        ),
      ),
    );
  }
}
