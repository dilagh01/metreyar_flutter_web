import 'package:flutter/material.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  // داده نمونه (می‌تونه از API یا دیتابیس بیاد)
  final List<Map<String, dynamic>> _analysisData = [
    {"title": "پروژه الف", "progress": 80, "status": "موفق"},
    {"title": "پروژه ب", "progress": 45, "status": "در حال انجام"},
    {"title": "پروژه ج", "progress": 20, "status": "ریسکی"},
  ];

  String _filter = "همه";

  @override
  Widget build(BuildContext context) {
    final filteredData = _filter == "همه"
        ? _analysisData
        : _analysisData.where((d) => d["status"] == _filter).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("تحلیل و آنالیز"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _filter = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "همه", child: Text("همه")),
              const PopupMenuItem(value: "موفق", child: Text("موفق")),
              const PopupMenuItem(value: "در حال انجام", child: Text("در حال انجام")),
              const PopupMenuItem(value: "ریسکی", child: Text("ریسکی")),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          final item = filteredData[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(item["title"]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("وضعیت: ${item["status"]}"),
                  const SizedBox(height: 5),
                  LinearProgressIndicator(
                    value: item["progress"] / 100,
                    backgroundColor: Colors.grey[300],
                    color: item["progress"] > 70
                        ? Colors.green
                        : (item["progress"] > 40 ? Colors.orange : Colors.red),
                  ),
                ],
              ),
              trailing: Text("${item["progress"]}%"),
            ),
          );
        },
      ),
    );
  }
}
