import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // لوگو یا آواتار
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Text(
                'م',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            
            // نوار جستجو
            Container(
              width: 500,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'جستجو در متره یار یا وارد کردن آدرس',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 30),
            
            // shortcuts grid
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              children: [
                _buildShortcut('پروژه‌ها', Icons.folder, () {}),
                _buildShortcut('برآورد', Icons.calculate, () {}),
                _buildShortcut('گزارشات', Icons.bar_chart, () {}),
                _buildShortcut('تنظیمات', Icons.settings, () {}),
                _buildShortcut('متریال', Icons.construction, () {}),
                _buildShortcut('کارگران', Icons.people, () {}),
                _buildShortcut('ماشین‌آلات', Icons.directions_car, () {}),
                _buildShortcut('کمک', Icons.help, () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShortcut(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[50],
              child: Icon(icon, color: Colors.blue),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
