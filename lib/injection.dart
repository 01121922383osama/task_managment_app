import 'package:firedart/firedart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'core/network/network_info.dart';
import 'features/Tasaks/presentation/bloc/tasks_bloc.dart';

import 'core/constants/app_strings.dart';
import 'features/Tasaks/data/datasources/remote/task_remote_data_source.dart';
import 'features/Tasaks/data/models/task_models.dart';
import 'features/Tasaks/data/repositories/task_repo_impl.dart';
import 'features/Tasaks/domain/repositories/task_repo.dart';
import 'features/Tasaks/domain/usecases/add_task_usecase.dart';
import 'features/Tasaks/domain/usecases/delete_task_usecase.dart';
import 'features/Tasaks/domain/usecases/edit_task_usecase.dart';
import 'features/Tasaks/domain/usecases/get_all_task_usecase.dart';

final locator = GetIt.instance;

Future<void> init() async {
  await ScreenUtil.ensureScreenSize();
  final initFirestor = Firestore.initialize('task-app-ddfe9');
  // hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelsAdapter());

  await Hive.openBox<TaskModels>(AppStrings.hiveTaskKey);
  await Hive.openBox<TaskModels>(AppStrings.unsyncedTasks);
  await Hive.openBox<String>(AppStrings.deletedTaskIds);

  // cubit

  locator.registerFactory(() => TasksBloc(
        addTaskUsecase: locator.call(),
        deleteTaskUsecase: locator.call(),
        editTaskUsecase: locator.call(),
        allTaskUsecase: locator.call(),
      ));
  // usecase
  locator.registerLazySingleton(() => AddTaskUsecase(repo: locator.call()));
  locator.registerLazySingleton(() => DeleteTaskUsecase(repo: locator.call()));
  locator.registerLazySingleton(() => EditTaskUsecase(repo: locator.call()));
  locator
      .registerLazySingleton(() => GetAllTaskUsecase(taskRepo: locator.call()));
  // repository
  locator.registerLazySingleton<TaskRepo>(
      () => TaskRepoImpl(dataSource: locator.call()));
  // data sources
  locator.registerLazySingleton<TaskRemoteDataSource>(() =>
      TaskRemoteDataSourceImpl(
          networkInfo: locator.call(), firestore: locator.call()));
  // other
  locator.registerLazySingleton<Firestore>(() => initFirestor);
  locator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: locator.call()));

  locator.registerLazySingleton(() => InternetConnection());
  // check the internet connection
  final taskRemoteDataSource = locator.get<TaskRemoteDataSource>();
  if (await taskRemoteDataSource.isNetworkAvailable()) {
    await taskRemoteDataSource.syncTasks();
  }
}
