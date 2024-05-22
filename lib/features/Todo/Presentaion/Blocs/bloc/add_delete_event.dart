part of 'add_delete_bloc.dart';

@immutable
sealed class AddDeleteEvent {}

class AddEvent extends AddDeleteEvent {
  final Todo todo;

  AddEvent(this.todo);
}

class DeleteEvent extends AddDeleteEvent {
  final int id;

  DeleteEvent(this.id);
}

class AddTodoEvent extends AddDeleteEvent {
  final Todo todo;

  AddTodoEvent(this.todo);
}
