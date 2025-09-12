class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('داشبورد'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: GridView(
        children: [
          _buildFeatureCard(
            title: 'برآورد پروژه',
            icon: Icons.calculate,
            onTap: () => context.go('/estimations'),
          ),
          _buildFeatureCard(
            title: 'مدیریت مصالح',
            icon: Icons.inventory,
            onTap: () => context.go('/materials'),
          ),
          _buildFeatureCard(
            title: 'پروژه‌ها',
            icon: Icons.construction,
            onTap: () => context.go('/projects'),
          ),
          _buildFeatureCard(
            title: 'گزارش‌گیری',
            icon: Icons.analytics,
            onTap: () => context.go('/analysis'),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}
