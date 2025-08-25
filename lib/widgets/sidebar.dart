import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final Function(String) onItemTap;

  const Sidebar({super.key, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              "متره‌یار",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            title: const Text("خانه"),
            onTap: () => onItemTap("/home"),
          ),
          ListTile(
            title: const Text("پروژه‌ها"),
            onTap: () => onItemTap("/projects"),
          ),
          ListTile(
            title: const Text("گزارش‌ها"),
            onTap: () => onItemTap("/report"),
          ),
          ListTile(
            title: const Text("تنظیمات"),
            onTap: () => onItemTap("/settings"),
          ),
        ],
      ),
    );
  }
}



