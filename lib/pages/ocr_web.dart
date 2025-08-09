import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OCRPage extends StatefulWidget {
  @override
  _OCRPageState createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {
  String extractedText = '';

  Future<void> _pickImageAndSendToServer() async {
    final input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((event) {
      final files = input.files;
      if (files == null || files.isEmpty) return;
      final file = files[0];
      final reader = html.FileReader();

      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) async {
        final base64Image = reader.result as String;

        final url = Uri.parse('https://dilagh01.onrender.com/ocr/base64');

        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "image": base64Image.split(',').last, // فقط رشته Base64
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            extractedText = data["text"] ?? "متنی یافت نشد";
          });
        } else {
          setState(() {
            extractedText = 'خطا در دریافت متن از سرور';
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OCR Web')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickImageAndSendToServer,
              child: Text('انتخاب تصویر و استخراج متن'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(extractedText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
