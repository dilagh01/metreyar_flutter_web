import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("خانه")),
      drawer: SideBar(
        onItemTap: (route) {
          Navigator.pushNamed(context, route);
        },
      ),
      body: Center(
        child: Text("به متره یار خوش آمدید"),
      ),
    );
  }
}
