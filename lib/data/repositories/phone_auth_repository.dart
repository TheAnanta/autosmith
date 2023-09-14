import 'dart:async';

import 'package:autosmith/data/failure.dart';
import 'package:autosmith/domain/repositories/phone_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/src/auth_credential.dart';

import '../utils/firebase_code_response.dart';

class PhoneAuthRepositoryImpl implements PhoneAuthRepository {
  final FirebaseAuth firebaseAuth;
  const PhoneAuthRepositoryImpl({required this.firebaseAuth});
  @override
  Future<Either<Failure, Either<FirebaseCodeResponse, AuthCredential>>> signIn(
      String phoneNumber) async {
    final Completer<
            Either<Failure, Either<FirebaseCodeResponse, AuthCredential>>>
        authCredentialCompleter = Completer();
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) =>
          authCredentialCompleter.complete(
        Right(Right(phoneAuthCredential)),
      ),
      verificationFailed: (FirebaseAuthException authException) =>
          authCredentialCompleter.complete(
        Left(
          Failure(
              message: authException.message ??
                  "Couldn't sign you in. Please try again later."),
        ),
      ),
      codeSent: (String verificationId, int? resendToken) => {
        //Add bloc to listen for codeSent event
        //Navigate to OTP screen and pass verificationId
        authCredentialCompleter.complete(
          Right(
            Left(
              FirebaseCodeResponse(
                  phoneNumber: phoneNumber,
                  verificationId: verificationId,
                  resendToken: resendToken),
            ),
          ),
        ),
      },
      codeAutoRetrievalTimeout: (String verificationId) => {
        //Add bloc to listen for codeAutoRetrievalTimeout event
        authCredentialCompleter.complete(
          Right(
            Left(
              FirebaseCodeResponse(
                  phoneNumber: phoneNumber,
                  verificationId: verificationId,
                  resendToken: null),
            ),
          ),
        ),
      },
    );
    return authCredentialCompleter.future;
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AuthCredential> verifyOTP(String verificationId, String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    return credential;
  }
}
