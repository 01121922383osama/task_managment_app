// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:task_app/features/TaskManagement/domain/usecases/get_all_task_usecase.dart';

// import '../../../data/models/task_models.dart';

// part 'get_all_task_state.dart';

// class GetAllTaskCubit extends Cubit<GetAllTaskState> {
//   final GetAllTaskUsecase _allTaskUsecase;
//   GetAllTaskCubit({required GetAllTaskUsecase allTaskUsecase})
//       : _allTaskUsecase = allTaskUsecase,
//         super(const GetAllTaskInitial());

//   Future<void> getAllTask() async {
//     emit(const GetAllTaskLoading());
//     final result = await _allTaskUsecase.call();
//     result.fold(
//       (l) => emit(GetAllTaskFialure(errorMassagel: l.errorMessage)),
//       (r) => emit(GetAllTaskSuccss(tasks: r)),
//     );
//   }
// }
