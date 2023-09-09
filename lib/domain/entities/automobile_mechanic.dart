import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AutomobileMechanic {
  final String name;
  final String logo;
  final Location location;
  final double rating;
  final int pricePerCredit;
  const AutomobileMechanic({
    required this.name,
    this.logo = "assets/logo/mohan-mechanics.png",
    required this.location,
    this.rating = 2.5,
    this.pricePerCredit = 300,
  });
}
