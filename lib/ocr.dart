import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:http/http.dart' as http;

class OCRScreen extends StatefulWidget {
  const OCRScreen({super.key});

  @override
  State<OCRScreen> createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  File? _image;
  String _text = '';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _image = File(picked.path));
      _scanText(_image!);
    }
  }

  Future<void> _scanText(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    setState(() {
      _text = recognizedText.text;
    });

    textRecognizer.close();

    // Optional: Send text to backend
    _sendToBackend(_text);
  }

  Future<void> _sendToBackend(String text) async {
    const url = 'https://dilagh01.onrender.com/api/ocr'; // تغییر بده
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: '{"text": "${text.replaceAll('"', '\\"')}"}',
    );

    if (response.statusCode == 200) {
      debugPrint('Response: ${response.body}');
    } else {
      debugPrint('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OCR Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _image != null ? Image.file(_image!, height: 200) : const Text('No image selected'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 20),
            const Text('Recognized Text:'),
            Expanded(child: SingleChildScrollView(child: Text(_text))),
          ],
        ),
      ),
    );
  }
}
