// در main.dart یا dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/project_provider.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final projectProvider = Provider.of<ProjectProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('متره‌یار'),
        actions: [
          IconButton(
            icon: Icon(
              projectProvider.isConnected ? Icons.wifi : Icons.wifi_off,
              color: projectProvider.isConnected ? Colors.green : Colors.red,
            ),
            onPressed: () => projectProvider.checkConnection(),
          ),
        ],
      ),
      body: _buildBody(context, projectProvider),
    );
  }

  Widget _buildBody(BuildContext context, ProjectProvider projectProvider) {
    if (!projectProvider.isConnected) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(
              'اتصال به سرور برقرار نیست',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
            SizedBox(height: 8),
            Text(
              'لطفاً اتصال اینترنت خود را بررسی کنید',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => projectProvider.loadProjects(),
              child: Text('تلاش مجدد'),
            ),
          ],
        ),
      );
    }

    if (projectProvider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (projectProvider.error.isNotEmpty) {
      return Center(child: Text('خطا: ${projectProvider.error}'));
    }

    return ListView.builder(
      itemCount: projectProvider.projects.length,
      itemBuilder: (ctx, index) {
        final project = projectProvider.projects[index];
        return ListTile(
          title: Text(project.name),
          subtitle: Text(project.client),
          trailing: Text('${project.estimatedBudget} تومان'),
        );
      },
    );
  }
}
