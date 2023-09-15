import 'dart:convert';

import 'package:autosmith/domain/enums/automobile_variants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:autosmith/domain/entities/user.dart';

import '../../domain/enums/social_platforms.dart';

class UserModel extends Equatable {
  final String name;
  final String? email;
  final String? phone;
  final String? image;
  final List<AutomobileVariant> vehicles;

  const UserModel({
    required this.name,
    this.email = '',
    this.phone = '',
    this.image = "https://github.com/ManasMalla.png",
    this.vehicles = const [],
  });

  @override
  List<Object?> get props => [];

  factory UserModel.fromDocumentSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      UserModel(
        name: snapshot.get("name"),
        email: snapshot.get("email"),
        phone: snapshot.get("phone"),
        image: snapshot.get("image") ?? "https://github.com/ManasMalla.png",
        vehicles: snapshot
                .data()!["vehicles"]
                .map<AutomobileVariant>((element) {
              final result = AutomobileVariant.fromJson(element);
              return result;
            }).toList() ??
            [AutomobileVariant(id: 0, variant: "BMW", manufactureYear: "2004")],
      );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone ?? "",
      "image": image ?? "",
      "vehicles": vehicles.map((e) => e.toJson()).toList(),
    };
  }

  User toEntity() => User(
        name: name,
        email: email,
        phone: phone,
        image: image,
        vehicles: vehicles.map((e) => e.toJson()).toList(),
      );
}
