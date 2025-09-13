import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/estimation_calculator.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/estimation_model.dart';
import '../../../data/repositories/api_repository.dart';

part 'estimation_event.dart';
part 'estimation_state.dart';

class EstimationBloc extends Bloc<EstimationEvent, EstimationState> {
  final ApiRepository apiRepository;

  EstimationBloc({required this.apiRepository}) : super(EstimationInitial()) {
    on<LoadEstimations>(_onLoadEstimations);
    on<AddEstimationItem>(_onAddEstimationItem);
    on<RemoveEstimationItem>(_onRemoveEstimationItem);
    on<CreateEstimation>(_onCreateEstimation);
  }

  Future<void> _onLoadEstimations(
    LoadEstimations event,
    Emitter<EstimationState> emit,
  ) async {
    emit(EstimationLoading());
    try {
      final estimations = await apiRepository.getEstimations();
      emit(EstimationsLoaded(estimations: estimations));
    } catch (e) {
      emit(EstimationError(message: e.toString()));
    }
  }

  Future<void> _onAddEstimationItem(
    AddEstimationItem event,
    Emitter<EstimationState> emit,
  ) async {
    if (state is EstimationData) {
      final currentState = state as EstimationData;
      final updatedItems = List<EstimationItem>.from(currentState.items)..add(event.item);
      
      emit(EstimationData(
        items: updatedItems,
        grandTotal: EstimationCalculator.calculateTotal(updatedItems),
      ));
    }
  }

  Future<void> _onRemoveEstimationItem(
    RemoveEstimationItem event,
    Emitter<EstimationState> emit,
  ) async {
    if (state is EstimationData) {
      final currentState = state as EstimationData;
      final updatedItems = List<EstimationItem>.from(currentState.items)..removeAt(event.index);
      
      emit(EstimationData(
        items: updatedItems,
        grandTotal: EstimationCalculator.calculateTotal(updatedItems),
      ));
    }
  }

  Future<void> _onCreateEstimation(
    CreateEstimation event,
    Emitter<EstimationState> emit,
  ) async {
    if (state is EstimationData) {
      emit(EstimationLoading());
      try {
        final currentState = state as EstimationData;
        final estimation = EstimationModel(
          id: '',
          projectName: event.projectName,
          items: currentState.items,
          createdAt: DateTime.now(),
        );
        
        await apiRepository.createEstimation(estimation);
        emit(EstimationCreated());
      } catch (e) {
        emit(EstimationError(message: e.toString()));
      }
    }
  }
}
