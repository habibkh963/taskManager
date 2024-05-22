part of 'LogInBloc.dart';

@immutable
sealed class LoginMainEvent {}

class LogInEvent extends LoginMainEvent {
  final String email;
  final String password;

  LogInEvent(this.email, this.password);
}

class InitialEvent extends LoginMainEvent {
  InitialEvent();
}
