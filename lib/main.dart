import 'package:autosmith/presentation/view/home_page.dart';
import 'package:autosmith/presentation/view/login_screen.dart';
import 'package:autosmith/presentation/view/onboarding_page.dart';
import 'package:autosmith/presentation/view/otp_screen.dart';
import 'package:autosmith/presentation/view/registration_page.dart';
import 'package:autosmith/presentation/view/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color_schemes.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AutoSmith",
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          fontFamily: "Gilroy"),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          fontFamily: "Gilroy"),
      initialRoute: "/home",
      routes: {
        "/splash": (context) => const SplashPage(),
        "/onboarding": (context) => const OnboardingPage(),
        "/login": (context) => const LoginScreen(),
        "/otp-page": (context) => const OTPPage(),
        "/registration": (context) => const RegistrationPage(),
        "/home": (context) => const HomePage(),
      },
    );
  }
}

// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [],
//         ),
//       ),
//     );
//   }
// }
