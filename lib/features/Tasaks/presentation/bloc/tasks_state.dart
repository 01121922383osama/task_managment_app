part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<TaskModels> tasks;
  const TasksState({this.tasks = const <TaskModels>[]});

  @override
  List<Object> get props => [tasks];
}
