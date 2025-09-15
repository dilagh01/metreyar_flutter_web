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
        fontFamily: 'Vazir',
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
  final List<Project> _projects = [];
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _projectLocationController = TextEditingController();

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

  void _addNewProject() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('پروژه جدید'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _projectNameController,
                decoration: InputDecoration(
                  labelText: 'نام پروژه',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _projectLocationController,
                decoration: InputDecoration(
                  labelText: 'مکان پروژه',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('انصراف'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_projectNameController.text.isNotEmpty) {
                  setState(() {
                    _projects.add(Project(
                      name: _projectNameController.text,
                      location: _projectLocationController.text,
                      createdAt: DateTime.now(),
                    ));
                  });
                  _projectNameController.clear();
                  _projectLocationController.clear();
                  Navigator.pop(context);
                }
              },
              child: Text('ذخیره'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('متره یار - مدیریت پروژه های ساختمانی'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNewProject,
          ),
        ],
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
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: _addNewProject,
              child: Icon(Icons.add),
              backgroundColor: Colors.blue[700],
            )
          : null,
    );
  }
}

class Project {
  final String name;
  final String location;
  final DateTime createdAt;
  double totalCost = 0.0;

  Project({
    required this.name,
    required this.location,
    required this.createdAt,
  });
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
              itemCount: 5, // Replace with actual project count
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.construction, color: Colors.blue),
                    title: Text('پروژه نمونه ${index + 1}'),
                    subtitle: Text('تهران - منطقه ۱'),
                    trailing: Text('۱۴۰۳/۰۱/۱۵'),
                    onTap: () {
                      // Navigate to project details
                    },
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
              _buildCalculationCard('بتن ریزی', Icons.concrete, Colors.orange),
              _buildCalculationCard('فولاد', Icons.architecture, Colors.blue),
              _buildCalculationCard('اجرا', Icons.construction, Colors.green),
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
        onTap: () {
          // Navigate to calculation details
        },
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

class ApiService {
  static const String baseUrl = 'https://api.example.com';

  static Future<Map<String, dynamic>> calculateConcrete({
    required double length,
    required double width,
    required double height,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/calculate/concrete'),
        body: json.encode({
          'length': length,
          'width': width,
          'height': height,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('خطا در محاسبه');
      }
    } catch (e) {
      throw Exception('خطای ارتباط با سرور');
    }
  }
}
