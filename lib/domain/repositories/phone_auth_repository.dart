import 'package:autosmith/data/utils/firebase_code_response.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/failure.dart';

abstract class PhoneAuthRepository {
  Future<Either<Failure, Either<FirebaseCodeResponse, AuthCredential>>> signIn(
    String phoneNumber,
    int? resendToken,
  );
  Future<AuthCredential> verifyOTP(
    String verificationId,
    String otp,
  );
  Future<void> signOut();
}
