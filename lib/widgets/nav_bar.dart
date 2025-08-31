import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onSave;
  final VoidCallback? onClear;

  const NavBar({
    super.key,
    required this.title,
    this.onSave,
    this.onClear,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.blue.shade800,
      foregroundColor: Colors.white,
      actions: [
        if (onSave != null)
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: onSave,
            tooltip: 'ذخیره',
          ),
        if (onClear != null)
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onClear,
            tooltip: 'پاک کردن',
          ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => context.go('/settings'),
          tooltip: 'تنظیمات',
        ),
      ],
    );
  }
}
