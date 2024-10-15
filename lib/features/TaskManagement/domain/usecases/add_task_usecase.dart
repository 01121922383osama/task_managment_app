import 'package:fpdart/fpdart.dart';
import 'package:task_app/config/error/error.dart';
import 'package:task_app/config/usecase/usecase.dart';
import 'package:task_app/features/TaskManagement/data/models/task_models.dart';
import 'package:task_app/features/TaskManagement/domain/repositories/task_repo.dart';

class AddTaskUsecase implements Usecase<TaskModels, TaskModels> {
  final TaskRepo _repo;

  AddTaskUsecase({required TaskRepo repo}) : _repo = repo;
  @override
  Future<Either<Failure, TaskModels>> call({
    required TaskModels p,
  }) async {
    return await _repo.addTask(task: p);
  }
}
