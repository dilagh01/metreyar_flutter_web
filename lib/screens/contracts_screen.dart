import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';

class ContractsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("قراردادها")),
      drawer: SideBar(onItemTap: (route) {
        Navigator.pushNamed(context, route);
      }),
      body: Center(child: Text("صفحه قراردادها")),
    );
  }
}
