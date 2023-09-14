import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:autosmith/data/failure.dart';
import 'package:autosmith/domain/repositories/google_auth_repository.dart';
import 'package:google_one_tap_sign_in/google_one_tap_sign_in.dart';

class GoogleOneTapAuthRepositoryImpl implements GoogleAuthRepository {
  const GoogleOneTapAuthRepositoryImpl();
  @override
  Future<Either<Failure, OAuthCredential>> signIn() async {
    try {
      final request = await GoogleOneTapSignIn.startSignIn(
          webClientId:
              "92316330429-p0n7crr4aee4c7dv9rgfbo07joolqbl1.apps.googleusercontent.com");
      if (request == null) {
        return const Left(
            Failure(message: "Oops! Failed to retrive credentials."));
      }
      final credential = GoogleAuthProvider.credential(
        idToken: request.idToken,
      );
      return Right(credential);
    } on SocketException {
      return const Left(Failure(message: "Internet Not Connected"));
    } on Exception {
      return const Left(Failure(message: "Oops! Please try after some time."));
    }
  }
}
