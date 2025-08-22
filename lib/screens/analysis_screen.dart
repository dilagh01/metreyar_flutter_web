import 'package:flutter/material.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تحلیل و آنالیز")),
      body: const Center(
        child: Text("اینجا نتایج تحلیل نشون داده میشه"),
      ),
    );
  }
}
