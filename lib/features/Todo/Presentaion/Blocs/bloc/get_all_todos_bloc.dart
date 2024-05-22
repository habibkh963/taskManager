import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../../../../core/constants.dart';
import '../../../Domain/UseCases/GetAllTodoUseCase.dart';
import '../../../Domain/entites/Todos.dart';

part 'get_all_todos_event.dart';
part 'get_all_todos_state.dart';

class GetAllTodosBloc extends Bloc<GetAllTodosEvent, GetAllTodosState> {
  final GetAllTodosUseCase getAllTodosUseCase;
  GetAllTodosBloc(this.getAllTodosUseCase) : super(GetAllTodoLoading()) {
    on<GetAllTodosEvent>((event, emit) async {
      emit(GetAllTodoLoading());
      var posts = await getAllTodosUseCase.call();
      posts.fold((l) => emit(LoadingErrorState(msg: mapFailuresToStrings(l))),
          (r) => emit(GetAllTodosLoaded(todo: r)));
    });
  }
}
