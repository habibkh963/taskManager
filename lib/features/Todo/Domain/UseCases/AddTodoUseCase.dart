// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/Todos.dart';
import '../repositries/TodosRepositries.dart';

class AddTodoUseCase {
  final TodosRepositries todosRepositries;
  AddTodoUseCase({
    required this.todosRepositries,
  });
  Future<Either<Failures, Unit>> call(Todo todo) {
    return todosRepositries.addTodo(todo);
  }
}
