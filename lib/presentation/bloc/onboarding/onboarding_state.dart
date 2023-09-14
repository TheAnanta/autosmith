import 'package:autosmith/data/utils/firebase_code_response.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {}

class AuthUserAvailable extends AuthState {}

class AuthUserLoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String error;
  const AuthError({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class AuthNewUser extends AuthState {}

class AuthOTP extends AuthState {
  final FirebaseCodeResponse firebaseCodeResponse;
  const AuthOTP({required this.firebaseCodeResponse});
}
