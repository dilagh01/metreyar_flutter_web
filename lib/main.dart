import 'package:file_picker_web/file_picker_web.dart';
import 'package:http/http.dart' as http;

Future<void> uploadExcelToServer() async {
  try {
    // انتخاب فایل توسط کاربر
    FilePickerResult? result = await FilePickerWeb.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      
      print('📁 فایل انتخاب شده: ${file.name}');
      
      // ایجاد درخواست آپلود به سرور
      var url = Uri.parse('https://metreyar-api.onrender.com/api/v1/upload-excel/');
      var request = http.MultipartRequest('POST', url);
      
      // اضافه کردن فایل به درخواست
      request.files.add(http.MultipartFile.fromBytes(
        'file', // ✅ همین نام دقیقاً
        file.bytes!,
        filename: file.name,
      ));

      // ارسال درخواست
      var response = await request.send();
      
      // دریافت پاسخ
      String responseBody = await response.stream.bytesToString();
      
      if (response.statusCode == 200) {
        print('✅ فایل با موفقیت آپلود شد');
        print('📊 پاسخ سرور: $responseBody');
        
        // اینجا می‌تونید پاسخ رو به کاربر نمایش بدید
        // showSuccessDialog(responseBody);
      } else {
        print('❌ خطا در آپلود: کد ${response.statusCode}');
        print('📄 پاسخ: $responseBody');
      }
    } else {
      print('⚠️ کاربر هیچ فایلی انتخاب نکرد');
    }
  } catch (error) {
    print('❌ خطای سیستمی: $error');
  }
}
