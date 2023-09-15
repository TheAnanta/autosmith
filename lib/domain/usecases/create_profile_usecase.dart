import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:autosmith/data/callbacks.dart';
import 'package:autosmith/data/failure.dart';
import 'package:autosmith/data/models/user_model.dart';
import 'package:autosmith/domain/usecases/firestore_usecase.dart';
import 'package:autosmith/domain/usecases/get_place_usecase.dart';

import '../enums/automobile_variants.dart';

class CreateProfileUseCase {
  final GetPlaceUseCase getPlaceUseCase;
  final FirestoreUsecase firestoreUsecase;
  const CreateProfileUseCase({
    required this.getPlaceUseCase,
    required this.firestoreUsecase,
  });
  Future<Either<Failure, void>> createProfile(User firebaseUser,
      {required String name,
      String? email,
      String? phone,
      List<AutomobileVariant> vehicles = const [],
      required OnSuccessCallbackListener onSuccessCallbackListener}) async {
    final userModel =
        UserModel(name: name, email: email, phone: phone, vehicles: vehicles);

    return await firestoreUsecase.putData(
        userModel.toEntity(), firebaseUser.uid,
        onSuccessCallbackListener: onSuccessCallbackListener);
  }
}
