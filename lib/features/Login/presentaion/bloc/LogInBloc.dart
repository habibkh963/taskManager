import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taskmanager/features/Login/Domain/UseCases/LoginUseCase.dart';

import '../../../../../core/constants.dart';

part 'LogInEvent.dart';
part 'LoginStates.dart';

class LogInBloc extends Bloc<LoginMainEvent, LogInMainState> {
  /// The line `final AddPostsUseCase addPostsUseCase;` in the `AddDeleteBloc` class is declaring a
  /// final variable `addPostsUseCase` of type `AddPostsUseCase`. This variable is used to hold an
  /// instance of the `AddPostsUseCase` class, which is likely a use case class responsible for adding
  /// posts in the application's business logic layer.
  final LogInUseCase logInUseCase;

  LogInBloc(
    this.logInUseCase,
  ) : super(LogInMainStateInitial()) {
    on<InitialEvent>((event, emit) async {
      emit(LogInMainStateLoading());
    });
    on<LogInEvent>((event, emit) async {
      print("object");
      emit(LogInMainStateLoading());
      var res = await logInUseCase.call(event.email, event.password);
      res.fold((l) => emit(LogInErrorState(msg: mapFailuresToStrings(l))),
          (r) => emit(LogInSuccessfullState()));
    });
  }
}
