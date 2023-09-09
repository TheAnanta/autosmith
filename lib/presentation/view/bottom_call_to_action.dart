import 'package:autosmith/domain/entities/automobile_issues.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as location_package;

import '../../domain/enums/automobile_type.dart';

class BottomCallToAction extends StatefulWidget {
  final AutomobileIssue automobileIssue;
  final Function(AutomobileType) onWheelerChange;
  const BottomCallToAction(
      {super.key,
      required this.onWheelerChange,
      required this.automobileIssue});

  @override
  State<BottomCallToAction> createState() => _BottomCallToActionState();
}

class _BottomCallToActionState extends State<BottomCallToAction> {
  Future<Placemark?> getLocationAndPermission() async {
    bool serviceEnabled;

    LocationPermission permissionGranted;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location_package.Location().requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await Geolocator.checkPermission();
    if (permissionGranted == LocationPermission.denied) {
      permissionGranted = await Geolocator.requestPermission();
    }
    final location = await Geolocator.getCurrentPosition();
    final placemark =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemark.isNotEmpty) {
      return placemark.first;
    }
    return null;
  }

  TextEditingController locationController = TextEditingController();
  AutomobileType automobileType = AutomobileType.fourWheeler;

  @override
  void initState() {
    super.initState();
    getLocationAndPermission().then((placemark) {
      if (placemark != null) {
        locationController.text = placemark.name ??
            placemark.street ??
            placemark.subAdministrativeArea ??
            placemark.administrativeArea ??
            placemark.country ??
            "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: "Where are you?",
                  filled: true,
                  isDense: true,
                  fillColor: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.5),
                  prefixIcon: const Icon(FeatherIcons.mapPin),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            InkWell(
              onTap: () {
                widget.onWheelerChange(AutomobileType.fourWheeler);
                automobileType = AutomobileType.fourWheeler;
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(12),
                  ),
                  color: automobileType == AutomobileType.twoWheeler
                      ? null
                      : Theme.of(context).colorScheme.primary,
                  border: automobileType == AutomobileType.fourWheeler
                      ? null
                      : Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.directions_car_rounded,
                      color: automobileType == AutomobileType.twoWheeler
                          ? Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5)
                          : Colors.white,
                      size: automobileType == AutomobileType.twoWheeler
                          ? 22
                          : null,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                widget.onWheelerChange(AutomobileType.twoWheeler);
                automobileType = AutomobileType.twoWheeler;
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(12),
                  ),
                  border: automobileType == AutomobileType.twoWheeler
                      ? null
                      : Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  color: automobileType == AutomobileType.fourWheeler
                      ? null
                      : Theme.of(context).colorScheme.primary,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.directions_bike_rounded,
                      color: automobileType == AutomobileType.fourWheeler
                          ? Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5)
                          : Colors.white,
                      size: automobileType == AutomobileType.fourWheeler
                          ? 22
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        MaterialButton(
          height: 48,
          elevation: 0,
          onPressed: () {
            Navigator.of(context).pushNamed("/search-mechanic",
                arguments: widget.automobileIssue);
          },
          color: Theme.of(context).colorScheme.primary,
          minWidth: double.infinity,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FeatherIcons.navigation,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 16,
              ),
              const SizedBox(
                width: 24,
              ),
              Text(
                "Fetch a mechanic nearby",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ],
          ),
        )
      ],
    );
  }
}
