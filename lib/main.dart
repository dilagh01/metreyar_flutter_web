import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/project_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProjectProvider()),
      ],
      child: MaterialApp(
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
      ),
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
  void initState() {
    super.initState();
    // بارگیری پروژه‌ها هنگام راه‌اندازی
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProjectProvider>(context, listen: false).loadProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final projectProvider = Provider.of<ProjectProvider>(context);

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
          // نشانگر وضعیت اتصال
          IconButton(
            icon: Icon(
              projectProvider.isConnected ? Icons.cloud_done : Icons.cloud_off,
              color: projectProvider.isConnected ? Colors.green : Colors.red,
            ),
            onPressed: () => projectProvider.retry(),
            tooltip: projectProvider.isConnected ? 'متصل به سرور' : 'قطع ارتباط',
          ),
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
            onPressed: () {
              if (_selectedIndex == 1) {
                _showAddProjectDialog(context);
              }
            },
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
    final projectProvider = Provider.of<ProjectProvider>(context);

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
          
          // نشانگر وضعیت اتصال
          if (!projectProvider.isConnected)
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.cloud_off, color: Colors.orange),
                  SizedBox(width: 8),
                  Text('اتصال به سرور برقرار نیست'),
                  Spacer(),
                  TextButton(
                    onPressed: () => projectProvider.retry(),
                    child: Text('تلاش مجدد'),
                  ),
                ],
              ),
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
              _buildInfoCard('پروژه‌ها', '${projectProvider.projects.length}', Icons.folder, Colors.blue),
              _buildInfoCard('پروژه‌های فعال', 
                '${projectProvider.projects.where((p) => p.status == 'فعال').length}', 
                Icons.check_circle, Colors.green),
              _buildInfoCard('برآورد کل', 
                '${projectProvider.projects.fold(0.0, (sum, p) => sum + p.estimatedBudget).toStringAsFixed(1)}B', 
                Icons.attach_money, Colors.orange),
              _buildInfoCard('وضعیت', projectProvider.isConnected ? 'متصل' : 'قطع', 
                  projectProvider.isConnected ? Icons.cloud_done : Icons.cloud_off, 
                  projectProvider.isConnected ? Colors.green : Colors.red),
            ],
          ),
          
          SizedBox(height: 24),
          
          // پروژه‌های اخیر
          Text('پروژه‌های اخیر', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          
          if (projectProvider.isLoading)
            Center(child: CircularProgressIndicator())
          else if (projectProvider.error.isNotEmpty)
            Center(child: Text('خطا: ${projectProvider.error}'))
          else
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
                  DataColumn(label: Text('کارفرما')),
                  DataColumn(label: Text('وضعیت')),
                  DataColumn(label: Text('بودجه')),
                ],
                rows: projectProvider.projects.map((project) {
                  Color statusColor = Colors.green;
                  if (project.status == 'در حال انجام') statusColor = Colors.orange;
                  if (project.status == 'اتمام') statusColor = Colors.grey;

                  return DataRow(
                    cells: [
                      DataCell(Text(project.name, style: TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(Text(project.client)),
                      DataCell(
                        Chip(
                          label: Text(project.status, style: TextStyle(color: Colors.white, fontSize: 12)),
                          backgroundColor: statusColor,
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        ),
                      ),
                      DataCell(Text('${project.estimatedBudget.toStringAsFixed(1)}M تومان')),
                    ],
                  );
                }).toList(),
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

  Widget _buildProjectsContent() {
    final projectProvider = Provider.of<ProjectProvider>(context);
    
    return Scaffold(
      body: projectProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : projectProvider.error.isNotEmpty
              ? Center(child: Text('خطا: ${projectProvider.error}'))
              : ListView.builder(
                  itemCount: projectProvider.projects.length,
                  itemBuilder: (ctx, index) {
                    final project = projectProvider.projects[index];
                    return ListTile(
                      title: Text(project.name),
                      subtitle: Text(project.client),
                      trailing: Text('${project.estimatedBudget.toStringAsFixed(1)}M تومان'),
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
    final nameController = TextEditingController();
    final clientController = TextEditingController();
    final budgetController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('ایجاد پروژه جدید'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'نام پروژه'),
            ),
            TextField(
              controller: clientController,
              decoration: InputDecoration(labelText: 'کارفرما'),
            ),
            TextField(
              controller: budgetController,
              decoration: InputDecoration(labelText: 'بودجه (میلیون تومان)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('لغو'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final newProject = Project(
                  id: 0,
                  name: nameController.text,
                  client: clientController.text,
                  startDate: DateTime.now(),
                  status: 'فعال',
                  estimatedBudget: double.tryParse(budgetController.text) ?? 0,
                );
                await Provider.of<ProjectProvider>(context, listen: false)
                    .addProject(newProject);
                Navigator.pop(ctx);
              } catch (e) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  SnackBar(content: Text('خطا در ایجاد پروژه: $e')),
                );
              }
            },
            child: Text('ایجاد'),
          ),
        ],
      ),
    );
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
