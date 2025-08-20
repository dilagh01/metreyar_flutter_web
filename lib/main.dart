import 'package:flutter/material.dart';
import 'widgets/chart_widget.dart';
import 'widgets/data_table_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
    HomeScreen(),
    PriceListScreen(),
    ReportScreen(),
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

// Screens
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Home / Sample Chart'),
          SizedBox(
            height: 300,
            child: ChartWidget(
              barData: [
                BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 5)]),
                BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 3)]),
                BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 7)]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PriceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          Text('Price List'),
          DataTableWidget(),
        ],
      ),
    );
  }
}

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Report Content'));
  }
}
