import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';

class ContractsScreen extends StatelessWidget {
  final List<Map<String, String>> contracts = [
    {
      "title": "قرارداد ساخت ساختمان A",
      "date": "1404/06/01",
      "status": "در حال انجام",
    },
    {
      "title": "قرارداد راه‌سازی",
      "date": "1404/05/20",
      "status": "تکمیل‌شده",
    },
    {
      "title": "قرارداد برق‌کشی پروژه X",
      "date": "1404/04/15",
      "status": "لغو‌شده",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("قراردادها")),
      drawer: SideBar(
        onItemTap: (route) {
          Navigator.pushNamed(context, route);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "لیست قراردادها",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: contracts.length,
                itemBuilder: (context, index) {
                  final contract = contracts[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.description, color: Colors.blue),
                      title: Text(contract["title"]!),
                      subtitle: Text("تاریخ: ${contract["date"]}"),
                      trailing: _statusChip(contract["status"]!),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusChip(String status) {
    Color color;
    switch (status) {
      case "در حال انجام":
        color = Colors.orange;
        break;
      case "تکمیل‌شده":
        color = Colors.green;
        break;
      case "لغو‌شده":
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Chip(
      label: Text(status, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
    );
  }
}
