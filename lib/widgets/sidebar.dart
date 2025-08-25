import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  final Function(String route) onItemTap;

  SideBar({required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Text(
              'Metreyar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          _buildItem(Icons.home, "خانه", '/', context),
          _buildItem(Icons.business, "پروژه‌ها", '/projects', context),
          _buildItem(Icons.article, "قراردادها", '/contracts', context),
          _buildItem(Icons.dashboard, "داشبورد", '/dashboard', context),
          _buildItem(Icons.extension, "ویژگی‌ها", '/features', context),
          _buildItem(Icons.star, "ویژگی خاص", '/feature', context),
          _buildItem(Icons.straighten, "متره", '/metering', context),
          _buildItem(Icons.list, "فهرست بها", '/price_list', context),
          _buildItem(Icons.bar_chart, "گزارشات", '/report', context),
          _buildItem(Icons.settings, "تنظیمات", '/settings', context),
          _buildItem(Icons.work, "جریان کار", '/workflow', context),
        ],
      ),
    );
  }

  Widget _buildItem(IconData icon, String title, String route, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // بستن منو
        onItemTap(route); // رفتن به صفحه
      },
    );
  }
}
