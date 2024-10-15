import 'package:firedart/firedart.dart';
import 'package:task_app/config/error/server_exception.dart';
import 'package:task_app/features/TaskManagement/data/models/task_models.dart';

abstract interface class TaskRemoteDataSource {
  Future<TaskModels> addTask({required TaskModels task});
  Future<TaskModels> editTask({required TaskModels task});
  Future<void> deleteTask({required String index});
  Future<List<TaskModels>> getAllTask();
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final Firestore _firestore;

  TaskRemoteDataSourceImpl({
    required Firestore firestore,
  }) : _firestore = firestore;
  @override
  Future<TaskModels> addTask({required TaskModels task}) async {
    try {
      await _firestore.collection('tasks').add(task.toMap());
      return task;
    } catch (e) {
      throw ServerException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> deleteTask({required String index}) async {
    try {
      final task = await _firestore
          .collection('tasks')
          .where(
            'id',
            isEqualTo: index,
          )
          .get();
      await _firestore.collection('tasks').document(task.first.id).delete();
    } catch (e) {
      throw ServerException(errorMessage: e.toString());
    }
  }

  @override
  Future<TaskModels> editTask({required TaskModels task}) async {
    try {
      await _firestore
          .collection('tasks')
          .document(task.id)
          .update(task.toMap());
      return task;
    } catch (e) {
      throw ServerException(errorMessage: e.toString());
    }
  }

  @override
  Future<List<TaskModels>> getAllTask() async {
    try {
      final data = await _firestore.collection('tasks').get();
      final List<TaskModels> list =
          data.map((e) => TaskModels.fromMap(e.map)).toList();
      return list;
    } catch (e) {
      throw ServerException(errorMessage: e.toString());
    }
  }
}
