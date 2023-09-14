import 'package:autosmith/data/utils/firebase_code_response.dart';
import 'package:autosmith/domain/repositories/phone_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/failure.dart';
import '../repositories/firebase_auth_repository.dart';

class PhoneAuthUseCase {
  final PhoneAuthRepository phoneAuthRepository;
  const PhoneAuthUseCase({required this.phoneAuthRepository});

  // bool get isLoggedIn => phoneAuthRepository.isLoggedIn;

  Future<Either<Failure, Either<FirebaseCodeResponse, AuthCredential>>>
      signInUser({required String phoneNumber}) async {
    final result = await phoneAuthRepository.signIn(phoneNumber);
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  Future<AuthCredential> verifyOTP(
      {required String verificationId, required String otp}) async {
    final result = await phoneAuthRepository.verifyOTP(verificationId, otp);
    return result;
  }
}
