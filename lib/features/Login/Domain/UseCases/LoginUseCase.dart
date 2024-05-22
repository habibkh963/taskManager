// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/User.dart';
import '../repositries/UserRepositries.dart';

class LogInUseCase {
  final UserRepositries userRepositries;
  LogInUseCase({
    required this.userRepositries,
  });
  Future<Either<Failures, Unit>> call(String userName, String password) {
    return userRepositries.login(userName, password);
  }
}
