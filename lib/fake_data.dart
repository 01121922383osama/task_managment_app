import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'core/extension/screen_utils.dart';
import 'features/Tasaks/data/models/task_models.dart';

List<TaskModels> allData = [
  TaskModels(
    id: '1',
    title: 'Task 1',
    createdAt: DateTime.now(),
    isCompleted: false,
  ),
  TaskModels(
    id: '2',
    title: 'Task 2',
    createdAt: DateTime.now(),
    isCompleted: false,
  ),
  TaskModels(
    id: '3',
    title: 'Task 3',
    createdAt: DateTime.now(),
    isCompleted: false,
  ),
  TaskModels(
    id: '4',
    title: 'Task 4',
    createdAt: DateTime.now(),
    isCompleted: false,
  ),
  TaskModels(
    id: '5',
    title: 'Task 5',
    createdAt: DateTime.now(),
    isCompleted: false,
  ),
  TaskModels(
    id: '6',
    title: 'Task 6',
    createdAt: DateTime.now(),
    isCompleted: false,
  ),
];

List<TaskModels> doneData = [
  TaskModels(
    id: '1',
    title: 'Task 1',
    createdAt: DateTime.now(),
    isCompleted: true,
  ),
  TaskModels(
    id: '2',
    title: 'Task 2',
    createdAt: DateTime.now(),
    isCompleted: true,
  ),
  TaskModels(
    id: '3',
    title: 'Task 3',
    createdAt: DateTime.now(),
    isCompleted: true,
  ),
];

List<TaskModels> undoneData = [
  TaskModels(
    id: '4',
    title: 'Task 4',
    createdAt: DateTime.now(),
    isCompleted: false,
  ),
  TaskModels(
    id: '5',
    title: 'Task 5',
    createdAt: DateTime.now(),
    isCompleted: false,
  ),
];

class FakeTaskData extends StatelessWidget {
  const FakeTaskData({super.key});

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
      itemCount: allData.length,
      itemBuilder: (context, index) {
        return Skeletonizer(
          enabled: true,
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
                  blurRadius: 5,
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
                allData[index].title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                'Due Date: ${DateFormat('EEE. dd/MM/yyyy').format(allData[index].createdAt)}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Checkbox.adaptive(
                value: allData[index].isCompleted,
                onChanged: (value) {},
              ),
            ),
          ),
        );
      },
    );
  }
}
