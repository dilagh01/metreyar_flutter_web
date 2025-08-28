// services/file_service.dart
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  // ایمپورت از اکسل
  static Future<List<Map<String, dynamic>>> importFromExcel() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        var bytes = file.readAsBytesSync();
        var excel = Excel.decodeBytes(bytes);

        List<Map<String, dynamic>> data = [];

        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]!.rows) {
            if (row[0]?.value != null && row[0]?.value.toString().isNotEmpty == true) {
              data.add({
                'ردیف': row[0]?.value.toString() ?? '',
                'کد فهرست': row[1]?.value.toString() ?? '',
                'شرح آیتم': row[2]?.value.toString() ?? '',
                'واحد': row[3]?.value.toString() ?? '',
                'مقدار': double.tryParse(row[4]?.value.toString() ?? '0') ?? 0,
                'بهای واحد': double.tryParse(row[5]?.value.toString() ?? '0') ?? 0,
              });
            }
          }
        }

        return data;
      }
    } catch (e) {
      print('خطا در ایمپورت فایل: $e');
    }
    return [];
  }

  // اکسپورت به اکسل
  static Future<void> exportToExcel(List<Map<String, dynamic>> data) async {
    try {
      var excel = Excel.createExcel();
      var sheet = excel['برآورد متره'];

      // هدرها
      sheet.appendRow(['ردیف', 'کد فهرست', 'شرح آیتم', 'واحد', 'مقدار', 'بهای واحد', 'بهای کل']);

      // داده‌ها
      for (var row in data) {
        sheet.appendRow([
          row['ردیف'],
          row['کد فهرست'],
          row['شرح آیتم'],
          row['واحد'],
          row['مقدار'],
          row['بهای واحد'],
          (row['مقدار'] * row['بهای واحد']),
        ]);
      }

      // ذخیره فایل
      Directory directory = await getApplicationDocumentsDirectory();
      String path = '${directory.path}/برآورد_متره.xlsx';
      File(path)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);

      // باز کردن فایل
      await OpenFile.open(path);
    } catch (e) {
      print('خطا در اکسپورت فایل: $e');
    }
  }
}
