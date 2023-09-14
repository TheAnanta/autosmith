import 'dart:io';

import 'package:autosmith/domain/usecases/firebase_auth_usecase.dart';
import 'package:autosmith/injector.dart';
import 'package:autosmith/presentation/bloc/onboarding/onboarding_event.dart';
import 'package:autosmith/presentation/bloc/onboarding/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final FirebaseAuthUseCase firebaseAuthUseCase;
  OnboardingBloc({required this.firebaseAuthUseCase})
      : super(OnboardingLoading()) {
    on<OnAppInit>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2), () {
        final isLoggedIn = firebaseAuthUseCase.isLoggedIn;
        if (isLoggedIn) {
          emit(OnboardingUserAvailable());
        } else {
          if (!Platform.isAndroid) {
            emit(OnboardingUserLoggedOut());
          } else {
            add(const OnSignInWithGoogle());
          }
        }
      });
    });

    on<OnSignInWithGoogle>((event, emit) async {
      final result = await Injector.firebaseAuthUseCase.signInUser();
      result.fold((failure) {
        Future.delayed(Duration(seconds: 1), () {
          exit(0);
        });
        emit(OnboardingError(error: failure.message));
      }, (isNewUser) {
        if (isNewUser) {
          emit(OnboardingNewUser());
        } else {
          emit(OnboardingUserAvailable());
        }
      });
    });
  }
}
