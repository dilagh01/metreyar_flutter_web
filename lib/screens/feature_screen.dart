import 'package:flutter/material.dart';

class FeatureScreen extends StatelessWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ویژگی‌ها"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text("ویژگی ۱"),
                subtitle: Text("توضیح کوتاه ویژگی ۱"),
              ),
            ),
            SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text("ویژگی ۲"),
                subtitle: Text("توضیح کوتاه ویژگی ۲"),
              ),
            ),
            SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text("ویژگی ۳"),
                subtitle: Text("توضیح کوتاه ویژگی ۳"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
