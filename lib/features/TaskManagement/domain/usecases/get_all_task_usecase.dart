import 'package:fpdart/fpdart.dart';
import 'package:task_app/config/error/error.dart';
import 'package:task_app/config/usecase/usecase.dart';
import 'package:task_app/features/TaskManagement/data/models/task_models.dart';
import 'package:task_app/features/TaskManagement/domain/repositories/task_repo.dart';

class GetAllTaskUsecase implements NoParamsUsecase<List<TaskModels>> {
  final TaskRepo _taskRepo;
  GetAllTaskUsecase({required TaskRepo taskRepo}) : _taskRepo = taskRepo;
  @override
  Future<Either<Failure, List<TaskModels>>> call() async {
    return await _taskRepo.getAllTask();
  }
}
