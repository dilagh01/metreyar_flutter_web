import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MetreyarApp());
}

class MetreyarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'متره یار',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[700],
          elevation: 4,
        ),
      ),
      home: MainDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    ProjectListScreen(),
    CalculationsScreen(),
    ReportsScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('متره یار - مدیریت پروژه های ساختمانی'),
        centerTitle: true,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'پروژه ها',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'محاسبات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'گزارشات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'تنظیمات',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.grey[600],
        onTap: _onItemTapped,
      ),
    );
  }
}

class ProjectListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'پروژه های من',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.construction, color: Colors.blue),
                    title: Text('پروژه نمونه ${index + 1}'),
                    subtitle: Text('تهران - منطقه ۱'),
                    trailing: Text('۱۴۰۳/۰۱/۱۵'),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CalculationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'محاسبات متره',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildCalculationCard('بتن ریزی', Icons.construction, Colors.orange),
              _buildCalculationCard('فولاد', Icons.architecture, Colors.blue),
              _buildCalculationCard('اجرا', Icons.build, Colors.green),
              _buildCalculationCard('نازک کاری', Icons.brush, Colors.purple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalculationCard(String title, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'گزارشات و آمار پروژه ها',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'تنظیمات برنامه',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
