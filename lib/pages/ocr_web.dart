import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OCRHighlightPage extends StatefulWidget {
  @override
  _OCRHighlightPageState createState() => _OCRHighlightPageState();
}

class _OCRHighlightPageState extends State<OCRHighlightPage> {
  String? base64Image;
  List<dynamic> highlights = [];
  double imageWidth = 0;
  double imageHeight = 0;

  Future<void> _pickImageAndSendToServer() async {
    final input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((event) async {
      final files = input.files;
      if (files == null || files.isEmpty) return;
      final file = files[0];
      final reader = html.FileReader();

      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) async {
        base64Image = reader.result as String;

        // ارسال تصویر به سرور
        final url = Uri.parse('https://metreyar.onrender.com/ocr/base64');
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "image": base64Image!.split(',').last,
          }),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            highlights = data['results'] ?? [];
          });
        } else {
          setState(() {
            highlights = [];
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageWidget = base64Image == null
        ? Center(child: Text('تصویر انتخاب نشده'))
        : Image.network(base64Image!);

    return Scaffold(
      appBar: AppBar(title: Text('OCR هایلایت')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickImageAndSendToServer,
            child: Text('انتخاب تصویر و استخراج متن'),
          ),
          Expanded(
            child: base64Image == null
                ? Center(child: Text('هیچ تصویری وجود ندارد'))
                : LayoutBuilder(
                    builder: (context, constraints) {
                      return FutureBuilder<Size>(
                        future: _getImageSize(base64Image!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState != ConnectionState.done) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final size = snapshot.data!;
                          final scaleX = constraints.maxWidth / size.width;
                          final scaleY = constraints.maxHeight / size.height;
                          final scale = scaleX < scaleY ? scaleX : scaleY;

                          return Stack(
                            children: [
                              Positioned.fill(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Image.network(base64Image!),
                                ),
                              ),
                              ...highlights.map((h) {
                                return Positioned(
                                  left: h['left'] * scale,
                                  top: h['top'] * scale,
                                  width: h['width'] * scale,
                                  height: h['height'] * scale,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.yellow.withOpacity(0.4),
                                      border: Border.all(color: Colors.orange, width: 1),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ],
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<Size> _getImageSize(String base64Image) async {
    final completer = Completer<Size>();
    final image = html.ImageElement(src: base64Image);
    image.onLoad.listen((event) {
      completer.complete(Size(image.width!.toDouble(), image.height!.toDouble()));
    });
    return completer.future;
  }
}
