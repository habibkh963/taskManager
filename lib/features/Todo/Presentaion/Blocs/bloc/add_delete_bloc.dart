import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/constants.dart';
import '../../../Domain/UseCases/AddTodoUseCase.dart';
import '../../../Domain/UseCases/DeleteTodoUsecase.dart';
import '../../../Domain/entites/Todos.dart';

part 'add_delete_event.dart';
part 'add_delete_state.dart';

class AddDeleteBloc extends Bloc<AddDeleteEvent, AddDeleteState> {
  /// The line `final AddPostsUseCase addPostsUseCase;` in the `AddDeleteBloc` class is declaring a
  /// final variable `addPostsUseCase` of type `AddPostsUseCase`. This variable is used to hold an
  /// instance of the `AddPostsUseCase` class, which is likely a use case class responsible for adding
  /// posts in the application's business logic layer.
  final AddTodoUseCase addTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  AddDeleteBloc(this.addTodoUseCase, this.deleteTodoUseCase)
      : super(AddDeleteInitial()) {
    on<AddEvent>((event, emit) async {
      emit(AddDeleteInitial());
      var res = await addTodoUseCase.call(event.todo);
      res.fold((l) => emit(ErrorState(msg: mapFailuresToStrings(l))),
          (r) => emit(SuccessfullState()));
    });
    on<DeleteEvent>((event, emit) async {
      emit(AddDeleteInitial());
      var res = await deleteTodoUseCase.call(event.id);
      res.fold((l) => emit(ErrorState(msg: mapFailuresToStrings(l))),
          (r) => emit(SuccessfullState()));
    });
    on<AddTodoEvent>((event, emit) async {
      emit(AddDeleteInitial());
      var res = await addTodoUseCase.call(event.todo);
      res.fold((l) => emit(ErrorState(msg: mapFailuresToStrings(l))),
          (r) => emit(SuccessfullState()));
    });
  }
}
