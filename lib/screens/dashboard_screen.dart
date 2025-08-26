import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("داشبورد")),
      drawer: SideBar(
        onItemTap: (route) {
          Navigator.pushNamed(context, route);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: const [
            _DashboardCard(
              title: "قراردادها",
              value: "۱۲",
              color: Colors.blue,
            ),
            _DashboardCard(
              title: "پروژه‌ها",
              value: "۸",
              color: Colors.green,
            ),
            _DashboardCard(
              title: "گزارش‌ها",
              value: "۵",
              color: Colors.orange,
            ),
            _DashboardCard(
              title: "کاربران",
              value: "۳",
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final MaterialColor color; // حالا MaterialColor استفاده می‌کنیم

  const _DashboardCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color.shade100, // رنگ پس‌زمینه روشن‌تر
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color.shade700, // رنگ اصلی
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: color.shade900, // رنگ متن تیره‌تر
              ),
            ),
          ],
        ),
      ),
    );
  }
}
