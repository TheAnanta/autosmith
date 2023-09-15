import 'package:autosmith/data/callbacks.dart';
import 'package:autosmith/data/datasources/automobile_brands.dart';
import 'package:autosmith/domain/entities/user.dart' as UserEntity;
import 'package:autosmith/domain/enums/automobile_brand.dart';
import 'package:autosmith/domain/enums/automobile_variants.dart';
import 'package:autosmith/injector.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                  validator: (name) => (name != null && name.isNotEmpty)
                      ? null
                      : "Enter your name",
                  controller: nameController,
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

                FirebaseAuth.instance.currentUser?.email == null
                    ? Column(
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(text: "Email"),
                                  TextSpan(
                                    text: " (Optional)",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "Enter your email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      )
                    : const SizedBox(),
                FirebaseAuth.instance.currentUser?.phoneNumber == null
                    ? Column(
                        children: [
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text("Phone")),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: mobileController,
                            validator: (phoneNumber) =>
                                phoneNumber?.length != 10
                                    ? "Enter a valid phone number"
                                    : null,
                            decoration: InputDecoration(
                              hintText: "Enter your phone",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 32,
                ),
                const VehiceDetailsPicker(),
                // Spacer(),
                const SizedBox(
                  height: 54,
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
                        onPressed: () async {
                          var formResult = formKey.currentState?.validate();
                          if (formResult ?? false) {
                            if (Injector.firebaseAuth.currentUser != null) {
                              final result = await Injector.createProfileUseCase
                                  .createProfile(
                                      Injector.firebaseAuth.currentUser!,
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: mobileController.text,
                                      onSuccessCallbackListener:
                                          OnSuccessCallbackListener(
                                              onSuccess: () {}));
                              result.fold(
                                  (l) => ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                          SnackBar(content: Text(l.message))),
                                  (r) =>
                                      Navigator.of(context).pushNamed("/home"));
                            } else {
                              //SHOW ERROR
                            }
                          } else {
                            //SHOW ERROR
                          }
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
  List<AutomobileVariant> selectedVehicles = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      primary: false,
      child: Row(
        children: [
          ...List.generate(selectedVehicles.length, (index) {
            return Builder(builder: (context) {
              var isCar = cars
                  .where((element) => selectedVehicles[index].id == element.id)
                  .isNotEmpty;
              return Row(
                children: [
                  Container(
                    clipBehavior: Clip.none,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 48,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: isCar
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.tertiaryContainer),
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 54,
                            ),
                            Text(
                              selectedVehicles[index].variant,
                              style: GoogleFonts.urbanist(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: isCar
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onPrimary
                                          : Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                    ),
                              ),
                            ),
                            Text(
                                (isCar ? cars : bikes)
                                    .firstWhere((element) => selectedVehicles
                                        .map((e) => e.id)
                                        .toList()
                                        .contains(element.id))
                                    .name,
                                style: GoogleFonts.urbanist(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: isCar
                                            ? Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                                .withOpacity(0.7)
                                            : Theme.of(context)
                                                .colorScheme
                                                .tertiary
                                                .withOpacity(0.7),
                                      ),
                                )),
                          ],
                        ),
                        Positioned(
                          top: -54,
                          child: Image.network(
                            isCar
                                ? "https://www.pngmart.com/files/21/White-Tesla-Car-PNG-HD-Isolated.png"
                                : "https://www.yamaha-motor-india.com/theme/v3/image/fascino125fi-new/color/Disc/YELLOW-COCKTAIL-STD.png",
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
              );
            });
          }),
          InkWell(
            onTap: () {
              addCarBottomSheet();
            },
            child: DottedBorder(
              dashPattern: [12, 6],
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
                    const SizedBox(
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
                        const Text(
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
          const SizedBox(
            width: 12,
          ),
          InkWell(
            onTap: () {
              addBikeBottomSheet();
            },
            child: DottedBorder(
              dashPattern: [12, 6],
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
                    const SizedBox(
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
                        const Text(
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

  void addCarBottomSheet() {
    AutomobileBrand? selectedBrand;
    AutomobileVariant? selectedModel;
    TextEditingController yearController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, itemState) {
          return SingleChildScrollView(
            child: LayoutBuilder(builder: (context, constraints) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.directions_car_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      'Add Car',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc finibus, purus eu efficitur tincidunt.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    DropdownMenu(
                      width: constraints.maxWidth * 0.85,
                      onSelected: (value) {
                        itemState(() {
                          selectedBrand =
                              cars.firstWhere((element) => element.id == value);
                        });
                      },
                      label: const Text('Brand'),
                      dropdownMenuEntries: cars
                          .map<DropdownMenuEntry>((e) =>
                              DropdownMenuEntry(value: e.id, label: e.name))
                          .toList(),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: selectedBrand != null
                          ? DropdownMenu(
                              width: constraints.maxWidth * 0.85,
                              // enabled: selectedBrand.isNotEmpty,
                              onSelected: (value) {
                                selectedModel = cars
                                    .firstWhere(
                                        (element) => element == selectedBrand)
                                    .variants
                                    .firstWhere(
                                        (variant) => variant.id == value);
                              },
                              label: const Text('Model'),
                              dropdownMenuEntries: cars
                                  .firstWhere(
                                      (element) => element == selectedBrand)
                                  .variants
                                  .map<DropdownMenuEntry>((e) =>
                                      DropdownMenuEntry(
                                          value: e.id, label: e.variant))
                                  .toList(),
                            )
                          : SizedBox(),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextField(
                      controller: yearController,
                      decoration: InputDecoration(
                        hintText: "Year of Manufacture",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                          onPressed: () {
                            selectedVehicles.add(cars
                                .firstWhere(
                                    (element) => element == selectedBrand)
                                .variants
                                .firstWhere(
                                    (variant) => variant == selectedModel));
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          child: const Text('Add Car')),
                    ),
                  ],
                ),
              );
            }),
          );
        });
      },
    );
  }

  void addBikeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        AutomobileBrand? selectedBrand;
        AutomobileVariant? selectedModel;
        TextEditingController yearController = TextEditingController();
        return StatefulBuilder(builder: (context, itemState) {
          return SingleChildScrollView(
            child: LayoutBuilder(builder: (context, constraints) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.directions_bike_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      'Add Bike',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc finibus, purus eu efficitur tincidunt.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    DropdownMenu(
                      width: constraints.maxWidth * 0.85,
                      onSelected: (value) {
                        itemState(() {
                          selectedBrand = bikes
                              .firstWhere((element) => element.id == value);
                        });
                      },
                      label: const Text('Brand'),
                      // initialSelection: bikes.first.name,
                      dropdownMenuEntries: bikes
                          .map<DropdownMenuEntry>((e) =>
                              DropdownMenuEntry(value: e.id, label: e.name))
                          .toList(),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    selectedBrand != null
                        ? DropdownMenu(
                            width: constraints.maxWidth * 0.85,
                            onSelected: (value) {
                              itemState(() {
                                selectedModel = bikes
                                    .firstWhere(
                                        (element) => element == selectedBrand)
                                    .variants
                                    .firstWhere(
                                        (variant) => variant.id == value);
                              });
                            },
                            label: const Text('Model'),
                            dropdownMenuEntries: bikes
                                .singleWhere(
                                    (element) => element == selectedBrand)
                                .variants
                                .map<DropdownMenuEntry>((e) =>
                                    DropdownMenuEntry(
                                        value: e.id, label: e.variant))
                                .toList(),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 24,
                    ),
                    TextField(
                      controller: yearController,
                      decoration: InputDecoration(
                        hintText: "Year of Manufacture",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                          onPressed: () {
                            selectedVehicles.add(bikes
                                .firstWhere(
                                    (element) => element == selectedBrand)
                                .variants
                                .firstWhere(
                                    (variant) => variant == selectedModel));
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          child: const Text('Add Bike')),
                    ),
                  ],
                ),
              );
            }),
          );
        });
      },
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
