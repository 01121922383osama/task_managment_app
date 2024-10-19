import 'package:fpdart/fpdart.dart';
import '../../../../config/error/error.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/task_models.dart';
import '../repositories/task_repo.dart';

class GetAllTaskUsecase implements NoParamsUsecase<List<TaskModels>> {
  final TaskRepo _taskRepo;
  GetAllTaskUsecase({required TaskRepo taskRepo}) : _taskRepo = taskRepo;
  @override
  Future<Either<Failure, List<TaskModels>>> call() async {
    return await _taskRepo.getAllTask();
  }
}
