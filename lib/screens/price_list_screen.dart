import 'package:flutter/material.dart';

class PriceListScreen extends StatelessWidget {
  const PriceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("لیست قیمت")),
      body: const Center(child: Text("صفحه لیست قیمت")),
    );
  }
}
