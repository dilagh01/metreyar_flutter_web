import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  final Function(String) onItemTap;

  const SideBar({Key? key, required this.onItemTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text("متره یار", style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          ListTile(
            title: Text("خانه"),
            onTap: () => onItemTap("/home"),
          ),
          ListTile(
            title: Text("قراردادها"),
            onTap: () => onItemTap("/contracts"),
          ),
          ListTile(
            title: Text("داشبورد"),
            onTap: () => onItemTap("/dashboard"),
          ),
          ListTile(
            title: Text("گزارش‌ها"),
            onTap: () => onItemTap("/report"),
          ),
          ListTile(
            title: Text("تنظیمات"),
            onTap: () => onItemTap("/settings"),
          ),
          ListTile(
            title: Text("   ^f   ^l ^e    "),
            onTap: () => onItemTap("/estimation"),
          ),
        ],
      ),
    );
  }
}
