import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: Color(0xFF101820),
      child: Column(
        children: [
          SizedBox(height: 40),
          Text(
            'Metreyar',
            style: TextStyle(
              color: Colors.greenAccent,
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
          Divider(color: Colors.greenAccent),
          ListTile(
            leading: Icon(Icons.dashboard, color: Colors.greenAccent),
            title: Text('Dashboard', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.list_alt, color: Colors.greenAccent),
            title: Text('BOQ', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.money, color: Colors.greenAccent),
            title: Text('Materials', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
