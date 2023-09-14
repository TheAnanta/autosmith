import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/failure.dart';

abstract class PasswordAuthRepository {
  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, UserCredential>> createUserWithEmailAndPassword(
      String email, String password);
  Future<void> signOut();

  Future<Either<Failure, bool>> checkIfUserEmailExists(String email);
}
