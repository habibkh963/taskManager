import 'package:dartz/dartz.dart';
import 'package:taskmanager/core/errors/Exceptions.dart';
import 'package:taskmanager/features/Todo/Data/DataProviders/LocalDataBase.dart';

import '../model/TodosModel.dart';

abstract class TodoLocalDataSource {
  Future<List<TodosModel>> getLocalTodo();
  Future<Unit> saveTodos(List<TodosModel> postModels);
  Future<Unit> deleteLocalTodos();
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final TodosLocalDataSource localDataSource;

  TodoLocalDataSourceImpl({required this.localDataSource});
  @override
  Future<Unit> saveTodos(List<TodosModel> todoModels) async {
    final db = await localDataSource.dbe;

    await Future.forEach(todoModels,
        (element) async => await db!.insert(tableTodos, element.toJson()));

    return Future.value(unit);
  }

  @override
  Future<List<TodosModel>> getLocalTodo() async {
    final db = await localDataSource.dbe;
    final res = await db!.rawQuery("SELECT * FROM $tableTodos");

    if (res != null) {
      List<TodosModel> jsonToTodosModels = res
          .map<TodosModel>(
              (jsonTodoModel) => TodosModel.fromJson(jsonTodoModel))
          .toList();
      return Future.value(jsonToTodosModels);
    } else {
      throw ServicesException();
    }
  }

  @override
  Future<Unit> deleteLocalTodos() async {
    try {
      final db = await localDataSource.dbe;
      final res = await db!.delete(tableTodos);

      return Future.value(unit);
    } catch (e) {
      throw ServicesException();
    }
  }
}
