import 'package:flutter/material.dart';

import '../widgets/footer.dart';
import '../widgets/nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('خانه')),
      drawer: const NavBar(),
      body: Column(
        children: const [
          Expanded(child: Center(child: Text('محتوای صفحه اصلی'))),
          Footer(),
        ],
      ),
    );
  }
}
