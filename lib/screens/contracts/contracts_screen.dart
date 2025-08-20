import 'package:flutter/material.dart';

class ContractsScreen extends StatelessWidget {
  const ContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("قراردادها")),
      body: const Center(
        child: Text("لیست قراردادها اینجا میاد"),
      ),
    );
  }
}
