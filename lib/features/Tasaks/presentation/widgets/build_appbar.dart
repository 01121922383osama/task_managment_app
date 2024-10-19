import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/tasks_bloc.dart';

import '../../../../core/constants/app_strings.dart';

class BuildAppbar extends StatelessWidget implements PreferredSizeWidget {
  const BuildAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        AppStrings.goodMornig,
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: IconButton(
              onPressed: () {
                context.read<TasksBloc>().add(const SyncTasksEvent());
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
