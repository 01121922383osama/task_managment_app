import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/router/app_routs.dart';
import 'config/router/name_routs.dart';
import 'core/constants/app_strings.dart';
import 'features/Tasaks/presentation/bloc/tasks_bloc.dart';
import 'features/Tasaks/presentation/widgets/build_nav_task.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const TaskManagementApp());
}

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => IndexCubit(),
        ),
        BlocProvider(
          create: (context) => di.locator<TasksBloc>()
            ..add(const SyncTasksEvent())
            ..add(const GetAllTasksEvent()),
        ),
      ],
      child: const ScreenUtilInit(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          initialRoute: NameRouts.splash,
          onGenerateRoute: AppRouts.onGenerateRoute,
          onUnknownRoute: AppRouts.onUnknownRoute,
        ),
      ),
    );
  }
}
