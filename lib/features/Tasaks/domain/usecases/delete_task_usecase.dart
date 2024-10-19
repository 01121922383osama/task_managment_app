import 'package:fpdart/fpdart.dart';
import '../../../../config/error/error.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/task_repo.dart';

class DeleteTaskUsecase implements Usecase<void, String> {
  final TaskRepo _repo;

  DeleteTaskUsecase({required TaskRepo repo}) : _repo = repo;
  @override
  Future<Either<Failure, void>> call({required String p}) async {
    return await _repo.deleteTask(index: p);
  }
}
