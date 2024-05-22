import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../../../../core/constants.dart';
import '../../Domain/UseCases/GetUser.dart';

part 'GetUserEvents.dart';
part 'GetUserStates.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  final GetUserUseCase getUserUseCase;
  GetUserBloc(this.getUserUseCase) : super(GetUserStateLoaded()) {
    on<GetUserEvent>((event, emit) async {
      var posts = await getUserUseCase.call();
      posts.fold(
          (l) => emit(UserLoadingErrorState(msg: mapFailuresToStrings(l))),
          (r) => emit(GetUserStateLoaded()));
    });
  }
}
