import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metreyar Web',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Future<void> _uploadExcel() async {
    try {
      // تست ساده سلامت سرور
      var response = await http.get(
        Uri.parse('https://metreyar-api.onrender.com/api/v1/health')
      );
      
      print('✅ سلامت سرور: ${response.statusCode}');
      print('📄 پاسخ: ${response.body}');
      
      // نمایش دیالوگ
      // _showDialog(context, 'سرور فعال', 'پاسخ: ${response.body}');
      
    } catch (error) {
      print('❌ خطا: $error');
      // _showDialog(context, 'خطا', 'خطا: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Metreyar - آپلود اکسل'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'سامانه آپلود فایل اکسل',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              icon: Icon(Icons.upload_file),
              label: Text('تست اتصال به سرور'),
              onPressed: _uploadExcel,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'نسخه تست - بدون آپلود فایل',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
// بعد از اینکه build ساده کار کرد، این را اضافه کنید
void _uploadExcelWeb() {
  import('dart:html').then((html) {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = '.xlsx,.xls';
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files != null && files.length == 1) {
        final file = files[0];
        final reader = html.FileReader();
        
        reader.readAsArrayBuffer(file);
        reader.onLoadEnd.listen((e) async {
          var url = Uri.parse('https://metreyar-api.onrender.com/api/v1/upload-excel/');
          var request = http.MultipartRequest('POST', url);
          
          request.files.add(http.MultipartFile.fromBytes(
            'file',
            reader.result as List<int>,
            filename: file.name,
          ));

          var response = await request.send();
          print('📤 آپلود کامل: ${response.statusCode}');
        });
      }
    });
  });
}
