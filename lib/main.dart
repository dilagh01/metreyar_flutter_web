import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/',
      routes: [
        ShellRoute(
          builder: (context, state, child) => Layout(child: child),
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/pricelist',
              builder: (context, state) => const PriceListScreen(),
            ),
            GoRoute(
              path: '/report',
              builder: (context, state) => const ReportScreen(),
            ),
          ],
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Homkar',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

/// Layout با BottomNavigationBar
class Layout extends StatefulWidget {
  final Widget child;
  const Layout({super.key, required this.child});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/pricelist')) return 1;
    if (location.startsWith('/report')) return 2;
    return 0; // home
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/pricelist');
        break;
      case 2:
        context.go('/report');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final index = _getIndex(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Homkar")),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => _onTap(context, i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Price List",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Report",
          ),
        ],
      ),
    );
  }
}
