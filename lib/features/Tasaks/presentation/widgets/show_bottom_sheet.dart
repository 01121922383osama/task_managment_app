import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../core/widgets/show_toast_widget.dart';
import '../../data/models/task_models.dart';
import '../bloc/tasks_bloc.dart';

class ShowBottomSheetWidget extends StatefulWidget {
  const ShowBottomSheetWidget({super.key});

  @override
  State<ShowBottomSheetWidget> createState() => _ShowBottomSheetWidgetState();
}

class _ShowBottomSheetWidgetState extends State<ShowBottomSheetWidget> {
  DateTime dueDate = DateTime.now();
  final title = TextEditingController();

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
            controller: title,
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
          CustomIconButton(
            onPressed: () {
              if (title.text.isNotEmpty) {
                final task = TaskModels(
                  id: const Uuid().v4(),
                  title: title.text.trim(),
                  createdAt: dueDate,
                );
                context.read<TasksBloc>().add(AddTaskEvent(task: task));
                title.clear();
                Navigator.of(context).pop();
              } else {
                customShowTost(
                  context: context,
                  message: 'Enter Task Title',
                  color: Colors.red,
                );
              }
            },
            textButton: 'Save',
            textColor: Colors.white,
            buttomColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
