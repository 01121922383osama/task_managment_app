import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/features/TaskManagement/domain/usecases/add_task_usecase.dart';
import 'package:task_app/features/TaskManagement/domain/usecases/delete_task_usecase.dart';
import 'package:task_app/features/TaskManagement/domain/usecases/edit_task_usecase.dart';
import 'package:task_app/features/TaskManagement/domain/usecases/get_all_task_usecase.dart';

import '../../../data/models/task_models.dart';

part 'taskmanagement_state.dart';

class TaskmanagementCubit extends Cubit<TaskmanagementState> {
  final AddTaskUsecase _addTaskUsecase;
  final EditTaskUsecase _editTaskUsecase;
  final DeleteTaskUsecase _deleteTaskUsecase;
  final GetAllTaskUsecase _allTaskUsecase;
  TaskmanagementCubit({
    required AddTaskUsecase addTaskUsecase,
    required EditTaskUsecase editTaskUsecase,
    required DeleteTaskUsecase deleteTaskUsecase,
    required GetAllTaskUsecase allTaskUsecase,
  })  : _addTaskUsecase = addTaskUsecase,
        _editTaskUsecase = editTaskUsecase,
        _deleteTaskUsecase = deleteTaskUsecase,
        _allTaskUsecase = allTaskUsecase,
        super(const TaskmanagementInitial());
  final title = TextEditingController();
  Future<void> addTask({required TaskModels task}) async {
    emit(const TaskmanagementLoading());
    final result = await _addTaskUsecase.call(p: task);
    result.fold(
      (l) => emit(TaskmanagementFailure(error: l.errorMessage)),
      (r) => emit(const TaskmanagementSuccess()),
    );
  }

  Future<void> editTask({required TaskModels task}) async {
    emit(const TaskmanagementLoading());
    final result = await _editTaskUsecase.call(p: task);
    result.fold(
      (l) => emit(TaskmanagementFailure(error: l.errorMessage)),
      (r) => emit(const TaskmanagementSuccess()),
    );
  }

  Future<void> deleteTask({required String index}) async {
    emit(const TaskmanagementLoading());
    final result = await _deleteTaskUsecase.call(p: index);
    result.fold(
      (l) => emit(TaskmanagementFailure(error: l.errorMessage)),
      (_) {
        emit(const TaskmanagementSuccess());
      },
    );
  }

  Future<void> getAllTask() async {
    emit(const TaskmanagementLoading());
    final result = await _allTaskUsecase.call();
    result.fold(
      (l) => emit(TaskmanagementFailure(error: l.errorMessage)),
      (r) => emit(TaskmanagementSuccess(tasks: r)),
    );
  }
}
