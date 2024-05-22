import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/Todos.dart';

abstract class TodosRepositries {
  Future<Either<Failures, List<Todo>>> getallTodos();
  Future<Either<Failures, Unit>> addTodo(Todo todo);
  Future<Either<Failures, Unit>> deleteTodo(int id);
  Future<Either<Failures, Unit>> updateTodo(Todo todo);
}
