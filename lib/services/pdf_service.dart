// services/pdf_service.dart
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class PdfService {
  // تولید گزارش PDF
  static Future<void> generatePdfReport(List<Map<String, dynamic>> data, String title) async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              children: [
                pw.Header(
                  level: 0,
                  child: pw.Text(title, style: pw.TextStyle(fontSize: 24)),
                ),
                pw.SizedBox(height: 20),
                _buildTable(data),
                pw.SizedBox(height: 30),
                _buildSummary(data),
              ],
            );
          },
        ),
      );

      // ذخیره و باز کردن فایل
      Directory directory = await getApplicationDocumentsDirectory();
      String path = '${directory.path}/$title.pdf';
      File(path)
        ..createSync(recursive: true)
        ..writeAsBytesSync(await pdf.save());

      await OpenFile.open(path);
    } catch (e) {
      print('خطا در تولید PDF: $e');
    }
  }

  // ساخت جدول در PDF
  static pw.Widget _buildTable(List<Map<String, dynamic>> data) {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          children: [
            pw.Padding(child: pw.Text('ردیف', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)), padding: const pw.EdgeInsets.all(4)),
            pw.Padding(child: pw.Text('کد فهرست', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)), padding: const pw.EdgeInsets.all(4)),
            pw.Padding(child: pw.Text('شرح آیتم', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)), padding: const pw.EdgeInsets.all(4)),
            pw.Padding(child: pw.Text('واحد', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)), padding: const pw.EdgeInsets.all(4)),
            pw.Padding(child: pw.Text('مقدار', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)), padding: const pw.EdgeInsets.all(4)),
            pw.Padding(child: pw.Text('بهای واحد', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)), padding: const pw.EdgeInsets.all(4)),
            pw.Padding(child: pw.Text('بهای کل', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)), padding: const pw.EdgeInsets.all(4)),
          ],
        ),
        for (var row in data)
          pw.TableRow(
            children: [
              pw.Padding(child: pw.Text(row['ردیف'].toString()), padding: const pw.EdgeInsets.all(4)),
              pw.Padding(child: pw.Text(row['کد فهرست'].toString()), padding: const pw.EdgeInsets.all(4)),
              pw.Padding(child: pw.Text(row['شرح آیتم'].toString()), padding: const pw.EdgeInsets.all(4)),
              pw.Padding(child: pw.Text(row['واحد'].toString()), padding: const pw.EdgeInsets.all(4)),
              pw.Padding(child: pw.Text(row['مقدار'].toString()), padding: const pw.EdgeInsets.all(4)),
              pw.Padding(child: pw.Text(row['بهای واحد'].toString()), padding: const pw.EdgeInsets.all(4)),
              pw.Padding(child: pw.Text((row['مقدار'] * row['بهای واحد']).toString()), padding: const pw.EdgeInsets.all(4)),
            ],
          ),
      ],
    );
  }

  // ساخت خلاصه در PDF
  static pw.Widget _buildSummary(List<Map<String, dynamic>> data) {
    double total = 0;
    for (var row in data) {
      total += row['مقدار'] * row['بهای واحد'];
    }

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Text('جمع کل: ${total.toStringAsFixed(2)}', 
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
      ],
    );
  }
}
