import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/constants/app_strings.dart';
import 'package:task_app/core/widgets/show_toast_widget.dart';
import 'package:task_app/fake_data.dart';
import 'package:task_app/features/TaskManagement/presentation/manager/taskManage/taskmanagement_cubit.dart';
import 'package:task_app/features/TaskManagement/presentation/widgets/build_card_task.dart';
import 'package:task_app/features/TaskManagement/presentation/widgets/show_bottom_sheet.dart';

import '../widgets/build_nav_task.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          AppStrings.goodMornig,
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const BuildNavTask(),
          BlocBuilder<IndexCubit, int>(
            builder: (context, state) {
              if (state == 0) {
                return BlocConsumer<TaskmanagementCubit, TaskmanagementState>(
                  listener: (context, state) {
                    if (state is TaskmanagementFailure) {
                      customShowTost(
                        context: context,
                        message: state.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is TaskmanagementSuccess && state.tasks != null) {
                      return BuildCardTask(taskModels: state.tasks!);
                    }
                    return const FakeTaskData();
                  },
                );
              }
              if (state == 1) {
                return BuildCardTask(taskModels: undoneData);
              }
              if (state == 2) {
                return BuildCardTask(taskModels: doneData);
              }
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text('No Data Yet'),
                ),
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
