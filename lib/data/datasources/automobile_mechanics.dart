import 'package:autosmith/domain/entities/automobile_mechanic.dart';
import 'package:geocoding/geocoding.dart';

final automobileMechanic = [
  AutomobileMechanic(
    name: "Mala's AutoGarage",
    logo: "assets/logo/mala-autogarage.png",
    location: Location(
      latitude: 17.7104936,
      longitude: 83.1662021,
      timestamp: DateTime.now(),
    ),
    rating: 5,
    pricePerCredit: 400,
  ),
  AutomobileMechanic(
    name: "Dusi's GarageAI",
    logo: "assets/logo/pro-rider-ai.png",
    location: Location(
      latitude: 17.7104936,
      longitude: 83.1662021,
      timestamp: DateTime.now(),
    ),
    rating: 4.8,
    pricePerCredit: 600,
  ),
  AutomobileMechanic(
    name: "Varma's Garage",
    logo: "assets/logo/varma-garage.png",
    location: Location(
      latitude: 17.7104936,
      longitude: 83.1662021,
      timestamp: DateTime.now(),
    ),
    rating: 3,
    pricePerCredit: 150,
  ),
  AutomobileMechanic(
    name: "Mohan's Auto Mechanics",
    location: Location(
      latitude: 17.7104936,
      longitude: 83.1662021,
      timestamp: DateTime.now(),
    ),
    rating: 2,
    pricePerCredit: 800,
  ),
  AutomobileMechanic(
    name: "Ramana's Shed",
    logo: "assets/logo/ramana-shed.png",
    location: Location(
      latitude: 17.7104936,
      longitude: 83.1662021,
      timestamp: DateTime.now(),
    ),
    rating: 2.5,
    pricePerCredit: 200,
  ),
];
