// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'GetUserBloc.dart';

@immutable
sealed class GetUserState {}

class GetUserStateLoaded extends GetUserState {
  GetUserStateLoaded();
}

class UserLoadingErrorState extends GetUserState {
  final String msg;
  UserLoadingErrorState({
    required this.msg,
  });
}
