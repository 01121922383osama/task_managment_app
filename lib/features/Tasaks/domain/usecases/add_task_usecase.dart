import 'package:fpdart/fpdart.dart';
import '../../../../config/error/error.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/task_models.dart';
import '../repositories/task_repo.dart';

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
