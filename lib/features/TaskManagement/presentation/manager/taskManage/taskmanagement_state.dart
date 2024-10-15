part of 'taskmanagement_cubit.dart';

abstract class TaskmanagementState extends Equatable {
  const TaskmanagementState();

  @override
  List<Object> get props => [];
}

class TaskmanagementInitial extends TaskmanagementState {
  const TaskmanagementInitial();

  @override
  List<Object> get props => [];
}

class TaskmanagementLoading extends TaskmanagementState {
  const TaskmanagementLoading();

  @override
  List<Object> get props => [];
}

class TaskmanagementSuccess extends TaskmanagementState {
  final List<TaskModels>? tasks;
  const TaskmanagementSuccess({this.tasks});

  @override
  List<Object> get props => [tasks!];
}

class TaskmanagementFailure extends TaskmanagementState {
  final String error;
  const TaskmanagementFailure({required this.error});

  @override
  List<Object> get props => [error];
}
