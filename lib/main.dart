import 'dart:html' as html;
import 'package:http/http.dart' as http;

Future<void> uploadExcel() async {
  html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
  uploadInput.click();

  uploadInput.onChange.listen((e) {
    final files = uploadInput.files;
    if (files!.length == 1) {
      final html.File file = files[0];
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((e) async {
        var url = Uri.parse('https://metreyar-api.onrenderer.com/api/v1/upload-excel/');
        var request = http.MultipartRequest('POST', url);
        request.files.add(http.MultipartFile.fromBytes('file', reader.result as List<int>, filename: file.name));
        var response = await request.send();
        if (response.statusCode == 200) {
          print('موفق: ${await response.stream.bytesToString()}');
        } else {
          print('شکست: ${response.statusCode}');
        }
      });
    }
  });
}
