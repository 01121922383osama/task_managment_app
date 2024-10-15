import 'package:fpdart/fpdart.dart';
import 'package:task_app/config/error/error.dart';
import 'package:task_app/config/usecase/usecase.dart';
import 'package:task_app/features/TaskManagement/domain/repositories/task_repo.dart';

class DeleteTaskUsecase implements Usecase<void, String> {
  final TaskRepo _repo;

  DeleteTaskUsecase({required TaskRepo repo}) : _repo = repo;
  @override
  Future<Either<Failure, void>> call({required String p}) async {
    return await _repo.deleteTask(index: p);
  }
}
