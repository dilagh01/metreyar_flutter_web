part of 'estimation_bloc.dart';

abstract class EstimationState extends Equatable {
  const EstimationState();

  @override
  List<Object> get props => [];
}

class EstimationInitial extends EstimationState {}

class EstimationLoading extends EstimationState {}

class EstimationData extends EstimationState {
  final List<EstimationItem> items;
  final double grandTotal;

  const EstimationData({
    required this.items,
    required this.grandTotal,
  });

  @override
  List<Object> get props => [items, grandTotal];
}

class EstimationsLoaded extends EstimationState {
  final List<EstimationModel> estimations;

  const EstimationsLoaded({required this.estimations});

  @override
  List<Object> get props => [estimations];
}

class EstimationCreated extends EstimationState {}

class EstimationError extends EstimationState {
  final String message;

  const EstimationError({required this.message});

  @override
  List<Object> get props => [message];
}
