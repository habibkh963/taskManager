// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_all_todos_bloc.dart';

@immutable
sealed class GetAllTodosState {}

final class GetAllTodoLoading extends GetAllTodosState {}

class GetAllTodosLoaded extends GetAllTodosState {
  final List<Todo> todo;
  GetAllTodosLoaded({
    required this.todo,
  });
}

class LoadingErrorState extends GetAllTodosState {
  final String msg;
  LoadingErrorState({
    required this.msg,
  });
}
