// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'LogInBloc.dart';

@immutable
sealed class LogInMainState {}

final class LogInMainStateInitial extends LogInMainState {}

final class LogInMainStateLoading extends LogInMainState {}

class LogInSuccessfullState extends LogInMainState {}

class LogInErrorState extends LogInMainState {
  final String msg;
  LogInErrorState({
    required this.msg,
  });
}
