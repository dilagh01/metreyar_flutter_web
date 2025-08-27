import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({super.key});

final menuItems = [
  {'title': 'خانه', 'route': '/'}, // مسیر اصلی خانه
  {'title': 'پروژه‌ها', 'route': '/projects'},
  {'title': 'آنالیز', 'route': '/analysis'},
  {'title': 'صورت وضعیت', 'route': '/report'},
  {'title': 'فهرست بها', 'route': '/price-list'},
  {'title': 'کنترل کارگاه', 'route': '/estimation'},
  {'title': 'قراردادها', 'route': '/contracts'},
  {'title': 'تنظیمات', 'route': '/settings'},
  {'title': 'داشبورد', 'route': '/dashboard'},
  {'title': 'Workflow', 'route': '/workflow'},
];
    return AppBar(
      title: const Text('نرم افزار متره یار'),
      backgroundColor: Colors.blue.shade800,
      actions: menuItems.map((item) {
        return TextButton(
          onPressed: () => context.go(item['route']!),
          child: Text(
            item['title']!,
            style: const TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
