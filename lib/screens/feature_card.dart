import 'package:flutter/material.dart';

class FeatureCardScreen extends StatelessWidget { // مطمئن شوید همین نام باشد
  const FeatureCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final title = "عنوان ویژگی";
    final description = "توضیحات ویژگی";

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(description, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
