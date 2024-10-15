import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/extension/navigations.dart';
import 'package:task_app/core/widgets/custom_button_widget.dart';
import 'package:task_app/core/widgets/custom_textfield.dart';
import 'package:task_app/core/widgets/show_toast_widget.dart';
import 'package:task_app/features/TaskManagement/data/models/task_models.dart';
import 'package:task_app/features/TaskManagement/presentation/manager/taskManage/taskmanagement_cubit.dart';
import 'package:uuid/uuid.dart';

class ShowBottomSheetWidget extends StatefulWidget {
  const ShowBottomSheetWidget({super.key});

  @override
  State<ShowBottomSheetWidget> createState() => _ShowBottomSheetWidgetState();
}

class _ShowBottomSheetWidgetState extends State<ShowBottomSheetWidget> {
  DateTime dueDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextfield(
            hintText: 'Task Title',
            controller: context.read<TaskmanagementCubit>().title,
          ),
          const SizedBox(height: 15),
          CustomIconButton(
            onPressed: () {
              showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 10),
              ).then((value) {
                if (value != null) {
                  setState(() {
                    dueDate = value;
                  });
                }
              });
            },
            textButton: 'Due Date',
            textColor: Colors.black,
          ),
          const SizedBox(height: 15),
          BlocListener<TaskmanagementCubit, TaskmanagementState>(
            listener: (context, state) {
              if (state is TaskmanagementFailure) {
                customShowTost(context: context, message: state.error);
              }
              if (state is TaskmanagementSuccess) {
                customShowTost(
                  context: context,
                  message: 'Task Added Successfully',
                  color: Colors.green,
                );
                context.read<TaskmanagementCubit>().title.clear();
                context.pop();
              }
            },
            child: BlocBuilder<TaskmanagementCubit, TaskmanagementState>(
              builder: (context, state) {
                return state is TaskmanagementLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomIconButton(
                        onPressed: () {
                          if (context
                              .read<TaskmanagementCubit>()
                              .title
                              .text
                              .isNotEmpty) {
                            final uuid = const Uuid().v4();
                            final task = TaskModels(
                              id: uuid,
                              title: context
                                  .read<TaskmanagementCubit>()
                                  .title
                                  .text
                                  .trim(),
                              createdAt: dueDate,
                            );
                            log('Adding task: ${task.toMap()}');
                            context
                                .read<TaskmanagementCubit>()
                                .addTask(task: task);
                          } else {
                            customShowTost(
                              context: context,
                              message: 'Title cannot be empty',
                              color: Colors.red,
                            );
                          }
                        },
                        textButton: 'Save',
                        textColor: Colors.white,
                        buttomColor: Colors.green,
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
