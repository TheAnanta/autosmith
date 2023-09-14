import 'package:flutter/material.dart';

class LoaderScreen extends StatelessWidget {
  final Widget child;
  final bool shouldShowLoader;
  const LoaderScreen(
      {super.key, required this.shouldShowLoader, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        shouldShowLoader
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
  }
}
