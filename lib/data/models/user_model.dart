import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:autosmith/domain/entities/user.dart';

import '../../domain/enums/social_platforms.dart';

class UserModel extends Equatable {
  final String name;
  final String? email;
  final String? phone;
  final String? image;

  const UserModel({
    required this.name,
    this.email = '',
    this.phone = '',
    this.image = "https://github.com/ManasMalla.png",
  });

  @override
  List<Object?> get props => [];

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      UserModel(
        name: snapshot.get("name"),
        email: snapshot.get("email"),
        phone: snapshot.get("phone"),
        image: snapshot.get("image") ?? "https://github.com/ManasMalla.png",
      );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone ?? "",
      "image": image ?? "",
    };
  }

  User toEntity() => User(
        name: name,
        email: email,
        phone: phone,
        image: image,
      );
}
