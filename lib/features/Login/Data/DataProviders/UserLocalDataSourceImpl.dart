import 'package:dartz/dartz.dart';
import 'package:taskmanager/core/errors/Exceptions.dart';
import 'package:taskmanager/features/Todo/Data/DataProviders/LocalDataBase.dart';

import '../model/UserModel.dart';

abstract class UserLocalDataSource {
  Future<Unit> save(UserModel user);
  Future<UserModel?> getLocalUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final TodosLocalDataSource localDataSource;

  UserLocalDataSourceImpl({required this.localDataSource});
  @override
  Future<Unit> save(UserModel userModel) async {
    final db = await localDataSource.dbe;

    await db!.insert(tableUser, userModel.toJson());

    return Future.value(unit);
  }

  @override
  Future<UserModel> getLocalUser() async {
    final db = await localDataSource.dbe;
    final res = await db!.rawQuery("SELECT * FROM $tableUser");
    print('##################');
    print(res);
    print('##################');
    if (res != null) {
      UserModel? jsonToUserModels =
          (res.isNotEmpty) ? UserModel.fromJson(res[0]) : null;

      if (jsonToUserModels != null) {
        return Future.value(jsonToUserModels);
      } else {
        throw ServicesException();
      }
    } else {
      throw ServicesException();
    }
  }
}
