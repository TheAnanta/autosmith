import 'dart:io';

import 'package:autosmith/data/models/firestore_models/user_firestore_object_model.dart';
import 'package:autosmith/data/models/user_model.dart';
import 'package:autosmith/data/repositories/firebase_auth_repository_impl.dart';
import 'package:autosmith/data/repositories/firestore_repository_impl.dart';
import 'package:autosmith/data/repositories/get_place_repository_impl.dart';
import 'package:autosmith/data/repositories/google_auth_repository_impl.dart';
import 'package:autosmith/data/repositories/google_one_tap_auth_repository_impl.dart';
import 'package:autosmith/domain/enums/collection_enum.dart';
import 'package:autosmith/domain/repositories/firebase_auth_repository.dart';
import 'package:autosmith/domain/usecases/create_profile_usecase.dart';
import 'package:autosmith/domain/usecases/firebase_auth_usecase.dart';
import 'package:autosmith/domain/usecases/google_auth_usecase.dart';
import 'package:autosmith/presentation/bloc/onboarding/onboarding_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuthentication;
import 'package:google_sign_in/google_sign_in.dart';

import '../data/datasources/get_place_datasource.dart';
import '../data/models/firestore_models/firestore_object_model.dart';
import '../domain/entities/user.dart';
import '../domain/repositories/firestore_repository.dart';
import '../domain/repositories/get_place_repository.dart';
import '../domain/repositories/google_auth_repository.dart';
import '../domain/usecases/firestore_usecase.dart';
import '../domain/usecases/get_place_usecase.dart';
import 'package:http/http.dart' as http;

import '../domain/usecases/google_one_tap_auth_usecase.dart';

class Injector {
  static final http.Client _client = http.Client();

  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static GoogleAuthRepository googleAuthRepository =
      GoogleAuthRepositoryImpl(googleSignIn: _googleSignIn);
  static const GoogleAuthRepository googleOneTapAuthRepository =
      GoogleOneTapAuthRepositoryImpl();
  static GoogleAuthUseCase googleAuthUseCase =
      GoogleAuthUseCase(googleAuthRepository: googleAuthRepository);
  static const GoogleOneTapAuthUseCase googleOneTapAuthUseCase =
      GoogleOneTapAuthUseCase(
          googleOneTapAuthRepository: googleOneTapAuthRepository);
  static final FirebaseAuthentication.FirebaseAuth firebaseAuth =
      FirebaseAuthentication.FirebaseAuth.instance;
  static FirebaseAuthRepository firebaseAuthRepository =
      FirebaseAuthRepositoryImpl(auth: firebaseAuth);
  static FirebaseAuthUseCase firebaseAuthUseCase = FirebaseAuthUseCase(
      firebaseAuthRepository: firebaseAuthRepository,
      oAuthUseCase:
          Platform.isAndroid ? googleOneTapAuthUseCase : googleAuthUseCase);

  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirestoreObjectModel<UserModel, User> userFirestoreObjectModel =
      UserFirestoreModel();
  static FirestoreRepository userFirestoreRepository =
      FirestoreRepositoryImpl<UserModel, User>(
          firestore: firestore,
          collection: Collection.Users,
          objectModel: userFirestoreObjectModel);
  static FirestoreUsecase userFirestoreUseCase = FirestoreUsecase(
      collectionType: Collection.Users,
      firestoreRepository: userFirestoreRepository);

  static GetPlaceDataSource getPlaceDataSource =
      GetPlaceDataSourceImpl(client: _client);
  static GetPlaceRepository getPlaceRepository =
      GetPlaceRepositoryImpl(dataSource: getPlaceDataSource);
  static GetPlaceUseCase getPlaceUseCase =
      GetPlaceUseCase(placeRepository: getPlaceRepository);

  static CreateProfileUseCase createProfileUseCase = CreateProfileUseCase(
      getPlaceUseCase: getPlaceUseCase, firestoreUsecase: userFirestoreUseCase);

  static OnboardingBloc splashPageBloc =
      OnboardingBloc(firebaseAuthUseCase: firebaseAuthUseCase);
}
