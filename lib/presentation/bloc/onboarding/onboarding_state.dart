import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();
  @override
  List<Object?> get props => [];
}

class OnboardingLoading extends OnboardingState {}

class OnboardingUserAvailable extends OnboardingState {}

class OnboardingUserLoggedOut extends OnboardingState {}

class OnboardingError extends OnboardingState {
  final String error;
  const OnboardingError({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class OnboardingNewUser extends OnboardingState {}
