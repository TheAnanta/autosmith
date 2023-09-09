import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:autosmith/data/failure.dart';

abstract class GoogleAuthRepository {
  Future<Either<Failure, OAuthCredential>> signIn();
}
