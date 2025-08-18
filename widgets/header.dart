import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Text("TADKAR Dashboard", style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    );
  }
}
