// lib/features/estimation/bloc/estimation_bloc.dart
class EstimationBloc extends Bloc<EstimationEvent, EstimationState> {
  final EstimationRepository repository;

  EstimationBloc({required this.repository}) : super(EstimationInitial()) {
    on<LoadMaterials>(_onLoadMaterials);
    on<SearchMaterials>(_onSearchMaterials);
    on<AddEstimationItem>(_onAddEstimationItem);
    on<CalculateEstimation>(_onCalculateEstimation);
    on<SaveEstimation>(_onSaveEstimation);
  }

  Future<void> _onLoadMaterials(
    LoadMaterials event,
    Emitter<EstimationState> emit,
  ) async {
    emit(EstimationLoading());
    try {
      final materials = await repository.getMaterials();
      emit(MaterialsLoaded(materials: materials));
    } catch (e) {
      emit(EstimationError(message: 'خطا در دریافت مصالح: $e'));
    }
  }

  Future<void> _onCalculateEstimation(
    CalculateEstimation event,
    Emitter<EstimationState> emit,
  ) async {
    if (state is EstimationDataLoaded) {
      final currentState = state as EstimationDataLoaded;
      final estimation = currentState.estimation;
      
      // انجام محاسبات
      final calculatedEstimation = estimation.copyWith(
        // محاسبات به صورت خودکار در getterهای مدل انجام می‌شوند
      );
      
      emit(EstimationDataLoaded(estimation: calculatedEstimation));
    }
  }
}
