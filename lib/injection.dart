import 'package:firedart/firedart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task_app/core/constants/app_strings.dart';
import 'package:task_app/features/TaskManagement/data/datasources/remote/task_remote_data_source.dart';
import 'package:task_app/features/TaskManagement/data/models/task_models.dart';
import 'package:task_app/features/TaskManagement/data/repositories/task_repo_impl.dart';
import 'package:task_app/features/TaskManagement/domain/repositories/task_repo.dart';
import 'package:task_app/features/TaskManagement/domain/usecases/add_task_usecase.dart';
import 'package:task_app/features/TaskManagement/domain/usecases/delete_task_usecase.dart';
import 'package:task_app/features/TaskManagement/domain/usecases/edit_task_usecase.dart';
import 'package:task_app/features/TaskManagement/presentation/manager/taskManage/taskmanagement_cubit.dart';
import 'package:task_app/features/TaskManagement/presentation/manager/task_bloc.dart';

import 'features/TaskManagement/domain/usecases/get_all_task_usecase.dart';

final locator = GetIt.instance;

Future<void> init() async {
  await ScreenUtil.ensureScreenSize();
  final initFirestor = Firestore.initialize('task-app-ddfe9');
  // hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelsAdapter());
  await Hive.openBox<TaskModels>(AppStrings.hiveTaskKey);
  locator.registerFactory(() => TaskBloc(repo: locator.call()));
  // cubit
  locator.registerFactory(() => TaskmanagementCubit(
        addTaskUsecase: locator.call(),
        deleteTaskUsecase: locator.call(),
        editTaskUsecase: locator.call(),
        allTaskUsecase: locator.call(),
      ));
  // locator
  //     .registerFactory(() => GetAllTaskCubit(allTaskUsecase: locator.call()));
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
  locator.registerLazySingleton<TaskRemoteDataSource>(
      () => TaskRemoteDataSourceImpl(firestore: locator.call()));
  // other
  locator.registerLazySingleton<Firestore>(() => initFirestor);
}
