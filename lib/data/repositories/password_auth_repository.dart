import 'dart:developer';

import 'package:autosmith/data/failure.dart';
import 'package:autosmith/domain/repositories/password_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/src/auth_credential.dart';

class PasswordAuthRepositoryImpl implements PasswordAuthRepository {
  final FirebaseAuth firebaseAuth;
  const PasswordAuthRepositoryImpl({required this.firebaseAuth});
  @override
  Future<Either<Failure, UserCredential>> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const Left(
            Failure(message: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        return signInWithEmailAndPassword(email, password);
      } else {
        return const Left(
            Failure(message: "Oops! Please try after some time."));
      }
    } catch (e) {
      return Left(Failure(message: 'Something went wrong. Error: $e'));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Right(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left(Failure(message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        return const Left(
            Failure(message: 'Wrong password provided for that user.'));
      } else {
        return Left(Failure(message: 'Something went wrong. Error: $e'));
      }
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<Either<Failure, bool>> checkIfUserEmailExists(String email) async {
    try {
      final result = await firebaseAuth.fetchSignInMethodsForEmail(email);
      log(result.toString());
      return Right(result.isNotEmpty);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        return const Left(Failure(message: "Invalid email"));
      } else {
        return Left(
          Failure(message: "Something went wrong. $e"),
        );
      }
    }
  }
}
