import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/task_models.dart';
import '../../domain/usecases/add_task_usecase.dart';
import '../../domain/usecases/delete_task_usecase.dart';
import '../../domain/usecases/edit_task_usecase.dart';
import '../../domain/usecases/get_all_task_usecase.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final AddTaskUsecase _addTaskUsecase;
  final DeleteTaskUsecase _deleteTaskUsecase;
  final EditTaskUsecase _editTaskUsecase;
  final GetAllTaskUsecase _allTaskUsecase;

  TasksBloc({
    required AddTaskUsecase addTaskUsecase,
    required DeleteTaskUsecase deleteTaskUsecase,
    required EditTaskUsecase editTaskUsecase,
    required GetAllTaskUsecase allTaskUsecase,
  })  : _addTaskUsecase = addTaskUsecase,
        _deleteTaskUsecase = deleteTaskUsecase,
        _editTaskUsecase = editTaskUsecase,
        _allTaskUsecase = allTaskUsecase,
        super(const TasksState()) {
    on<AddTaskEvent>(_onAddTask);
    on<EditTaskEvent>(_onEditTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<GetAllTasksEvent>(_onGetAllTasks);
    on<SyncTasksEvent>(_onSyncTasks);
    on<UpdateTaskEvent>(_updateTask);
  }

  Future<void> _updateTask(
      UpdateTaskEvent event, Emitter<TasksState> emit) async {
    final result = await _editTaskUsecase(p: event.task);
    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (task) {
        final updatedTasks = state.tasks.map((t) {
          return t.id == task.id ? task : t;
        }).toList();
        emit(TasksState(tasks: updatedTasks));
      },
    );
    add(const SyncTasksEvent());
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TasksState> emit) async {
    final result = await _addTaskUsecase(p: event.task);
    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (task) {
        final updatedTasks = List<TaskModels>.from(state.tasks)..add(task);
        emit(TasksState(tasks: updatedTasks));
      },
    );
    add(const SyncTasksEvent());
  }

  Future<void> _onEditTask(
      EditTaskEvent event, Emitter<TasksState> emit) async {
    final result = await _editTaskUsecase(p: event.task);
    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (task) {
        final updatedTasks = state.tasks.map((t) {
          return t.id == task.id ? task : t;
        }).toList();
        emit(TasksState(tasks: updatedTasks));
      },
    );
    add(const SyncTasksEvent());
  }

  Future<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TasksState> emit) async {
    final result = await _deleteTaskUsecase(p: event.index);
    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (_) {
        final updatedTasks =
            state.tasks.where((task) => task.id != event.index).toList();
        emit(TasksState(tasks: updatedTasks));
      },
    );
    add(const SyncTasksEvent());
  }

  Future<void> _onGetAllTasks(
      GetAllTasksEvent event, Emitter<TasksState> emit) async {
    final result = await _allTaskUsecase();
    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (tasks) {
        emit(TasksState(tasks: tasks));
      },
    );
  }

  Future<void> _onSyncTasks(
      SyncTasksEvent event, Emitter<TasksState> emit) async {
    log('Syncing tasks with remote server...');
  }
}
