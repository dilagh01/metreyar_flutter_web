import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataScreen(),
    );
  }
}

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  List<Map<String, dynamic>> rows = [
    {"x": 1, "y": 2},
    {"x": 3, "y": 4},
  ];
  Map<String, dynamic>? summary;

  Future<void> sendData() async {
    final url = Uri.parse("http://127.0.0.1:8000/analyze"); // 👈 آدرس API
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"rows": rows}),
    );

    if (response.statusCode == 200) {
      setState(() {
        summary = jsonDecode(response.body)["summary"];
      });
    } else {
      print("Error: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pandas Analyzer")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: sendData,
              child: Text("ارسال داده به بک‌اند"),
            ),
            SizedBox(height: 20),
            if (summary != null) Expanded(child: Text("خلاصه: $summary")),
          ],
        ),
      ),
    );
  }
}
