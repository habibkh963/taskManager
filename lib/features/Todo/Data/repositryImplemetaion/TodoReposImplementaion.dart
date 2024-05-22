import 'package:dartz/dartz.dart';

import '../../../../core/errors/Exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../Domain/entites/Todos.dart';
import '../../Domain/repositries/TodosRepositries.dart';
import '../DataProviders/TodosDataProviders.dart';
import '../DataProviders/TodosLocalDataProvider.dart';
import '../model/TodosModel.dart';

class TodosReposImplementaion extends TodosRepositries {
  final TodosDataProviders todosDataProviders;
  final TodoLocalDataSource todoLocalDataSource;
  final NetworkInfo networkInfo;
  TodosReposImplementaion({
    required this.todosDataProviders,
    required this.networkInfo,
    required this.todoLocalDataSource,
  });
  @override
  Future<Either<Failures, List<Todo>>> getallTodos() async {
    if (await networkInfo.isConnected) {
      try {
        List<TodosModel> todos = await todosDataProviders.getAllTodos();
        await todoLocalDataSource.deleteLocalTodos();
        await todoLocalDataSource.saveTodos(todos);
        return Right(todos);
      } catch (e) {
        List<TodosModel> todos = await todoLocalDataSource.getLocalTodo();
        return Right(todos);
      }
    } else {
      try {
        List<TodosModel> todos = await todoLocalDataSource.getLocalTodo();
        return Right(todos);
      } on ServicesException {
        return Left(ServiceFailure());
      }
    }
  }

  @override
  Future<Either<Failures, Unit>> addTodo(Todo todo) async {
    try {
      await todosDataProviders.addTodo(todo);
      return Right(unit);
    } on ServicesException {
      return Left(ServiceFailure());
    }
  }

  @override
  Future<Either<Failures, Unit>> deleteTodo(int id) async {
    try {
      await todosDataProviders.deleteTodo(id);
      return Right(unit);
    } on ServicesException {
      return Left(ServiceFailure());
    }
  }

  @override
  Future<Either<Failures, Unit>> updateTodo(Todo todo) async {
    try {
      await todosDataProviders.addTodo(todo);
      return Right(unit);
    } on ServicesException {
      return Left(ServiceFailure());
    }
  }
}
