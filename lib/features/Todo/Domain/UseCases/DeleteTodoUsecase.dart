import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositries/TodosRepositries.dart';

class DeleteTodoUseCase {
  final TodosRepositries todosRepositries;
  DeleteTodoUseCase({
    required this.todosRepositries,
  });
  Future<Either<Failures, Unit>> call(int id) {
    return todosRepositries.deleteTodo(id);
  }
}
