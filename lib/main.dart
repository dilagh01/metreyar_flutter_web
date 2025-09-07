import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BoqProvider()),
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
        ChangeNotifierProvider(create: (_) => PriceProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'متره‌یار',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Vazir',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[800],
          foregroundColor: Colors.white,
        ),
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// مدل‌های داده
class BoqItem {
  final String id;
  String description;
  String unit;
  double quantity;
  double unitPrice;
  double totalPrice;

  BoqItem({
    required this.id,
    required this.description,
    required this.unit,
    required this.quantity,
    required this.unitPrice,
  }) : totalPrice = quantity * unitPrice;
}

class Project {
  final String id;
  final String name;
  final String client;
  final DateTime startDate;
  final DateTime endDate;
  final List<BoqItem> boqItems;

  Project({
    required this.id,
    required this.name,
    required this.client,
    required this.startDate,
    required this.endDate,
    required this.boqItems,
  });
}

// ارائه‌دهندگان وضعیت
class BoqProvider with ChangeNotifier {
  List<BoqItem> _boqItems = [];

  List<BoqItem> get boqItems => _boqItems;

  void addBoqItem(BoqItem item) {
    _boqItems.add(item);
    notifyListeners();
  }

  void updateBoqItem(String id, BoqItem newItem) {
    final index = _boqItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      _boqItems[index] = newItem;
      notifyListeners();
    }
  }

  void removeBoqItem(String id) {
    _boqItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}

class ProjectProvider with ChangeNotifier {
  List<Project> _projects = [];

  List<Project> get projects => _projects;

  void addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }
}

class PriceProvider with ChangeNotifier {
  Map<String, double> _priceList = {};

  Map<String, double> get priceList => _priceList;

  void updatePrice(String item, double price) {
    _priceList[item] = price;
    notifyListeners();
  }
}

// صفحه ورود
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', height: 100),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  labelText: 'نام کاربری',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'رمز عبور',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Text('ورود به سیستم'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// صفحه اصلی
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('متره‌یار - سیستم متره و برآورد'),
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: () {}),
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('منو اصلی', style: TextStyle(color: Colors.white, fontSize: 20)),
              decoration: BoxDecoration(color: Colors.blue[800]),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('داشبورد'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('پروژه‌ها'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('فهرست بها'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PriceListScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('متره و برآورد'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BoqScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text('آنالیز و گزارش'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AnalysisScreen()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('به متره‌یار خوش آمدید', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                _buildFeatureCard(context, 'پروژه‌ها', Icons.assignment, ProjectsScreen()),
                _buildFeatureCard(context, 'فهرست بها', Icons.list, PriceListScreen()),
                _buildFeatureCard(context, 'متره و برآورد', Icons.calculate, BoqScreen()),
                _buildFeatureCard(context, 'گزارش‌ها', Icons.analytics, AnalysisScreen()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, IconData icon, Widget screen) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        },
        child: Container(
          width: 150,
          height: 150,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40),
              SizedBox(height: 10),
              Text(title, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

// صفحه پروژه‌ها
class ProjectsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('مدیریت پروژه‌ها')),
      body: Consumer<ProjectProvider>(
        builder: (context, projectProvider, child) {
          return ListView.builder(
            itemCount: projectProvider.projects.length,
            itemBuilder: (context, index) {
              final project = projectProvider.projects[index];
              return ListTile(
                title: Text(project.name),
                subtitle: Text(project.client),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {},
                ),
                onTap: () {},
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddProjectDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddProjectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ایجاد پروژه جدید'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(decoration: InputDecoration(labelText: 'نام پروژه')),
              TextField(decoration: InputDecoration(labelText: 'کارفرما')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('لغو'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('پروژه جدید ایجاد شد')),
                );
              },
              child: Text('ایجاد'),
            ),
          ],
        );
      },
    );
  }
}

// صفحه فهرست بها
class PriceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('فهرست بها')),
      body: Consumer<PriceProvider>(
        builder: (context, priceProvider, child) {
          return DataTable(
            columns: [
              DataColumn(label: Text('ردیف')),
              DataColumn(label: Text('شرح آیتم')),
              DataColumn(label: Text('واحد')),
              DataColumn(label: Text('قیمت (ریال)')),
            ],
            rows: priceProvider.priceList.entries.map((entry) {
              return DataRow(cells: [
                DataCell(Text((priceProvider.priceList.keys.toList().indexOf(entry.key) + 1).toString())),
                DataCell(Text(entry.key)),
                DataCell(Text('متر مربع')),
                DataCell(Text(entry.value.toStringAsFixed(2))),
              ]);
            }).toList(),
          );
        },
      ),
    );
  }
}

// صفحه متره و برآورد
class BoqScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('متره و برآورد')),
      body: Consumer<BoqProvider>(
        builder: (context, boqProvider, child) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('ردیف')),
                DataColumn(label: Text('شرح آیتم')),
                DataColumn(label: Text('واحد')),
                DataColumn(label: Text('مقدار')),
                DataColumn(label: Text('قیمت واحد')),
                DataColumn(label: Text('جمع کل')),
              ],
              rows: boqProvider.boqItems.map((item) {
                return DataRow(cells: [
                  DataCell(Text((boqProvider.boqItems.indexOf(item) + 1).toString())),
                  DataCell(Text(item.description)),
                  DataCell(Text(item.unit)),
                  DataCell(Text(item.quantity.toString())),
                  DataCell(Text(item.unitPrice.toStringAsFixed(2))),
                  DataCell(Text(item.totalPrice.toStringAsFixed(2))),
                ]);
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddBoqItemDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddBoqItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('افزودن آیتم جدید'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(decoration: InputDecoration(labelText: 'شرح آیتم')),
              TextField(decoration: InputDecoration(labelText: 'واحد')),
              TextField(decoration: InputDecoration(labelText: 'مقدار'), keyboardType: TextInputType.number),
              TextField(decoration: InputDecoration(labelText: 'قیمت واحد'), keyboardType: TextInputType.number),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('لغو'),
            ),
            ElevatedButton(
              onPressed: () {
                final boqProvider = Provider.of<BoqProvider>(context, listen: false);
                boqProvider.addBoqItem(BoqItem(
                  id: DateTime.now().toString(),
                  description: 'آیتم تست',
                  unit: 'متر مربع',
                  quantity: 10,
                  unitPrice: 50000,
                ));
                Navigator.of(context).pop();
              },
              child: Text('افزودن'),
            ),
          ],
        );
      },
    );
  }
}

// صفحه آنالیز و گزارش
class AnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('آنالیز و گزارش‌ها')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart, size: 60, color: Colors.blue),
            SizedBox(height: 20),
            Text('گزارش‌های تحلیلی پروژه', style: TextStyle(fontSize: 20)),
            SizedBox(height: 30),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                _buildReportCard('گزارش مالی', Icons.attach_money),
                _buildReportCard('آنالیز مصالح', Icons.construction),
                _buildReportCard('زمان‌بندی', Icons.schedule),
                _buildReportCard('نمودارها', Icons.show_chart),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, IconData icon) {
    return Card(
      child: Container(
        width: 150,
        height: 120,
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30),
            SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
