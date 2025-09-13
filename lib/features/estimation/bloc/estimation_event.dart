part of 'estimation_bloc.dart';

abstract class EstimationEvent extends Equatable {
  const EstimationEvent();

  @override
  List<Object> get props => [];
}

class LoadEstimations extends EstimationEvent {}

class AddEstimationItem extends EstimationEvent {
  final EstimationItem item;

  const AddEstimationItem({required this.item});

  @override
  List<Object> get props => [item];
}

class RemoveEstimationItem extends EstimationEvent {
  final int index;

  const RemoveEstimationItem({required this.index});

  @override
  List<Object> get props => [index];
}

class CreateEstimation extends EstimationEvent {
  final String projectName;

  const CreateEstimation({required this.projectName});

  @override
  List<Object> get props => [projectName];
}
