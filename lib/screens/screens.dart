import 'package:flutter/material.dart';
import 'package:metreyar_flutter_web/screens/features_screen.dart';
import 'package:metreyar_flutter_web/screens/price_list_screen.dart';
// سایر صفحه‌ها را همینجا import کنید

class AppPage {
  final String title;
  final IconData icon;
  final Widget page;

  AppPage({required this.title, required this.icon, required this.page});
}

class ScreensGrid extends StatelessWidget {
  ScreensGrid({super.key});

  final List<AppPage> pages = [
   # AppPage(title: "صفحه لیست قیمت", icon: Icons.list, page: PriceListPage()),
    #AppPage(title: "ویژگی‌ها", icon: Icons.star, page: FeaturesScreen()),
    // بقیه صفحات را اینجا اضافه کنید
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Metreyar Web')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // تعداد ستون‌ها
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final page = pages[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => page.page),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(page.icon, size: 50, color: Colors.blue),
                  const SizedBox(height: 12),
                  Text(page.title,
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
