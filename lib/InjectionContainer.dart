import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:taskmanager/features/Login/Data/repositryImplemetaion/UserReposImplementaion.dart';
import 'package:taskmanager/features/Login/Domain/UseCases/GetUser.dart';
import 'package:taskmanager/features/Login/Domain/UseCases/LoginUseCase.dart';
import 'package:taskmanager/features/Login/Domain/repositries/UserRepositries.dart';
import 'package:taskmanager/features/Login/presentaion/bloc/GetUserBloc.dart';
import 'package:taskmanager/features/Login/presentaion/bloc/LogInBloc.dart';
import 'package:taskmanager/features/Todo/Domain/UseCases/updateTodoUseCase.dart';
import 'package:taskmanager/features/Todo/Presentaion/Blocs/Cubits/paginationCubit/pagination_cubit.dart';

import 'core/network/network_info.dart';
import 'features/Login/Data/DataProviders/AuthDataProvider.dart';
import 'features/Login/Data/DataProviders/UserLocalDataSourceImpl.dart';
import 'features/Todo/Data/DataProviders/LocalDataBase.dart';
import 'features/Todo/Data/DataProviders/TodosDataProviders.dart';
import 'features/Todo/Data/DataProviders/TodosLocalDataProvider.dart';
import 'features/Todo/Data/repositryImplemetaion/TodoReposImplementaion.dart';
import 'features/Todo/Domain/UseCases/AddTodoUseCase.dart';
import 'features/Todo/Domain/UseCases/DeleteTodoUsecase.dart';
import 'features/Todo/Domain/UseCases/GetAllTodoUseCase.dart';
import 'features/Todo/Domain/repositries/TodosRepositries.dart';
import 'features/Todo/Presentaion/Blocs/Cubits/cubit/show_hide_pass_word_cubit.dart';
import 'features/Todo/Presentaion/Blocs/bloc/add_delete_bloc.dart';
import 'features/Todo/Presentaion/Blocs/bloc/get_all_todos_bloc.dart';

final GetIt dependcy = GetIt.instance;

Future<void> dependecy_init() async {
//Blocs & Cubit
  dependcy.registerFactory(() => GetAllTodosBloc(dependcy()));
  dependcy.registerFactory(() => AddDeleteBloc(dependcy(), dependcy()));
  dependcy.registerFactory(() => LogInBloc(dependcy()));
  dependcy.registerFactory(() => GetUserBloc(
        dependcy(),
      ));
  dependcy.registerFactory(() => ShowHidePassWordCubit());

  //Use Cases
  dependcy.registerLazySingleton(
      () => GetAllTodosUseCase(todosRepositries: dependcy()));
  dependcy.registerLazySingleton(
      () => DeleteTodoUseCase(todosRepositries: dependcy()));
  dependcy.registerLazySingleton(
      () => AddTodoUseCase(todosRepositries: dependcy()));
  dependcy.registerLazySingleton(
      () => UpdateTodoUseCase(todosRepositries: dependcy()));
  dependcy
      .registerLazySingleton(() => LogInUseCase(userRepositries: dependcy()));
  dependcy
      .registerLazySingleton(() => GetUserUseCase(userRepositries: dependcy()));
  //repositry
  dependcy.registerLazySingleton<TodosRepositries>(() =>
      TodosReposImplementaion(
          todosDataProviders: dependcy(),
          networkInfo: dependcy(),
          todoLocalDataSource: dependcy()));
  dependcy.registerLazySingleton<UserRepositries>(() => UserReposImplementaion(
      authDataProvider: dependcy(),
      networkInfo: dependcy(),
      userLocalDataSource: dependcy()));
  //Data Providers
  dependcy.registerLazySingleton<TodosDataProviders>(() => TodoDataWithHttp());
  dependcy.registerLazySingleton<TodoLocalDataSource>(
      () => TodoLocalDataSourceImpl(localDataSource: dependcy()));
  dependcy.registerLazySingleton<AuthDataProvider>(
      () => AuthDataProviderWithHttp());
  dependcy.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(localDataSource: dependcy()));
  //global
  dependcy.registerLazySingleton<TodosLocalDataSource>(
      () => TodosLocalDataSource());

  dependcy
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(dependcy()));

  /// core
  dependcy.registerLazySingleton(() => http.Client());
  dependcy.registerLazySingleton(() => InternetConnectionChecker());
}
