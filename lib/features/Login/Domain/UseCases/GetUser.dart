// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entites/User.dart';
import '../repositries/UserRepositries.dart';

class GetUserUseCase {
  final UserRepositries userRepositries;
  GetUserUseCase({
    required this.userRepositries,
  });

  Future<Either<Failures, User>> call() async {
    return userRepositries.getUser();
  }
}
