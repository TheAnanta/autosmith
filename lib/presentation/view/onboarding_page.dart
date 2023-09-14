import 'package:autosmith/presentation/bloc/onboarding/onboarding_bloc.dart';
import 'package:autosmith/presentation/bloc/onboarding/onboarding_event.dart';
import 'package:autosmith/presentation/bloc/onboarding/onboarding_state.dart';
import 'package:autosmith/presentation/view/home_page.dart';
import 'package:autosmith/presentation/view/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingData {
  final String title;
  final String imagePath;

  const OnboardingData({required this.title, required this.imagePath});
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final data = const [
    OnboardingData(
      title: "The mobile vehicle service company",
      imagePath: "assets/mobile-driving-solution.svg",
    ),
    OnboardingData(
      title: "Got tire punctured?",
      imagePath: "assets/bike-workshop.svg",
    ),
    OnboardingData(
      title: "Join and travel tension free",
      imagePath: "assets/driving-school.svg",
    ),
  ];

  var index = 0;

  @override
  Widget build(BuildContext context) {
    context.read<OnboardingBloc>().add(OnAppInit());
    return BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
      if (state is OnboardingUserLoggedOut) {
        return Scaffold(
          body: OnboardingTemplate(
            index,
            title: data[index].title,
            image: data[index].imagePath,
            onNext: () {
              if (index >= 2) {
                Navigator.of(context).pushReplacementNamed("/login");
              } else {
                index++;
                setState(() {});
              }
            },
          ),
        );
      } else if (state is OnboardingUserAvailable) {
        return const HomePage();
      } else if (state is OnboardingNewUser) {
        return const RegistrationPage();
      } else if (state is OnboardingLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is OnboardingError) {
        return Center(
          child: Text(state.error),
        );
      } else {
        return Center(
          child: Text('State error.'),
        );
      }
    });
  }
}

class OnboardingTemplate extends StatelessWidget {
  final String title;
  final String image;
  final int index;
  final Function onNext;
  const OnboardingTemplate(this.index,
      {super.key,
      this.title = "AutoSmith",
      this.image = "assets/mobile-driving-solution.svg",
      required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: SvgPicture.asset("assets/app-icon.svg"),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  FilledButton(
                    onPressed: () => onNext(),
                    child: Text(index < 2 ? "Learn More" : "Login"),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  index == 2
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              surfaceTintColor: Colors.white,
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.grey.shade700),
                          onPressed: () {
                            //Add in sign in with Google
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/240px-Google_%22G%22_Logo.svg.png",
                                height: 20,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text("Sign in with Google"),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        SvgPicture.asset(
          image,
          fit: BoxFit.fitWidth,
        )
      ],
    );
  }
}
