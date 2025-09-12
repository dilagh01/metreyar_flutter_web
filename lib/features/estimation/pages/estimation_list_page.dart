class EstimationListPage extends StatelessWidget {
  const EstimationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('برآوردهای من'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/estimations/create'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('پروژه ${index + 1}'),
            subtitle: Text('${index * 1000000} تومان'),
            trailing: const Icon(Icons.chevron_left),
            onTap: () => context.go('/estimations/est-$index'),
          );
        },
      ),
    );
  }
}
