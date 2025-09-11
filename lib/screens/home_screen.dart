import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import 'materials_screen.dart';
import 'boq_screen.dart';

class _HomeScreenState extends State<HomeScreen> {
  // ... کدهای قبلی

  @override
  void initState() {
    super.initState();
    // بارگیری اولیه برنامه
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MainProvider>(context, listen: false).initializeApp();
    });
  }

  Widget _buildDashboardContent() {
    final mainProvider = Provider.of<MainProvider>(context);
    final projectProvider = mainProvider.projectProvider;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // نشانگر خطای全局
          if (mainProvider.globalError.isNotEmpty)
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(width: 8),
                  Expanded(child: Text(mainProvider.globalError)),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => mainProvider.clearGlobalError(),
                  ),
                ],
              ),
            ),

          // بقیه محتوا...
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
