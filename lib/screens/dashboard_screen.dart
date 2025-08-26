import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("داشبورد"),
        centerTitle: true,
      ),
      drawer: SideBar(
        onItemTap: (route) {
          Navigator.pushNamed(context, route);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "نمای کلی داشبورد",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // کارت‌های خلاصه وضعیت
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
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
                  title: "متره‌ها",
                  value: "۵۴",
                  color: Colors.orange,
                ),
                _DashboardCard(
                  title: "تحلیل‌ها",
                  value: "۳",
                  color: Colors.red,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // بخش نمودار یا گزارش
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[100],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  "اینجا نمودارها و گزارش‌های داشبورد قرار می‌گیرند.",
                  style: TextStyle(fontSize: 16),
                ),
              ),
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
  final Color color;

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
          color: color.withOpacity(0.1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16, color: color[800]),
            ),
          ],
        ),
      ),
    );
  }
}
