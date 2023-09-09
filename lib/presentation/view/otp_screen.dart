import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  text: "+91 90591 45216",
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
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
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
                      Navigator.of(context).pushNamed("/registration");
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
    );
  }
}
