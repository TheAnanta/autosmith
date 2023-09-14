import 'package:autosmith/data/datasources/automobile_brands.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
              FirebaseAuth.instance.currentUser?.phoneNumber != null
                  ? Column(
                      children: [
                        const Align(
                            alignment: Alignment.topLeft,
                            child: Text("Email (optional)")),
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
                      ],
                    )
                  : Column(
                      children: [
                        const Align(
                            alignment: Alignment.topLeft, child: Text("Phone")),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter your phone",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 16,
              ),
              const VehiceDetailsPicker(),
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
  // var cars = [];
  // var bikes = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      primary: false,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  var selectedBrand = '';
                  return StatefulBuilder(builder: (context, itemState) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 48, horizontal: 24),
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add Car',
                              style: TextStyle(fontSize: 24),
                            ),
                            SizedBox(
                              height: 36,
                            ),
                            DropdownMenu(
                              onSelected: (value) {
                                itemState(() {
                                  selectedBrand = value;
                                });
                              },
                              label: Text('Brand'),
                              dropdownMenuEntries: cars
                                  .map<DropdownMenuEntry>((e) =>
                                      DropdownMenuEntry(
                                          value: e.name, label: e.name))
                                  .toList(),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Visibility(
                              visible: selectedBrand.isNotEmpty,
                              child: DropdownMenu(
                                label: Text('Model'),
                                dropdownMenuEntries: cars
                                    .singleWhere((element) =>
                                        element.name == selectedBrand)
                                    .variants
                                    .map<DropdownMenuEntry>((e) =>
                                        DropdownMenuEntry(
                                            value: e.variant, label: e.variant))
                                    .toList(),
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            ElevatedButton(
                                onPressed: () {}, child: Text('Add Car')),
                          ],
                        ),
                      ),
                    );
                  });
                },
              );
            },
            child: DottedBorder(
              color: Theme.of(context).colorScheme.primary,
              radius: const Radius.circular(12),
              borderType: BorderType.RRect,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 56,
                  horizontal: 48,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Icon(
                      Icons.directions_car_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          'Add car',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  var selectedBrand = '';
                  return StatefulBuilder(builder: (context, itemState) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 48, horizontal: 24),
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add Car',
                              style: TextStyle(fontSize: 24),
                            ),
                            SizedBox(
                              height: 36,
                            ),
                            DropdownMenu(
                              onSelected: (value) {
                                itemState(() {
                                  selectedBrand = value;
                                });
                              },
                              label: Text('Brand'),
                              dropdownMenuEntries: bikes
                                  .map<DropdownMenuEntry>((e) =>
                                      DropdownMenuEntry(
                                          value: e.name, label: e.name))
                                  .toList(),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Visibility(
                              visible: selectedBrand.isNotEmpty,
                              child: DropdownMenu(
                                label: Text('Model'),
                                dropdownMenuEntries: bikes
                                    .singleWhere((element) =>
                                        element.name == selectedBrand)
                                    .variants
                                    .map<DropdownMenuEntry>((e) =>
                                        DropdownMenuEntry(
                                            value: e.variant, label: e.variant))
                                    .toList(),
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            ElevatedButton(
                                onPressed: () {}, child: Text('Add Car')),
                          ],
                        ),
                      ),
                    );
                  });
                },
              );
            },
            child: DottedBorder(
              color: Theme.of(context).colorScheme.primary,
              radius: const Radius.circular(12),
              borderType: BorderType.RRect,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 56,
                  horizontal: 48,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Icon(
                      Icons.directions_bike_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          'Add bike',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// Row(
//               children: [
                // Icon(
                //   Icons.directions_car_rounded,
                //   color: Theme.of(context).colorScheme.primary,
                // ),
                // const SizedBox(
                //   width: 24,
                // ),
//                 InkWell(
//                   onTap: () {
                    // setState(() {
                    //   if (cars == 0) {
                    //     return;
                    //   }
                    //   cars--;
                    // });
//                   },
//                   child: Icon(
//                     Icons.remove_rounded,
//                     size: 16,
//                     color: Theme.of(context).colorScheme.primary,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 12,
//                 ),
//                 Text(
//                   cars.toString(),
//                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                         color: Theme.of(context).colorScheme.primary,
//                       ),
//                 ),
//                 const SizedBox(
//                   width: 12,
//                 ),
//                 InkWell(
                  // onTap: () {
                  //   setState(() {
                  //     cars++;
                  //   });
                  // },
//                   child: Icon(
//                     Icons.add_rounded,
//                     size: 16,
//                     color: Theme.of(context).colorScheme.primary,
//                   ),
//                 ),
//               ],
//             )
