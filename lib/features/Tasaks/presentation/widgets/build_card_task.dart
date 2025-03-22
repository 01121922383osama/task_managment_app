import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../bloc/tasks_bloc.dart';

import '../../../../core/extension/screen_utils.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../data/models/task_models.dart';

class BuildCardTask extends StatefulWidget {
  final List<TaskModels> taskModels;
  const BuildCardTask({
    super.key,
    required this.taskModels,
  });

  @override
  State<BuildCardTask> createState() => _BuildCardTaskState();
}

class _BuildCardTaskState extends State<BuildCardTask> {
  final Map<int, TextEditingController> _controllers = {};
  final Map<int, TextEditingController> _dateControllers = {};

  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    _dateControllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

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
      itemCount: widget.taskModels.length,
      itemBuilder: (context, index) {
        if (!_controllers.containsKey(index)) {
          _controllers[index] =
              TextEditingController(text: widget.taskModels[index].title);
          _dateControllers[index] = TextEditingController(
            text: DateFormat('EEE. dd/MM/yyyy')
                .format(widget.taskModels[index].createdAt),
          );
        }

        return Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            dragDismissible: false,
            children: [
              SlidableAction(
                onPressed: (context) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Edit Task'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextfield(
                              hintText: 'Task Title',
                              controller: _controllers[index],
                            ),
                            const SizedBox(height: 15),
                            GestureDetector(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate:
                                      widget.taskModels[index].createdAt,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(DateTime.now().year + 10),
                                );
                                _dateControllers[index]?.text =
                                    DateFormat('EEE. dd/MM/yyyy')
                                        .format(pickedDate!);
                              },
                              child: AbsorbPointer(
                                child: CustomTextfield(
                                  hintText:
                                      'Due Date: ${_dateControllers[index]?.text}',
                                  controller: _dateControllers[index],
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            CustomIconButton(
                              onPressed: () {
                                context.read<TasksBloc>().add(UpdateTaskEvent(
                                      task: widget.taskModels[index].copyWith(
                                        title: _controllers[index]?.text.trim(),
                                        createdAt: DateFormat('EEE. dd/MM/yyyy')
                                            .parse(
                                                _dateControllers[index]?.text ??
                                                    ''),
                                      ),
                                    ));
                                Navigator.pop(context);
                              },
                              buttomColor: Colors.green,
                              textButton: 'Update',
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                borderRadius: BorderRadius.circular(15),
                label: 'Edit',
              ),
              SlidableAction(
                onPressed: (context) {
                  context
                      .read<TasksBloc>()
                      .add(DeleteTaskEvent(index: widget.taskModels[index].id));
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                borderRadius: BorderRadius.circular(15),
              ),
            ],
          ),
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
                widget.taskModels[index].title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                'Due Date: ${DateFormat('EEE. dd/MM/yyyy').format(widget.taskModels[index].createdAt)}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Checkbox.adaptive(
                value: widget.taskModels[index].isCompleted,
                onChanged: (value) {
                  context.read<TasksBloc>().add(
                        EditTaskEvent(
                          task: widget.taskModels[index].copyWith(
                            isCompleted: value,
                          ),
                        ),
                      );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
