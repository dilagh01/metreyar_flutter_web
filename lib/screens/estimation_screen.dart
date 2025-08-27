import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/estimation_table.dart';

class EstimationScreen extends StatelessWidget {
  const EstimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("متره و تدکار")),
      drawer: SideBar(
        onItemTap: (route) {
          Navigator.pushNamed(context, route);
        },
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "لیست اقلام متره",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(child: SingleChildScrollView(child: EestimationTable())),
          ],
        ),
      ),
    );
  }
}
