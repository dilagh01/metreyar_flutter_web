import 'package:flutter/material.dart';
import 'nav_bar.dart';
import 'footer.dart';
import 'feature_card.dart';
import 'screens.dart'; // برای روت‌ها

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
    {
      'title': 'گزارش‌گیری پیشرفته',
      'description': 'گزارش‌ها به تفکیک ردیف، فصل و پروژه با قابلیت ارسال به Excel و Word.'
    },
    {
      'title': 'کنترل کارگاه و پروژه',
      'description': 'مدیریت نیروی انسانی، مصالح، ماشین‌آلات و برنامه پیشرفت پروژه.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(), // نوار بالای سایت
      body: SingleChildScrollView(
        child: Column(
          children: [
            // بخش هدر با تصویر و شعار
            Container(
              width: double.infinity,
              height: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/header_bg.jpg'), // تصویر هدر
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                alignment: Alignment.center,
                child: const Text(
                  'نرم افزار مدیریت پروژه و برآورد تدکار',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // بخش ویژگی‌ها
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ویژگی‌های نرم افزار تدکار',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: features
                        .map((feature) => SizedBox(
                              width: 300,
                              child: FeatureCard(
                                title: feature['title']!,
                                description: feature['description']!,
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            // دعوت به مشاهده جزئیات
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  // رفتن به صفحه ویژگی‌ها
                  Navigator.of(context).pushNamed('/features');
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Text(
                    'مشاهده جزئیات تمام ویژگی‌ها',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50),

            const Footer(), // فوتر سایت
          ],
        ),
      ),
    );
  }
}
