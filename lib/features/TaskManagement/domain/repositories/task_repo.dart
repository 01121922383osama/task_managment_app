import 'package:fpdart/fpdart.dart';
import 'package:task_app/config/error/error.dart';
import 'package:task_app/features/TaskManagement/data/models/task_models.dart';

abstract interface class TaskRepo {
  Future<Either<Failure, TaskModels>> addTask({required TaskModels task});
  Future<Either<Failure, TaskModels>> editTask({required TaskModels task});
  Future<Either<Failure, void>> deleteTask({required String index});
  Future<Either<Failure, List<TaskModels>>> getAllTask();
}
