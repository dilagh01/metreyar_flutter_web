import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import 'materials_screen.dart';
import 'boq_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Dashboard',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent)),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        MaterialCard(title: 'Materials', onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => MaterialsScreen())
                          );
                        }),
                        MaterialCard(title: 'BOQ', onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => BOQScreen())
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MaterialCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const MaterialCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Color(0xFF006A4E)),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: TextStyle(color: Colors.white)),
        trailing: Icon(Icons.arrow_forward, color: Colors.greenAccent),
        onTap: onTap,
      ),
    );
  }
}
Consumer<ProjectProvider>(
  builder: (context, provider, child) {
    if (provider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (provider.error.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(provider.error),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => provider.retry(),
              child: Text('تلاش دوباره'),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: provider.projects.length,
      itemBuilder: (context, index) {
        final project = provider.projects[index];
        return ListTile(
          title: Text(project.name),
          subtitle: Text('${project.client} - ${project.status}'),
          trailing: Text('${project.estimatedBudget} تومان'),
        );
      },
    );
  },
)
