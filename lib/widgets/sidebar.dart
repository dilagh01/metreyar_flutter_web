// lib/widgets/sidebar.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Sidebar extends StatelessWidget {
  Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('متره یار', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('صفحه اصلی'),
            onTap: () => context.go('/home'),
          ),
          ListTile(
            leading: Icon(Icons.calculate),
            title: Text('برآورد متره'),
            onTap: () => context.go('/estimation'),
          ),
          ListTile(
            leading: Icon(Icons.analytics),
            title: Text('آنالیز پروژه'),
            onTap: () => context.go('/analysis'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('تنظیمات'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('خروج'),
            onTap: () => context.go('/login'),
          ),
        ],
      ),
    );
  }
}
