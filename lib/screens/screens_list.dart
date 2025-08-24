import 'package:flutter/material.dart';
import 'screens.dart'; // اینجا appPages و AppPage تعریف شده

class ScreensGrid extends StatelessWidget {
  const ScreensGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('داشبورد صفحات')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // تعداد ستون‌ها
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2, // نسبت طول به عرض کارت‌ها
          ),
          itemCount: appPages.length,
          itemBuilder: (context, index) {
            final page = appPages[index];
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
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(page.icon, size: 48, color: Theme.of(context).primaryColor),
                    const SizedBox(height: 12),
                    Text(
                      page.title,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
