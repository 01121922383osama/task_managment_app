import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_strings.dart';
import '../bloc/tasks_bloc.dart';
import '../widgets/build_appbar.dart';
import '../widgets/build_card_task.dart';
import '../widgets/build_nav_task.dart';
import '../widgets/show_bottom_sheet.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildAppbar(),
      body: CustomScrollView(
        slivers: [
          const BuildNavTask(),
          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, task) {
              if (task.tasks.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      AppStrings.noData,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }
              return BlocBuilder<IndexCubit, int>(
                builder: (context, state) {
                  if (state == 0) {
                    return BuildCardTask(taskModels: task.tasks);
                  }
                  if (state == 1) {
                    return BuildCardTask(
                      taskModels: task.tasks.where((element) {
                        return !element.isCompleted;
                      }).toList(),
                    );
                  }

                  return BuildCardTask(
                    taskModels: task.tasks.where(
                      (element) {
                        return element.isCompleted;
                      },
                    ).toList(),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          onPressed: () {
            showBottomSheet(
              context: context,
              builder: (context) {
                return const ShowBottomSheetWidget();
              },
            );
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add, color: Colors.white),
        );
      }),
    );
  }
}
