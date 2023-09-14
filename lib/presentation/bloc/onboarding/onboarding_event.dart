import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();
  @override
  List<Object?> get props => [];
}

class OnAppInit extends OnboardingEvent {
  const OnAppInit();
  @override
  List<Object?> get props => [];
}

class OnSignInWithGoogle extends OnboardingEvent {
  const OnSignInWithGoogle();
  @override
  List<Object?> get props => [];
}
