import 'package:http/http.dart' as http;
import 'dart:html'; // برای محیط وب

Future<void> uploadExcelWeb() async {
  try {
    // ایجاد input element برای انتخاب فایل
    final input = FileUploadInputElement();
    input.accept = '.xlsx,.xls';
    input.click();

    input.onChange.listen((e) {
      final files = input.files;
      if (files!.length == 0) return;

      final file = files[0];
      final reader = FileReader();

      reader.onLoadEnd.listen((e) async {
        // ایجاد درخواست آپلود
        var url = 'https://metreyar-api.onrender.com/api/v1/upload-excel/';
        var request = http.MultipartRequest('POST', Uri.parse(url));
        
        // اضافه کردن فایل
        var blob = file.slice(0, file.size, file.type);
        var multipartFile = http.MultipartFile.fromBytes(
          'file',
          (reader.result as Uint8List),
          filename: file.name,
        );
        
        request.files.add(multipartFile);

        // ارسال درخواست
        var response = await request.send();
        
        if (response.statusCode == 200) {
          print('✅ فایل با موفقیت آپلود شد');
          var responseData = await response.stream.bytesToString();
          print('پاسخ: $responseData');
        } else {
          print('❌ خطا در آپلود: ${response.statusCode}');
        }
      });

      reader.readAsArrayBuffer(file);
    });
  } catch (e) {
    print('❌ خطا: $e');
  }
}
