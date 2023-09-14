import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.of(context).pushReplacementNamed('/onboarding'),
    );
    return Scaffold(
      body: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/app-icon.svg"),
              const SizedBox(
                width: 24,
              ),
              Text(
                "Auto\nSmith",
                style: GoogleFonts.unicaOne(
                  textStyle: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w900, letterSpacing: 8),
                ),
              )
            ],
          ),
          const Spacer(
            flex: 2,
          ),
          Text(
            "Developed by",
            style: GoogleFonts.urbanist(
              textStyle: Theme.of(context).textTheme.titleMedium,
            ),
            textAlign: TextAlign.justify,
          ),
          Text(
            "The Ananta",
            style: GoogleFonts.urbanist(
              textStyle: Theme.of(context).textTheme.headlineMedium,
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
