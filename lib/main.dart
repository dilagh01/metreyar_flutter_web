import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'متره‌یار',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _sidebarCollapsed = true;
  bool _isHovering = false;

  final List<String> _pageTitles = [
    'داشبورد',
    'پروژه‌ها',
    'فهرست بها',
    'گزارش‌ها',
    'تنظیمات'
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.calculate, color: Colors.blue[700]),
            SizedBox(width: 8),
            Text(
              'متره‌یار',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            width: 250,
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'جستجوی پروژه، آیتم، فهرست بها...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                prefixIcon: Icon(Icons.search, size: 20),
              ),
              style: TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(width: 16),
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue,
              child: Text(
                'ユ',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // نوار کناری (سبک GitHub)
          MouseRegion(
            onEnter: (_) => setState(() => _isHovering = true),
            onExit: (_) => setState(() => _isHovering = false),
            child: Container(
              width: _isHovering ? 220 : 70,
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.grey[300]!,
                    width: 1,
                  ),
                ),
              ),
              child: ListView(
                children: [
                  // لوگو
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Icon(
                      Icons.calculate,
                      size: 32,
                      color: Colors.blue[700],
                    ),
                  ),
                  
                  // منوی اصلی
                  _buildSidebarItem(Icons.dashboard, 'داشبورد', 0),
                  _buildSidebarItem(Icons.folder, 'پروژه‌ها', 1),
                  _buildSidebarItem(Icons.list, 'فهرست بها', 2),
                  _buildSidebarItem(Icons.bar_chart, 'گزارش‌ها', 3),
                  _buildSidebarItem(Icons.settings, 'تنظیمات', 4),
                  
                  Divider(),
                  
                  // منوی ثانویه
                  _buildSidebarItem(Icons.calculate, 'محاسبات', 5),
                  _buildSidebarItem(Icons.analytics, 'آنالیز', 6),
                ],
              ),
            ),
          ),
          
          // محتوای اصلی
          Expanded(
            child: Container(
              color: Colors.grey[50],
              child: _buildContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, int index) {
    final bool isSelected = _selectedIndex == index;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Icon(
        icon,
        size: 20,
        color: isSelected ? Colors.blue[700] : isDark ? Colors.grey[400] : Colors.grey[600],
      ),
      title: _isHovering ? Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.blue[700] : isDark ? Colors.grey[400] : Colors.grey[600],
        ),
      ) : null,
      selected: isSelected,
      selectedTileColor: isSelected 
          ? Colors.blue[50]!
          : null,
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboardContent();
      case 1:
        return _buildProjectsContent();
      case 2:
        return _buildPriceListContent();
      case 3:
        return _buildReportsContent();
      case 4:
        return _buildSettingsContent();
      default:
        return _buildDashboardContent();
    }
  }

  Widget _buildDashboardContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'داشبورد متره‌یار',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          
          // کارت‌های اطلاعاتی
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2,
            children: [
              _buildInfoCard('پروژه‌های فعال', '۱۲', Icons.folder, Colors.blue),
              _buildInfoCard('آیتم‌های متره', '۳۴۷', Icons.list, Colors.green),
              _buildInfoCard('برآورد کل', '۵.۲B', Icons.attach_money, Colors.orange),
              _buildInfoCard('تسک‌های pending', '۸', Icons.task, Colors.red),
            ],
          ),
          
          SizedBox(height: 24),
          
          // پروژه‌های اخیر
          Text('پروژه‌های اخیر', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: DataTable(
              columns: [
                DataColumn(label: Text('نام پروژه')),
                DataColumn(label: Text('وضعیت')),
                DataColumn(label: Text('آخرین بروزرسانی')),
                DataColumn(label: Text('عملیات')),
              ],
              rows: [
                _buildProjectRow('پروژه تجاری کوهستان', 'فعال', '۲ ساعت پیش'),
                _buildProjectRow('مجتمع مسکونی نور', 'در حال انجام', '۱ روز پیش'),
                _buildProjectRow('ویلای سبز', 'اتمام', '۳ روز پیش'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(title, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  DataRow _buildProjectRow(String name, String status, String lastUpdate) {
    Color statusColor = Colors.green;
    if (status == 'در حال انجام') statusColor = Colors.orange;
    if (status == 'اتمام') statusColor = Colors.grey;

    return DataRow(
      cells: [
        DataCell(Text(name, style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(
          Chip(
            label: Text(status, style: TextStyle(color: Colors.white, fontSize: 12)),
            backgroundColor: statusColor,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          ),
        ),
        DataCell(Text(lastUpdate)),
        DataCell(
          Row(
            children: [
              IconButton(icon: Icon(Icons.visibility, size: 18), onPressed: () {}),
              IconButton(icon: Icon(Icons.edit, size: 18), onPressed: () {}),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsContent() {
    return Center(child: Text('صفحه پروژه‌ها', style: TextStyle(fontSize: 24)));
  }

  Widget _buildPriceListContent() {
    return Center(child: Text('صفحه فهرست بها', style: TextStyle(fontSize: 24)));
  }

  Widget _buildReportsContent() {
    return Center(child: Text('صفحه گزارش‌ها', style: TextStyle(fontSize: 24)));
  }

  Widget _buildSettingsContent() {
    return Center(child: Text('صفحه تنظیمات', style: TextStyle(fontSize: 24)));
  }
}


