// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// import '../../../../Domain/entites/Todos.dart';

// part 'pagination_state.dart';

// class PaginationCubit extends Cubit<PaginationState> {
//   PaginationCubit() : super(PaginationInitial());
//   int index = 1;
//   changeIndex(int i, List todo) {
//     emit(PaginationInitial());
//     List<Todo> temp = [];
//     if (index == 0) {
//     temp=  todo.getRange<Todo>(0, todo.length <= 10 ? todo.length : 10).toList();
//     } else {
//      temp= todo.getRange(10 * index,
//           todo.length <= 10 * index ? todo.length : 10 * (index + 1));
//     }

//     index = i;
//     emit(PageChanged());
//   }
// }
