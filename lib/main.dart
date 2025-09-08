import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
        textTheme: GoogleFonts.vazirTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[800],
          foregroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          titleTextStyle: GoogleFonts.vazir(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
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
  bool _sidebarCollapsed = false;
  String _currentPage = 'داشبورد';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // نوار کناری
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: _sidebarCollapsed ? 70 : 250,
            color: Colors.white,
            child: Column(
              children: [
                // لوگو و عنوان
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(Icons.calculate, color: Colors.blue[800]),
                      if (!_sidebarCollapsed) SizedBox(width: 10),
                      if (!_sidebarCollapsed)
                        Text(
                          'متره‌یار',
                          style: GoogleFonts.vazir(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                    ],
                  ),
                ),
                Divider(height: 1),
                Expanded(
                  child: ListView(
                    children: [
                      _buildSidebarSection('اصلی', Icons.home, [
                        _buildSidebarItem('داشبورد', Icons.dashboard, 'داشبورد'),
                        _buildSidebarItem('پروژه‌ها', Icons.work, 'پروژه‌ها'),
                        _buildSidebarItem('فهرست بها', Icons.list, 'فهرست بها'),
                      ]),
                      _buildSidebarSection('متره و برآورد', Icons.calculate, [
                        _buildSidebarItem('آیتم‌های متره', Icons.calculate, 'آیتم‌های متره'),
                        _buildSidebarItem('محاسبات', Icons.functions, 'محاسبات'),
                        _buildSidebarItem('برآورد هزینه', Icons.attach_money, 'برآورد هزینه'),
                      ]),
                      _buildSidebarSection('گزارش‌ها', Icons.bar_chart, [
                        _buildSidebarItem('گزارش مالی', Icons.pie_chart, 'گزارش مالی'),
                        _buildSidebarItem('آنالیز پروژه', Icons.trending_up, 'آنالیز پروژه'),
                        _buildSidebarItem('خروجی PDF', Icons.picture_as_pdf, 'خروجی PDF'),
                      ]),
                      _buildSidebarSection('تنظیمات', Icons.settings, [
                        _buildSidebarItem('پروفایل کاربری', Icons.person, 'پروفایل کاربری'),
                        _buildSidebarItem('ظاهر برنامه', Icons.palette, 'ظاهر برنامه'),
                        _buildSidebarItem('راهنما و پشتیبانی', Icons.help, 'راهنما و پشتیبانی'),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // محتوای اصلی
          Expanded(
            child: Column(
              children: [
                // هدر
                Container(
                  height: 60,
                  color: Colors.blue[800],
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      // دکمه منو
                      IconButton(
                        icon: Icon(_sidebarCollapsed ? Icons.menu : Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            _sidebarCollapsed = !_sidebarCollapsed;
                          });
                        },
                      ),
                      // نوار جستجو
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'جستجوی پروژه، آیتم، فهرست بها...',
                              hintStyle: GoogleFonts.vazir(color: Colors.white70),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                              prefixIcon: Icon(Icons.search, color: Colors.white70),
                            ),
                            style: GoogleFonts.vazir(color: Colors.white),
                          ),
                        ),
                      ),
                      // دکمه‌های تنظیمات
                      IconButton(
                        icon: Icon(Icons.settings, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.person, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                // محتوای صفحه
                Expanded(
                  child: _buildContent(),
                ),
              ],
            ),
          ),
        ],
      ),
      // نوار پایین
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavItem(Icons.home, 'صفحه اصلی'),
            _buildBottomNavItem(Icons.book, 'راهنما'),
            _buildBottomNavItem(Icons.calculate, 'متره آنلاین'),
            _buildBottomNavItem(Icons.download, 'دانلودها'),
            _buildBottomNavItem(Icons.phone, 'تماس با ما'),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarSection(String title, IconData icon, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Icon(icon, size: 18, color: Colors.blue[800]),
              if (!_sidebarCollapsed) SizedBox(width: 8),
              if (!_sidebarCollapsed)
                Text(
                  title,
                  style: GoogleFonts.vazir(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
            ],
          ),
        ),
        Column(children: children),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSidebarItem(String title, IconData icon, String page) {
    return ListTile(
      leading: Icon(icon, color: _currentPage == page ? Colors.blue[800] : Colors.grey[700]),
      title: _sidebarCollapsed ? null : Text(title, style: GoogleFonts.vazir()),
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      selected: _currentPage == page,
      selectedTileColor: Colors.blue[50],
      onTap: () {
        setState(() {
          _currentPage = page;
        });
      },
    );
  }

  Widget _buildContent() {
    switch (_currentPage) {
      case 'پروژه‌ها':
        return _buildProjectsContent();
      case 'فهرست بها':
        return _buildPriceListContent();
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
            'داشبورد متره و برآورد',
            style: GoogleFonts.vazir(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          // کارت‌های اطلاعاتی
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              _buildInfoCard('تعداد پروژه‌ها', '۱۸', Icons.work, '۲ پروژه فعال در حال حاضر'),
              _buildInfoCard('مجموع برآورد', '۵,۲۸۰,۰۰۰,۰۰۰', Icons.attach_money, '۱۵% افزایش نسبت به ماه گذشته'),
              _buildInfoCard('آیتم‌های متره', '۳۴۷', Icons.calculate, '۱۲ آیتم اضافه شده امروز'),
              _buildInfoCard('وضعیت سیستم', 'فعال', Icons.check_circle, 'همه سرویس‌ها در دسترس هستند'),
            ],
          ),
          SizedBox(height: 24),
          Text(
            'پروژه‌های اخیر',
            style: GoogleFonts.vazir(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          _buildProjectsTable(),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon, String description) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.vazir(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.blue[700]),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.vazir(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),
            SizedBox(height: 4),
            Text(
              description,
              style: GoogleFonts.vazir(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsTable() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'لیست پروژه‌های فعال',
              style: GoogleFonts.vazir(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            DataTable(
              columns: [
                DataColumn(label: Text('نام پروژه', style: GoogleFonts.vazir())),
                DataColumn(label: Text('کارفرما', style: GoogleFonts.vazir())),
                DataColumn(label: Text('تاریخ شروع', style: GoogleFonts.vazir())),
                DataColumn(label: Text('مبلغ برآورد', style: GoogleFonts.vazir())),
                DataColumn(label: Text('وضعیت', style: GoogleFonts.vazir())),
                DataColumn(label: Text('عملیات', style: GoogleFonts.vazir())),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('مجتمع مسکونی نور', style: GoogleFonts.vazir())),
                  DataCell(Text('شرکت عمران نور', style: GoogleFonts.vazir())),
                  DataCell(Text('۱۴۰۲/۰۵/۱۰', style: GoogleFonts.vazir())),
                  DataCell(Text('۲,۱۵۰,۰۰۰,۰۰۰ تومان', style: GoogleFonts.vazir())),
                  DataCell(
                    Chip(
                      label: Text('فعال', style: GoogleFonts.vazir(color: Colors.white)),
                      backgroundColor: Colors.green,
                    ),
                  ),
                  DataCell(Row(
                    children: [
                      IconButton(icon: Icon(Icons.visibility, size: 18), onPressed: () {}),
                      IconButton(icon: Icon(Icons.edit, size: 18), onPressed: () {}),
                      IconButton(icon: Icon(Icons.delete, size: 18), onPressed: () {}),
                    ],
                  )),
                ]),
                DataRow(cells: [
                  DataCell(Text('پروژه تجاری کوهستان', style: GoogleFonts.vazir())),
                  DataCell(Text('هلدینگ کوهستان', style: GoogleFonts.vazir())),
                  DataCell(Text('۱۴۰۲/۰۴/۲۲', style: GoogleFonts.vazir())),
                  DataCell(Text('۱,۸۰۰,۰۰۰,۰۰۰ تومان', style: GoogleFonts.vazir())),
                  DataCell(
                    Chip(
                      label: Text('فعال', style: GoogleFonts.vazir(color: Colors.white)),
                      backgroundColor: Colors.green,
                    ),
                  ),
                  DataCell(Row(
                    children: [
                      IconButton(icon: Icon(Icons.visibility, size: 18), onPressed: () {}),
                      IconButton(icon: Icon(Icons.edit, size: 18), onPressed: () {}),
                      IconButton(icon: Icon(Icons.delete, size: 18), onPressed: () {}),
                    ],
                  )),
                ]),
                DataRow(cells: [
                  DataCell(Text('ویلای سبز', style: GoogleFonts.vazir())),
                  DataCell(Text('آقای حسینی', style: GoogleFonts.vazir())),
                  DataCell(Text('۱۴۰۲/۰۳/۱۵', style: GoogleFonts.vazir())),
                  DataCell(Text('۸۵۰,۰۰۰,۰۰۰ تومان', style: GoogleFonts.vazir())),
                  DataCell(
                    Chip(
                      label: Text('در انتظار', style: GoogleFonts.vazir(color: Colors.white)),
                      backgroundColor: Colors.orange,
                    ),
                  ),
                  DataCell(Row(
                    children: [
                      IconButton(icon: Icon(Icons.visibility, size: 18), onPressed: () {}),
                      IconButton(icon: Icon(Icons.edit, size: 18), onPressed: () {}),
                      IconButton(icon: Icon(Icons.delete, size: 18), onPressed: () {}),
                    ],
                  )),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsContent() {
    return Center(child: Text('صفحه پروژه‌ها', style: GoogleFonts.vazir()));
  }

  Widget _buildPriceListContent() {
    return Center(child: Text('صفحه فهرست بها', style: GoogleFonts.vazir()));
  }

  Widget _buildBottomNavItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20, color: Colors.grey[700]),
        SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.vazir(
            fontSize: 10,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
