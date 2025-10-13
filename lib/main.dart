import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

Future<void> uploadExcelToServer() async {
  try {
    // انتخاب فایل - در وب و موبایل کار می‌کند
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      
      print('📁 فایل انتخاب شده: ${file.name}');
      
      // برای محیط وب
      if (file.bytes != null) {
        var url = Uri.parse('https://metreyar-api.onrender.com/api/v1/upload-excel/');
        var request = http.MultipartRequest('POST', url);
        
        request.files.add(http.MultipartFile.fromBytes(
          'file',
          file.bytes!,
          filename: file.name,
        ));

        var response = await request.send();
        String responseBody = await response.stream.bytesToString();
        
        if (response.statusCode == 200) {
          print('✅ فایل با موفقیت آپلود شد');
          print('📊 پاسخ سرور: $responseBody');
        } else {
          print('❌ خطا در آپلود: ${response.statusCode}');
          print('📄 پاسخ: $responseBody');
        }
      }
    }
  } catch (error) {
    print('❌ خطای سیستمی: $error');
  }
}
