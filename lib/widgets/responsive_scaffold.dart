import 'package:flutter/material.dart';
import 'sidebar.dart';
import 'header.dart';

class ResponsiveScaffold extends StatelessWidget {
  final Widget body;
  const ResponsiveScaffold({required this.body, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 800) {
      return Scaffold(
        body: Row(
          children: [
            Sidebar(),
            Expanded(
              child: Column(
                children: [
                  Header(),
                  Expanded(child: body),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: Text("TADKAR")),
        drawer: Sidebar(),
        body: body,
      );
    }
  }
}
