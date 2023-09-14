import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/failure.dart';

abstract class AuthUseCase {
  Future<Either<Failure, AuthCredential>> signInUser();
}

abstract class OAuthUseCase implements AuthUseCase {
  @override
  Future<Either<Failure, OAuthCredential>> signInUser();
}
