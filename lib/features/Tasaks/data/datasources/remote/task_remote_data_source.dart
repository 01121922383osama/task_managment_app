import 'package:firedart/firedart.dart';
import 'package:hive/hive.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/network/network_info.dart';

import '../../models/task_models.dart';

abstract class TaskRemoteDataSource {
  Future<TaskModels> addTask({required TaskModels task});
  Future<TaskModels> updateTask({required TaskModels task});
  Future<TaskModels> editTask({required TaskModels task});
  Future<void> deleteTask({required String id});
  Future<List<TaskModels>> getAllTasks();
  Future<void> syncTasks();
  Future<bool> isNetworkAvailable();
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final NetworkInfo _networkInfo;
  final Firestore _firestore;

  final Box<TaskModels> _taskBox;
  final Box<TaskModels> _unsyncedTasksBox;
  final Box<String> _deletedTaskIdsBox;

  List<TaskModels> _unsyncedTasks = [];
  List<String> _deletedTaskIds = [];

  TaskRemoteDataSourceImpl({
    required NetworkInfo networkInfo,
    required Firestore firestore,
  })  : _networkInfo = networkInfo,
        _firestore = firestore,
        _taskBox = Hive.box<TaskModels>(AppStrings.hiveTaskKey),
        _unsyncedTasksBox = Hive.box<TaskModels>(AppStrings.unsyncedTasks),
        _deletedTaskIdsBox = Hive.box<String>(AppStrings.deletedTaskIds) {
    _unsyncedTasks = _unsyncedTasksBox.values.toList();
    _deletedTaskIds = _deletedTaskIdsBox.values.toList();
  }

  @override
  Future<TaskModels> addTask({required TaskModels task}) async {
    await _taskBox.put(task.id, task);
    _unsyncedTasks.add(task);
    await _unsyncedTasksBox.put(task.id, task);
    await _syncIfOnline();
    return task;
  }

  @override
  Future<TaskModels> updateTask({required TaskModels task}) async {
    await _taskBox.put(task.id, task);
    _unsyncedTasks.add(task);
    await _unsyncedTasksBox.put(task.id, task);
    await _syncIfOnline();
    return task;
  }

  @override
  Future<TaskModels> editTask({required TaskModels task}) async {
    await _taskBox.put(task.id, task);
    _unsyncedTasks.add(task);
    await _unsyncedTasksBox.put(task.id, task);
    await _syncIfOnline();
    return task;
  }

  @override
  Future<void> deleteTask({required String id}) async {
    await _taskBox.delete(id);
    _deletedTaskIds.add(id);
    await _deletedTaskIdsBox.put(id, id);
    await _syncIfOnline();
  }

  @override
  Future<List<TaskModels>> getAllTasks() async {
    List<TaskModels> localTasks = _taskBox.values.toList();

    if (await isNetworkAvailable()) {
      await _syncFromRemote();
    }

    return localTasks;
  }

  @override
  Future<void> syncTasks() async {
    await _syncToRemote();
  }

  Future<void> _syncIfOnline() async {
    if (await isNetworkAvailable()) {
      await syncTasks();
    }
  }

  Future<void> _syncToRemote() async {
    for (TaskModels task in List.from(_unsyncedTasks)) {
      await _firestore
          .collection(AppStrings.task)
          .document(task.id)
          .set(task.toMap());
      _unsyncedTasks.remove(task);
      await _unsyncedTasksBox.delete(task.id);
    }

    for (String id in List.from(_deletedTaskIds)) {
      await _firestore.collection(AppStrings.task).document(id).delete();
      _deletedTaskIds.remove(id);
      await _deletedTaskIdsBox.delete(id);
    }
  }

  Future<void> _syncFromRemote() async {
    final documents = await _firestore.collection(AppStrings.task).get();

    for (final document in documents) {
      final taskData = document.map;
      final task = TaskModels.fromMap(taskData);
      await _taskBox.put(task.id, task);
    }
  }

  @override
  Future<bool> isNetworkAvailable() async {
    return await _networkInfo.isConnected;
  }
}
