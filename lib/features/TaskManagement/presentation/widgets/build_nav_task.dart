import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/constants/app_strings.dart';
import 'package:task_app/features/TaskManagement/presentation/widgets/custom_nav_button.dart';

class BuildNavTask extends StatelessWidget {
  const BuildNavTask({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<IndexCubit, int>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CustomNavButton(
                  text: AppStrings.all,
                  state: 0,
                  index: state,
                  onTap: () {
                    BlocProvider.of<IndexCubit>(context).changeIndex(0);
                  },
                ),
                CustomNavButton(
                  text: AppStrings.notdoneData,
                  state: 1,
                  index: state,
                  onTap: () {
                    BlocProvider.of<IndexCubit>(context).changeIndex(1);
                  },
                ),
                CustomNavButton(
                  text: AppStrings.doneData,
                  state: 2,
                  index: state,
                  onTap: () {
                    BlocProvider.of<IndexCubit>(context).changeIndex(2);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class IndexCubit extends Cubit<int> {
  IndexCubit() : super(0);
  void changeIndex(int index) => emit(index);
}
