import 'dart:convert';

import 'package:autosmith/domain/enums/automobile_variants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../failure.dart';
import '../../../domain/entities/user.dart';
import '../user_model.dart';
import 'firestore_object_model.dart';

class UserFirestoreModel implements FirestoreObjectModel<UserModel, User> {
  @override
  Either<Failure, UserModel> getModelFromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Right(UserModel.fromDocumentSnapshot(snapshot));
  }

  @override
  Map<String, dynamic> toJson(UserModel data) => data.toJson();

  @override
  User toEntity(UserModel model) => model.toEntity();

  @override
  UserModel fromEntity(User entity) => UserModel(
        name: entity.name,
        email: entity.email,
        phone: entity.phone,
        image: entity.image,
        vehicles: (entity.vehicles ?? [])
            .map((e) => AutomobileVariant.fromJson(e))
            .toList(),
      );
}
