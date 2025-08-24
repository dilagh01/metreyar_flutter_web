
import 'package:flutter/material.dart';

class PageItem {
  final String title;
  final String subtitle;
  PageItem({required this.title, required this.subtitle});
}

class DynamicListPage extends StatelessWidget {
  final String pageTitle;
  final List<PageItem> items;

  const DynamicListPage({super.key, required this.pageTitle, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pageTitle)),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(item.title),
              subtitle: Text(item.subtitle),
              leading: const Icon(Icons.description),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${item.title} انتخاب شد")),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// نمونه داده و صفحه Dashboard
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final items = [
      PageItem(title: "آمار فروش", subtitle: "آمار ماهانه و سالانه"),
      PageItem(title: "عملکرد تیم", subtitle: "گزارش عملکرد تیم"),
    ];
    return DynamicListPage(pageTitle: "داشبورد", items: items);
  }
}





