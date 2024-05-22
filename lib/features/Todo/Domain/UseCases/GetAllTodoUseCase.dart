// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/Todos.dart';
import '../repositries/TodosRepositries.dart';

class GetAllTodosUseCase {
  final TodosRepositries todosRepositries;
  GetAllTodosUseCase({
    required this.todosRepositries,
  });

  Future<Either<Failures, List<Todo>>> call() async {
    return todosRepositries.getallTodos();
  }
}
