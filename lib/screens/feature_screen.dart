import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';

class FeatureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ویژگی خاص")),
      drawer: SideBar(onItemTap: (route) {
        Navigator.pushNamed(context, route);
      }),
      body: Center(child: Text("صفحه ویژگی خاص")),
    );
  }
}
