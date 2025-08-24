import 'package:flutter/material.dart';

class MeteringScreen extends StatelessWidget {
  const MeteringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("کنتور خوانی")),
      body: const Center(
        child: Text("اینجا صفحه کنتورخوانی میاد"),
      ),
    );
  }
}
