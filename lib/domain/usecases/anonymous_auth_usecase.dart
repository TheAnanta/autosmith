import 'package:autosmith/data/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnonymousAuthUseCase {
  final FirebaseAuth firebaseAuth;
  const AnonymousAuthUseCase({required this.firebaseAuth});

  Future<Either<Failure, UserCredential>> signInAnonymous() async {
    try {
      final userCredential = await firebaseAuth.signInAnonymously();
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          return const Left(Failure(
              message: "Anonymous auth hasn't been enabled for this project."));
        default:
          return const Left(
            Failure(message: "Unknown error."),
          );
      }
    }
  }
}
