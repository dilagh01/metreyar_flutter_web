import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/estimation_bloc.dart';
import '../../../data/repositories/api_repository.dart';

class EstimationPage extends StatelessWidget {
  const EstimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EstimationBloc(
        apiRepository: ApiRepository(),
      )..add(LoadEstimations()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('برآورد پروژه'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/welcome'),
          ),
        ),
        body: BlocBuilder<EstimationBloc, EstimationState>(
          builder: (context, state) {
            if (state is EstimationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EstimationError) {
              return Center(child: Text('خطا: ${state.message}'));
            } else if (state is EstimationData) {
              return _buildEstimationForm(context, state);
            } else {
              return const Center(child: Text('آماده برای شروع برآورد'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildEstimationForm(BuildContext context, EstimationData state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return ListTile(
                  title: Text(item.material.name),
                  subtitle: Text('${item.quantity} ${item.material.unit} × ${item.unitPrice}'),
                  trailing: Text('${item.total} تومان'),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'جمع کل: ${state.grandTotal.toStringAsFixed(2)} تومان',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
