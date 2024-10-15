import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:task_app/core/extension/screen_utils.dart';
import 'package:task_app/features/TaskManagement/data/models/task_models.dart';
import 'package:task_app/features/TaskManagement/presentation/manager/taskManage/taskmanagement_cubit.dart';

class BuildCardTask extends StatelessWidget {
  final List<TaskModels> taskModels;
  const BuildCardTask({
    super.key,
    required this.taskModels,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: calculateCrossAxisCount(
          context,
          m: 1,
          t: 2,
          d: 3,
        ),
        childAspectRatio: calculateChildAspectRatio(
          context,
          m: 2.7.w,
          t: 1.3.w,
          d: 1.w,
        ),
      ),
      itemCount: taskModels.length,
      itemBuilder: (context, index) {
        return Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            dragDismissible: false,
            children: [
              SlidableAction(
                onPressed: (context) {},
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                borderRadius: BorderRadius.circular(15),
                label: 'Edit',
              ),
              SlidableAction(
                onPressed: (context) {
                  String taskId = taskModels[index].id;
                  taskModels.removeAt(index);
                  context.read<TaskmanagementCubit>().deleteTask(index: taskId);
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                borderRadius: BorderRadius.circular(15),
              ),
            ],
          ),
          key: UniqueKey(),
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  offset: const Offset(0, 3),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
              color: Colors.white,
              gradient: const LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ListTile(
              title: Text(
                taskModels[index].title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                'Due Date: ${DateFormat('EEE. dd/MM/yyyy').format(taskModels[index].createdAt)}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Checkbox.adaptive(
                value: taskModels[index].isCompleted,
                onChanged: (value) {},
              ),
            ),
          ),
        );
      },
    );
  }
}
