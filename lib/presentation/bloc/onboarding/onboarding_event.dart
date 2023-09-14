import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class OnAppInit extends AuthEvent {
  const OnAppInit();
  @override
  List<Object?> get props => [];
}

class OnSignInWithGoogle extends AuthEvent {
  const OnSignInWithGoogle();
  @override
  List<Object?> get props => [];
}

class OnSignInWithPassword extends AuthEvent {
  final String email;
  final String password;
  const OnSignInWithPassword({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class OnSignInWithPhone extends AuthEvent {
  final String phoneNumber;
  const OnSignInWithPhone({required this.phoneNumber});
  @override
  List<Object?> get props => [phoneNumber];
}

class OnVerifyOTP extends AuthEvent {
  final String verificationId;
  final String otp;
  const OnVerifyOTP({required this.verificationId, required this.otp});
  @override
  List<Object?> get props => [verificationId, otp];
}
