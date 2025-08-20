import 'package:flutter/material.dart';

class MeteringScreen extends StatelessWidget {
  const MeteringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("متره و برآورد")),
      body: const Center(
        child: Text("اینجا فرم و جدول متره قرار می‌گیره"),
      ),
    );
  }
}
