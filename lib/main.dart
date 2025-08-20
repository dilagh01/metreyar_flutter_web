import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/price_list_screen.dart';
import 'screens/report_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Homkar App',
      home: const MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const PriceListScreen(),
    const ReportScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(title: const Text('Homkar App')),
      drawer: isDesktop ? null : Drawer(child: _buildSidebar()),
      body: Row(
        children: [
          if (isDesktop) SizedBox(width: 250, child: _buildSidebar()),
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return ListView(
      children: [
        const DrawerHeader(
          child: Center(
            child: Text('Homkar', style: TextStyle(fontSize: 24)),
          ),
        ),
        _buildMenuItem('Home', 0, Icons.home),
        _buildMenuItem('Price List', 1, Icons.list_alt),
        _buildMenuItem('Report', 2, Icons.bar_chart),
      ],
    );
  }

  Widget _buildMenuItem(String title, int index, IconData icon) {
    bool selected = _selectedIndex == index;
    return ListTile(
      leading: Icon(icon, color: selected ? Colors.blue : null),
      title: Text(title, style: TextStyle(color: selected ? Colors.blue : null)),
      selected: selected,
      onTap: () {
        setState(() => _selectedIndex = index);
        if (MediaQuery.of(context).size.width <= 800) Navigator.pop(context);
      },
    );
  }
}
