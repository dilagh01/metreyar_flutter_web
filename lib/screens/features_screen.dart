import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import '../widgets/feature_card.dart';

class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({super.key});

  final List<Map<String, String>> features = const [
    {
      'title': 'کاربری ساده و آسان',
      'description': 'User Friendly و نصب سریع روی Windows بدون سخت افزار خاص.'
    },
    {
      'title': 'فهرست بها',
      'description': 'فهرستهای سال 1370 تا 1388 و به روز رسانی فهرستهای آینده.'
    },
    {
      'title': 'ضرایب و آنالیز بها',
      'description': 'اعمال ضریب روی ردیف، فصل، رشته و پروژه به طور دلخواه.'
    },
    // بقیه ویژگی‌ها را همینجا اضافه کنید
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            for (var feature in features)
              FeatureCard(
                title: feature['title']!,
                description: feature['description']!,
              ),
            const SizedBox(height: 50),
            const Footer(),
          ],
        ),
      ),
    );
  }
}


