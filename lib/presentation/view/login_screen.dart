import 'package:country_code_picker/country_code_picker.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var pageController = PageController();
  var pageIndex = 0;

  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // pageController.addListener(() {
    //   setState(() {});
    // });
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(36),
                color: Theme.of(context).colorScheme.primary,
                height: 422,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/app-icon.svg",
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      height: 40,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "SKIP",
                        style: GoogleFonts.unicaOne(
                            textStyle:
                                Theme.of(context).textTheme.headlineSmall,
                            color: Colors.white.withOpacity(0.5)),
                      ),
                    ),
                  ],
                )),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text("Join to never have to wait on the roads!"),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        pageIndex == 0
                            ? FilledButton(
                                onPressed: () {
                                  setState(() {
                                    pageIndex == 0;
                                  });
                                  pageController.animateToPage(0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      FeatherIcons.phone,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text("Number"),
                                  ],
                                ))
                            : OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    pageIndex == 0;
                                  });
                                  pageController.animateToPage(0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      FeatherIcons.phone,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text("Number"),
                                  ],
                                )),
                        const SizedBox(
                          width: 24,
                        ),
                        pageIndex == 0
                            ? OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    pageIndex == 1;
                                  });
                                  pageController.animateToPage(1,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      FeatherIcons.atSign,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text("Mail"),
                                  ],
                                ))
                            : FilledButton(
                                onPressed: () {},
                                child: const Row(
                                  children: [
                                    Icon(
                                      FeatherIcons.atSign,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text("Mail"),
                                  ],
                                )),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      height: 216,
                      child: PageView.builder(
                        controller: pageController,
                        itemBuilder: (context, index) {
                          return index == 0
                              ? Column(
                                  children: [
                                    const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text("Mobile Number")),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: (phoneNumber) =>
                                          phoneNumber?.length != 10
                                              ? "Enter a valid phone number"
                                              : null,
                                      controller: mobileController,
                                      maxLength: 10,
                                      decoration: InputDecoration(
                                        hintText: "Enter your number",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        prefixIcon: const CountryCodePicker(
                                          onChanged: print,
                                          initialSelection: "IN",
                                          favorite: ["+91", "IN"],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextFormField(
                                      controller: emailController,
                                      validator: (email) => email != null
                                          ? (!email.contains("@") ||
                                                  !email.contains(".")
                                              ? "Enter a valid email"
                                              : null)
                                          : "Enter a valid email",
                                      decoration: InputDecoration(
                                        hintText: "Enter your email",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        prefixIcon: const Icon(
                                          FeatherIcons.mail,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    TextFormField(
                                      validator: (password) => (password
                                                      ?.isEmpty ??
                                                  true) ||
                                              (password?.length ?? 0) < 8
                                          ? "Password must be atleast 8 characters long"
                                          : null,
                                      controller: passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: "Enter your password",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        prefixIcon: const Icon(
                                          FeatherIcons.key,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                        },
                        itemCount: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 56,
                    ),
                    MaterialButton(
                      onPressed: () {
                        final formValidationResult =
                            formKey.currentState?.validate();
                        if (formValidationResult == true) {
                          if (pageController.page == 0) {
                            //Mobile login
                            Navigator.of(context).pushNamed(
                              "/otp-page",
                            );
                          } else {
                            //Email login
                          }
                        }
                      },
                      height: 48,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2),
                      ),
                      child: Text(
                        "Next",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
