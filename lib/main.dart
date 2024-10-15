import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_app/config/app_routs.dart';
import 'package:task_app/config/router/name_routs.dart';
import 'package:task_app/core/constants/app_strings.dart';
import 'package:task_app/features/TaskManagement/presentation/manager/taskManage/taskmanagement_cubit.dart';
import 'package:task_app/injection.dart' as di;

import 'features/TaskManagement/presentation/widgets/build_nav_task.dart';

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
          create: (context) => di.locator<TaskmanagementCubit>()..getAllTask(),
        ),
        // BlocProvider(
        //   create: (context) => di.locator<GetAllTaskCubit>()..getAllTask(),
        // ),
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
