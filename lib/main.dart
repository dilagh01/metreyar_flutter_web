import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Metreyar Flutter Web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExcelUploader(),
    );
  }
}

class ExcelUploader extends StatefulWidget {
  @override
  _ExcelUploaderState createState() => _ExcelUploaderState();
}

class _ExcelUploaderState extends State<ExcelUploader> {
  List<Map<String, dynamic>> excelData = [];
  bool loading = false;
  String? backendResponse;

  Future<void> pickAndReadExcel() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      Uint8List bytes = result.files.first.bytes!;
      final excel = Excel.decodeBytes(bytes);

      List<Map<String, dynamic>> rows = [];

      final sheet = excel.tables.keys.first;
      for (var row in excel.tables[sheet]!.rows) {
        rows.add({
          "col1": row[0]?.value?.toString() ?? "",
          "col2": row[1]?.value?.toString() ?? "",
          "col3": row[2]?.value?.toString() ?? "",
        });
      }

      setState(() {
        excelData = rows;
        backendResponse = null;
      });
    }
  }

  Future<void> sendToBackend() async {
    if (excelData.isEmpty) {
      setState(() {
        backendResponse = "❌ هیچ داده‌ای برای ارسال وجود ندارد.";
      });
      return;
    }

    setState(() => loading = true);

 �   final url = Uri.parse("https://metreyar-api.onrender.com");
    final cleanedData = excelData.map((row) => {
      "col1": row["col1"]?.toString() ?? "",
      "col2": row["col2"]?.toString() ?? "",
      "col3": row["col3"]?.toString() ?? "",
    }).toList();

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"data": cleanedData}),
      );

      setState(() {
        loading = false;
        backendResponse = response.statusCode == 200
            ? response.body
            : "❌ خطا در ارسال: ${response.statusCode}";
      });
    } catch (e) {
      setState(() {
        loading = false;
        backendResponse = "❌ خطا: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📊 آپلود اکسل")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: pickAndReadExcel,
              icon: const Icon(Icons.upload_file),
              label: const Text("📂 انتخاب فایل اکسل"),
            ),
            const SizedBox(height: 20),

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
                : const Text("هیچ داده‌ای بارگذاری نشده"),

            const SizedBox(height: 20),

            if (excelData.isNotEmpty)
              ElevatedButton.icon(
                onPressed: loading ? null : sendToBackend,
                icon: const Icon(Icons.send),
                label: loading
                    ? const Text("⏳ در حال ارسال...")
                    : const Text("📤 ارسال به بک‌اند"),
              ),

            const SizedBox(height: 20),

            if (backendResponse != null)
              Text("✅ پاسخ بک‌اند: $backendResponse"),
          ],
        ),
      ),
    );
  }
}
