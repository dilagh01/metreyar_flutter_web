import 'package:flutter/material.dart';

class ContractsScreen extends StatelessWidget {
  const ContractsScreen({super.key});

  // نمونه داده قراردادها
  final List<Map<String, String>> contracts = const [
    {"title": "قرارداد خرید", "date": "1403/05/01"},
    {"title": "قرارداد اجاره", "date": "1403/06/10"},
    {"title": "قرارداد خدمات", "date": "1403/07/15"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("قراردادها")),
      body: ListView.builder(
        itemCount: contracts.length,
        itemBuilder: (context, index) {
          final contract = contracts[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(contract["title"]!),
              subtitle: Text("تاریخ: ${contract["date"]}"),
              leading: const Icon(Icons.description),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // اینجا می‌تونی برای نمایش جزئیات قرارداد کدی اضافه کنی
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${contract["title"]} انتخاب شد")),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
