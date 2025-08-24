import 'package:flutter/material.dart';
import 'screens.dart';

class ScreensList extends StatelessWidget {
  const ScreensList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لیست صفحات')),
      body: ListView.builder(
        itemCount: appPages.length,
        itemBuilder: (context, index) {
          final page = appPages[index];
          return ListTile(
            leading: Icon(page.icon),
            title: Text(page.title),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => page.page),
              );
            },
          );
        },
      ),
    );
  }
}

