// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:http/http.dart' as http;
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:taskmanager/InjectionContainer.dart';
import 'package:taskmanager/core/constants.dart';
import 'package:taskmanager/features/Login/Data/DataProviders/AuthDataProvider.dart';
import 'package:taskmanager/features/Login/Data/DataProviders/UserLocalDataSourceImpl.dart';
import 'package:taskmanager/features/Login/Data/model/UserModel.dart';
import 'package:taskmanager/features/Login/Domain/entites/User.dart';
import 'package:taskmanager/features/Todo/Data/DataProviders/LocalDataBase.dart';
import 'package:taskmanager/features/Todo/Domain/UseCases/GetAllTodoUseCase.dart';
import 'package:taskmanager/features/Todo/Presentaion/Blocs/bloc/get_all_todos_bloc.dart';

import 'package:taskmanager/main.dart';

void main() {
  // dependecy_init();
  // group('Bloc Success ', () {
  //   blocTest<GetAllTodosBloc, GetAllTodosState>(
  //     'When data is empty',
  //     build: () => GetAllTodosBloc(dependcy<GetAllTodosUseCase>()),
  //     wait: const Duration(milliseconds: 500),
  //     expect: () => [GetAllTodoLoading(), GetAllTodosLoaded(todo: const [])],
  //   );
  // });

  test('remoteLogIntest', () async {
    //Arrange
    AuthDataProvider database = AuthDataProviderWithHttp();
    String firstName = "kminchelle";

    String pass = "0lelplR";
    User user = await database.login(firstName, pass);

    //Assert
    expect(user.token != null, true);
  });
  test('LocalLogIntest', () async {
    //Arrange
    WidgetsFlutterBinding.ensureInitialized();
    TodosLocalDataSource.instance.initializeDb();
    databaseFactory = databaseFactoryFfi;
    TodosLocalDataSource db = TodosLocalDataSource();
    AuthDataProvider database = AuthDataProviderWithHttp();
    UserLocalDataSource localDatabase =
        UserLocalDataSourceImpl(localDataSource: db);
    String firstName = "kminchelle";
    String pass = "0lelplR";

    User user = await database.login(firstName, pass);
    UserModel? userLocal = await localDatabase.getLocalUser();
    //Assert
    expect(user.token != null, true);
    expect(userLocal != null, true);
  });
}
