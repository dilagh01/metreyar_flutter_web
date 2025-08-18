import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text("TADKAR", style: TextStyle(fontSize: 24))),
          ListTile(title: Text("داشبورد"), onTap: () => context.go('/')),
          ListTile(title: Text("فهرست بها"), onTap: () => context.go('/price-list')),
          ListTile(title: Text("متره و برآورد"), onTap: () => context.go('/estimation')),
          ListTile(title: Text("گزارش‌ها"), onTap: () => context.go('/reports')),
        ],
      ),
    );
  }
}
