import 'package:dartz/dartz.dart';

import '../../../../core/errors/Exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../Todo/Data/DataProviders/TodosLocalDataProvider.dart';
import '../../Domain/entites/User.dart';
import '../../Domain/repositries/UserRepositries.dart';
import '../DataProviders/AuthDataProvider.dart';
import '../DataProviders/UserLocalDataSourceImpl.dart';
import '../model/UserModel.dart';

class UserReposImplementaion extends UserRepositries {
  final AuthDataProvider authDataProvider;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;
  UserReposImplementaion({
    required this.authDataProvider,
    required this.networkInfo,
    required this.userLocalDataSource,
  });
  @override
  Future<Either<Failures, User>> getUser() async {
    try {
      UserModel? user = await userLocalDataSource.getLocalUser();
      if (user != null) {
        return Right(user);
      } else {
        throw ServicesException();
      }
    } on ServicesException {
      return Left(ServiceFailure());
    }
  }

  @override
  Future<Either<Failures, Unit>> login(String userName, String password) async {
    try {
      UserModel user = await authDataProvider.login(userName, password);
      await userLocalDataSource.save(user);
      return Right(unit);
    } on ServicesException {
      return Left(ServiceFailure());
    }
  }
}
