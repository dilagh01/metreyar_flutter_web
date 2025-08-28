// providers/estimation_provider.dart
final estimationProvider = StateNotifierProvider<EstimationNotifier, List<Map<String, dynamic>>>((ref) {
  return EstimationNotifier();
});

class EstimationNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  EstimationNotifier() : super([]);

  void addRow(Map<String, dynamic> row) {
    state = [...state, row];
  }

  void updateRow(int index, Map<String, dynamic> newRow) {
    state = [
      for (int i = 0; i < state.length; i++)
        i == index ? newRow : state[i]
    ];
  }

  void deleteRow(int index) {
    state = state.where((_, i) => i != index).toList();
  }
}
