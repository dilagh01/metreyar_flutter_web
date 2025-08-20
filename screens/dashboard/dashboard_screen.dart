import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {"title": "متره و برآورد", "route": "/metering"},
      {"title": "تحلیل و تعدیل", "route": "/analysis"},
      {"title": "قراردادها", "route": "/contracts"},
      {"title": "پروژه‌ها", "route": "/projects"},
      {"title": "گردش کار", "route": "/workflow"},
      {"title": "تنظیمات", "route": "/settings"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("داشبورد تدکار")),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // دو کارت در هر ردیف
          childAspectRatio: 1.2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () => context.go(item["route"]!),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  item["title"]!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
