import 'package:fpdart/fpdart.dart';

import '../../../../config/error/error.dart';
import '../../../../config/error/server_exception.dart';
import '../../domain/repositories/task_repo.dart';
import '../datasources/remote/task_remote_data_source.dart';
import '../models/task_models.dart';

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
      return Right(await _dataSource.deleteTask(id: index));
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
      return Right(await _dataSource.getAllTasks());
    } on ServerException catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}
