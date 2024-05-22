import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/User.dart';

abstract class UserRepositries {
  Future<Either<Failures, User>> getUser();
  Future<Either<Failures, Unit>> login(String userName, String password);
}
