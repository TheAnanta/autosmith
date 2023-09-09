import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/onboarding");
            },
            child: Row(
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
                        ?.copyWith(
                            fontWeight: FontWeight.w900, letterSpacing: 8),
                  ),
                )
              ],
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Text(
            "Developed by",
            style: GoogleFonts.unicaOne(
              textStyle: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(letterSpacing: 8),
            ),
            textAlign: TextAlign.justify,
          ),
          Text(
            "Manas Malla",
            style: GoogleFonts.unicaOne(
              textStyle: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(letterSpacing: 8),
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
