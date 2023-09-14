import 'package:autosmith/domain/repositories/password_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/failure.dart';
import 'oath_usecase.dart';

class PasswordAuthUseCase {
  final PasswordAuthRepository passwordAuthRepository;
  const PasswordAuthUseCase({required this.passwordAuthRepository});

  Future<Either<Failure, UserCredential>> authenticateUser(
      {required String email, required String password}) async {
    final doesUserExistOnPlatform = await checkIfUserEmailExists(email);
    return doesUserExistOnPlatform.fold(
        (l) => Left(l),
        (r) => r
            ? signInUser(email: email, password: password)
            : signUpUser(email: email, password: password));
  }

  Future<Either<Failure, bool>> checkIfUserEmailExists(String email) {
    return passwordAuthRepository.checkIfUserEmailExists(email);
  }

  Future<Either<Failure, UserCredential>> signUpUser(
      {required String email, required String password}) {
    return passwordAuthRepository.createUserWithEmailAndPassword(
        email, password);
  }

  Future<Either<Failure, UserCredential>> signInUser(
      {required String email, required String password}) {
    return passwordAuthRepository.signInWithEmailAndPassword(email, password);
  }

  Future<void> signOut({required String email, required String password}) {
    return passwordAuthRepository.signOut();
  }
}
