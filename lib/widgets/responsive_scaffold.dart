import 'package:flutter/material.dart';
import 'sidebar.dart';

class ResponsiveScaffold extends StatelessWidget {
  final Widget body;

  const ResponsiveScaffold({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          // دسکتاپ
          return Row(
            children: [
              SizedBox(
                width: 250,
                child: SideBar(
                  onItemTap: (route) {
                    Navigator.pushNamed(context, route);
                  },
                ),
              ),
              Expanded(child: body),
            ],
          );
        } else {
          // موبایل/تبلت
          return Scaffold(
            appBar: AppBar(title: Text("متره یار")),
            drawer: SideBar(
              onItemTap: (route) {
                Navigator.pushNamed(context, route);
              },
            ),
            body: body,
          );
        }
      },
    );
  }
}
