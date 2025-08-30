// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/feature_card.dart';
import '../widgets/sidebar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('متره یار - صفحه اصلی'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          children: [
            FeatureCard(
              title: 'برآورد متره',
              icon: Icons.calculate,
              color: Colors.blue,
              onTap: () => context.go('/estimation'),
            ),
            FeatureCard(
              title: 'آنالیز پروژه',
              icon: Icons.analytics,
              color: Colors.green,
              onTap: () => context.go('/analysis'),
            ),
            FeatureCard(
              title: 'گزارشات',
              icon: Icons.bar_chart,
              color: Colors.orange,
              onTap: () {},
            ),
            FeatureCard(
              title: 'تنظیمات',
              icon: Icons.settings,
              color: Colors.purple,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
