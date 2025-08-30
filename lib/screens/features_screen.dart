import 'package:flutter/material.dart';
import '../widgets/feature_card.dart';
import '../widgets/sidebar.dart';

class FeaturesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> features = [
    {
      'title': 'ویژگی 1',
      'description': 'توضیحات ویژگی 1',
      'icon': Icons.star,
    },
    {
      'title': 'ویژگی 2',
      'description': 'توضیحات ویژگی 2',
      'icon': Icons.favorite,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Features')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: features.length,
        itemBuilder: (context, index) {
          final feature = features[index];
          return FeatureCard(
            title: feature['title']!,
            description: feature['description']!,
            icon: feature['icon']!,
          );
        },
      ),
    );
  }
}
