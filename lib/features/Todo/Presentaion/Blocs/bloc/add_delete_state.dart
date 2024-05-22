// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_delete_bloc.dart';

@immutable
sealed class AddDeleteState {}

final class AddDeleteInitial extends AddDeleteState {}

class SuccessfullState extends AddDeleteState {}

class ErrorState extends AddDeleteState {
  final String msg;
  ErrorState({
    required this.msg,
  });
}
