import 'dart:io';

import 'package:autosmith/domain/usecases/firebase_auth_usecase.dart';
import 'package:autosmith/injector.dart';
import 'package:autosmith/presentation/bloc/onboarding/onboarding_event.dart';
import 'package:autosmith/presentation/bloc/onboarding/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthUseCase firebaseAuthUseCase;
  AuthBloc({required this.firebaseAuthUseCase}) : super(AuthLoading()) {
    on<OnAppInit>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2), () {
        final isLoggedIn = firebaseAuthUseCase.isLoggedIn;
        if (isLoggedIn) {
          emit(AuthUserAvailable());
        } else {
          if (!Platform.isAndroid) {
            emit(AuthUserLoggedOut());
          } else {
            add(const OnSignInWithGoogle());
          }
        }
      });
    });

    on<OnSignInWithGoogle>((event, emit) async {
      final result = await Injector.firebaseAuthUseCase.signInUser();
      result.fold((failure) {
        Future.delayed(const Duration(seconds: 2), () {
          exit(0);
        });
        emit(AuthError(error: failure.message));
      }, (isNewUser) {
        if (isNewUser) {
          emit(AuthNewUser());
        } else {
          emit(AuthUserAvailable());
        }
      });
    });

    on<OnSignInWithPassword>((event, emit) async {
      emit(AuthLoading());
      final result = await Injector.passwordAuthUseCase
          .authenticateUser(email: event.email, password: event.password);
      result.fold((failure) {
        Future.delayed(const Duration(seconds: 2), () {
          // exit(0);
        });
        print(failure.message);
        emit(AuthError(error: failure.message));
      }, (userCredential) {
        if (userCredential.additionalUserInfo?.isNewUser ?? true) {
          emit(AuthNewUser());
        } else {
          emit(AuthUserAvailable());
        }
      });
    });

    on<OnSignInWithPhone>(
      (event, emit) async {
        emit(AuthLoading());
        final result = await Injector.phoneAuthUseCase
            .signInUser(phoneNumber: event.phoneNumber);
        result.fold(
          (failure) {
            emit(AuthError(error: failure.message));
          },
          (l) => l.fold(
            (firebaseCodeResponse) =>
                emit(AuthOTP(firebaseCodeResponse: firebaseCodeResponse)),
            (authCredential) async {
              final phoneAuthResult = await Injector.firebaseAuthRepository
                  .linkWithFirebase(authCredential);
              return phoneAuthResult
                  .fold((failure) => emit(AuthError(error: failure.message)),
                      (isNewUser) {
                if (isNewUser) {
                  emit(AuthNewUser());
                } else {
                  emit(AuthUserAvailable());
                }
              });
            },
          ),
        );
      },
    );

    on<OnVerifyOTP>(
      (event, emit) async {
        emit(AuthLoading());
        final authCredential = await Injector.phoneAuthUseCase
            .verifyOTP(otp: event.otp, verificationId: event.verificationId);
        final phoneAuthResult = await Injector.firebaseAuthRepository
            .linkWithFirebase(authCredential);
        return phoneAuthResult.fold(
            (failure) => emit(AuthError(error: failure.message)), (isNewUser) {
          if (isNewUser) {
            emit(AuthNewUser());
          } else {
            emit(AuthUserAvailable());
          }
        });
      },
    );
  }
}
