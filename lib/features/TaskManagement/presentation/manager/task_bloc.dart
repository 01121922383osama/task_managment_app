import 'dart:async';

import 'package:task_app/features/TaskManagement/data/models/task_models.dart';
import 'package:task_app/features/TaskManagement/domain/repositories/task_repo.dart';

class TaskBloc {
  final TaskRepo _repo;
  final StreamController<List<TaskModels>> _taskController =
      StreamController<List<TaskModels>>.broadcast();

  TaskBloc({required TaskRepo repo}) : _repo = repo;

  Stream<List<TaskModels>> get tasks => _taskController.stream;

  Future<void> loadTasks() async {
    final result = await _repo.getAllTask();
    result.fold(
      (failure) => _taskController.addError(failure.errorMessage),
      (taskList) => _taskController.add(taskList),
    );
  }

  Future<void> addTask(TaskModels task) async {
    final result = await _repo.addTask(task: task);
    result.fold(
      (failure) => _taskController.addError(failure.errorMessage),
      (newTask) => loadTasks(), // Reload tasks after addition
    );
  }

  Future<void> editTask(TaskModels task) async {
    final result = await _repo.editTask(task: task);
    result.fold(
      (failure) => _taskController.addError(failure.errorMessage),
      (updatedTask) => loadTasks(), // Reload tasks after edit
    );
  }

  Future<void> deleteTask(String index) async {
    final result = await _repo.deleteTask(index: index);
    result.fold(
      (failure) => _taskController.addError(failure.errorMessage),
      (_) => loadTasks(), // Reload tasks after deletion
    );
  }

  void dispose() {
    _taskController.close();
  }
}
