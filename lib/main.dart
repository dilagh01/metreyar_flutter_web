import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html' as html;

class GenericTablePage extends StatefulWidget {
  @override
  _GenericTablePageState createState() => _GenericTablePageState();
}

class _GenericTablePageState extends State<GenericTablePage> {
  List<Map<String, dynamic>> rows = [];
  List<String> columns = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final response = await http.get(Uri.parse("http://127.0.0.1:8000/data/"));
    if (response.statusCode == 200) {
      final List<dynamic> rawData = jsonDecode(response.body);
      setState(() {
        rows = List<Map<String, dynamic>>.from(rawData);
        if (rows.isNotEmpty) columns = rows[0].keys.toList();
      });
    }
  }

  void _editCell(int rowIndex, String column, String value) {
    setState(() {
      rows[rowIndex][column] = value;
    });
  }

  Future<void> _saveData() async {
    await http.post(
      Uri.parse("http://127.0.0.1:8000/data/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(rows),
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ ذخیره شد")));
  }

  Future<void> _generateReport() async {
    final response = await http.get(Uri.parse("http://127.0.0.1:8000/generate-report/"));
    if (response.statusCode == 200) {
      final blob = html.Blob([response.bodyBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute('download', 'report.pdf')
        ..click();
      html.Url.revokeObjectUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("جدول داده‌ها")),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: rows.isEmpty
                  ? Center(child: Text("داده‌ای موجود نیست"))
                  : DataTable(
                      columns: columns.map((c) => DataColumn(label: Text(c))).toList(),
                      rows: List.generate(rows.length, (i) {
                        return DataRow(
                          cells: columns.map((col) {
                            return DataCell(
                              TextFormField(
                                initialValue: rows[i][col].toString(),
                                onFieldSubmitted: (val) => _editCell(i, col, val),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _saveData, child: Text("💾 ذخیره تغییرات")),
              SizedBox(width: 20),
              ElevatedButton(onPressed: _generateReport, child: Text("📥 تولید گزارش")),
            ],
          ),
        ],
      ),
    );
  }
}
