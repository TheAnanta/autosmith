import 'package:autosmith/data/utils/firebase_code_response.dart';
import 'package:autosmith/injector.dart';
import 'package:autosmith/presentation/bloc/onboarding/onboarding_event.dart';
import 'package:autosmith/presentation/bloc/onboarding/onboarding_state.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FirebaseCodeResponse firebaseResponseCode =
        ModalRoute.of(context)?.settings.arguments as FirebaseCodeResponse;
    return BlocConsumer(
        bloc: Injector.authBloc,
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          } else if (state is AuthUserAvailable) {
            Navigator.of(context).pushReplacementNamed("/home");
          } else if (state is AuthNewUser) {
            Navigator.of(context).pushReplacementNamed("/registration");
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: SvgPicture.asset("assets/app-icon.svg"),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      Text(
                        "Verify your number",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text.rich(
                        TextSpan(children: [
                          const TextSpan(
                              text:
                                  "we sent a SMS with verification code to your phone "),
                          TextSpan(
                            text:
                                "${firebaseResponseCode.phoneNumber.substring(0, 3)} ${firebaseResponseCode.phoneNumber.substring(3, 8)} ${firebaseResponseCode.phoneNumber.substring(8)}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ]),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Pinput(
                        controller: otpController,
                        length: 6,
                        defaultPinTheme: PinTheme(
                          width: 56,
                          height: 64,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {},
                          child: Text(
                            "Resend OTP",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          SizedBox(
                            width: 60,
                            child: IconButton.filled(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(FeatherIcons.arrowLeft)),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 120,
                            child: OutlinedButton(
                              onPressed: () {
                                Injector.authBloc.add(
                                  OnVerifyOTP(
                                    verificationId:
                                        firebaseResponseCode.verificationId,
                                    otp: otpController.text,
                                  ),
                                );
                                // Navigator.of(context).pushNamed("/registration");
                              },
                              child: Text(
                                "Next",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              state is AuthLoading
                  ? Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              padding: const EdgeInsets.all(8),
                              child: const CircularProgressIndicator())))
                  : const SizedBox(),
            ],
          );
        });
  }
}
