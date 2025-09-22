import 'dart:convert';
import 'dart:html'; // برای فایل انتخاب کردن
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  List<Map<String, dynamic>> tableData = [];

  Future<void> uploadExcel(File file) async {
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("http://localhost:8000/upload_excel/"),
    );
    request.files.add(await http.MultipartFile.fromBytes(
      'file',
      await file.slice().arrayBuffer().then((b) => b.asUint8List()),
      filename: file.name,
    ));

    final response = await request.send();
    final res = await http.Response.fromStream(response);

    setState(() {
      tableData = List<Map<String, dynamic>>.from(jsonDecode(res.body));
    });
  }

  Future<void> sendUpdated() async {
    final response = await http.post(
      Uri.parse("http://localhost:8000/update_data/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(tableData),
    );
    final res = jsonDecode(response.body);
    print("📊 Summary: ${res['summary']}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data Editor")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              FileUploadInputElement upload = FileUploadInputElement();
              upload.accept = ".xlsx";
              upload.click();
              upload.onChange.listen((event) {
                final file = upload.files?.first;
                if (file != null) {
                  uploadExcel(file);
                }
              });
            },
            child: const Text("Upload Excel"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tableData.length,
              itemBuilder: (context, index) {
                final row = tableData[index];
                return ListTile(
                  title: Text(row.toString()),
                  onTap: () {
                    setState(() {
                      row.updateAll((k, v) => v.toString() + "✅");
                    });
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: sendUpdated,
            child: const Text("Send Updated"),
          )
        ],
      ),
    );
  }
}
