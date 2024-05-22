import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/Todos.dart';
import '../repositries/TodosRepositries.dart';

class UpdateTodoUseCase {
  final TodosRepositries todosRepositries;
  UpdateTodoUseCase({
    required this.todosRepositries,
  });
  Future<Either<Failures, Unit>> call(Todo todo) {
    return todosRepositries.updateTodo(todo);
  }
}
