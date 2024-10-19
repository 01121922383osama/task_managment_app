part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TasksEvent {
  final TaskModels task;
  const AddTaskEvent({required this.task});
  @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends TasksEvent {
  final TaskModels task;
  const UpdateTaskEvent({required this.task});
  @override
  List<Object> get props => [task];
}

class EditTaskEvent extends TasksEvent {
  final TaskModels task;
  const EditTaskEvent({required this.task});
  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends TasksEvent {
  final String index;
  const DeleteTaskEvent({required this.index});
  @override
  List<Object> get props => [index];
}

class GetAllTasksEvent extends TasksEvent {
  const GetAllTasksEvent();
  @override
  List<Object> get props => [];
}

class SyncTasksEvent extends TasksEvent {
  const SyncTasksEvent();
  @override
  List<Object> get props => [];
}
