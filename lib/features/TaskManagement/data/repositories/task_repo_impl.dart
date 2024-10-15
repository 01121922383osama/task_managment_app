import 'package:fpdart/fpdart.dart';
import 'package:task_app/config/error/error.dart';
import 'package:task_app/config/error/server_exception.dart';
import 'package:task_app/features/TaskManagement/data/datasources/remote/task_remote_data_source.dart';
import 'package:task_app/features/TaskManagement/data/models/task_models.dart';
import 'package:task_app/features/TaskManagement/domain/repositories/task_repo.dart';

class TaskRepoImpl implements TaskRepo {
  final TaskRemoteDataSource _dataSource;

  TaskRepoImpl({required TaskRemoteDataSource dataSource})
      : _dataSource = dataSource;
  @override
  Future<Either<Failure, TaskModels>> addTask(
      {required TaskModels task}) async {
    try {
      return Right(await _dataSource.addTask(task: task));
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask({required String index}) async {
    try {
      return Right(await _dataSource.deleteTask(index: index));
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskModels>> editTask(
      {required TaskModels task}) async {
    try {
      return Right(await _dataSource.editTask(task: task));
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskModels>>> getAllTask() async {
    try {
      return Right(await _dataSource.getAllTask());
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
