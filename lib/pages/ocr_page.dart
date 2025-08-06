import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:http/http.dart' as http;

class OcrPage extends StatefulWidget {
  const OcrPage({Key? key}) : super(key: key);

  @override
  State<OcrPage> createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> {
  File? _image;
  String _extractedText = '';
  bool _isProcessing = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() {
      _image = File(pickedFile.path);
      _extractedText = '';
    });

    await _processImage(File(pickedFile.path));
  }

  Future<void> _processImage(File imageFile) async {
    setState(() {
      _isProcessing = true;
    });

    final inputImage = InputImage.fromFile(imageFile);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText = await textDetector.processImage(inputImage);

    String extracted = recognizedText.text;

    setState(() {
      _extractedText = extracted;
      _isProcessing = false;
    });

    textDetector.close();

    await _sendToBackend(extracted);
  }

  Future<void> _sendToBackend(String text) async {
    const url = 'https://dilagh01.onrender.com/api/ocr'; // آدرس واقعی API را وارد کن
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: '{"text": "${text.replaceAll('\n', '\\n')}"}',
      );

      debugPrint('Backend response: ${response.statusCode} - ${response.body}');
    } catch (e) {
      debugPrint('Error sending to backend: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OCR Page')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _isProcessing ? null : _pickImage,
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 20),
            if (_image != null) Image.file(_image!, height: 200),
            const SizedBox(height: 20),
            if (_isProcessing) const CircularProgressIndicator(),
            if (_extractedText.isNotEmpty) ...[
              const Text('Extracted Text:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Expanded(child: SingleChildScrollView(child: Text(_extractedText))),
            ],
          ],
        ),
      ),
    );
  }
}
