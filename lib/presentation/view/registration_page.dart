import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                "Help us help\nyou better.",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "This data will help us tailor the experience for you and get things done quick",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 32,
              ),
              const Align(alignment: Alignment.topLeft, child: Text("Name")),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const VehiceDetailsPicker(),
              // const Align(alignment: Alignment.topLeft, child: Text("Name")),
              // SizedBox(
              //   height: 8,
              // ),
              // TextFormField(
              //   decoration: InputDecoration(
              //     hintText: "Enter your Name",
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 16,
              ),
              const Align(alignment: Alignment.topLeft, child: Text("Email")),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              // Spacer(),
              const SizedBox(
                height: 120,
              ),
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
                        Navigator.of(context).pushNamed("/home");
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
    );
  }
}

class VehiceDetailsPicker extends StatefulWidget {
  const VehiceDetailsPicker({
    super.key,
  });

  @override
  State<VehiceDetailsPicker> createState() => _VehiceDetailsPickerState();
}

class _VehiceDetailsPickerState extends State<VehiceDetailsPicker> {
  var cars = 0;
  var bikes = 0;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(12),
          ),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.directions_car_rounded,
              color: Colors.white,
            ),
            const SizedBox(
              width: 24,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  if (cars == 0) {
                    return;
                  }
                  cars--;
                });
              },
              child: const Icon(
                Icons.remove_rounded,
                size: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              cars.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(
              width: 12,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  cars++;
                });
              },
              child: const Icon(
                Icons.add_rounded,
                size: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(12),
          ),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.directions_bike_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 22,
            ),
            const SizedBox(
              width: 24,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  if (bikes == 0) {
                    return;
                  }
                  bikes--;
                });
              },
              child: const Icon(
                Icons.remove_rounded,
                size: 16,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              bikes.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
            ),
            const SizedBox(
              width: 12,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  bikes++;
                });
              },
              child: const Icon(
                Icons.add_rounded,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
