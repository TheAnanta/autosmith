import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:autosmith/data/failure.dart';
import 'package:autosmith/data/models/firestore_models/firestore_object_model.dart';
import 'package:autosmith/domain/enums/collection_enum.dart';
import 'package:autosmith/domain/repositories/firestore_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../callbacks.dart';
import '../utils/collection_utils.dart';

/// [P] - Model class
///
/// [Q] - Entity class
class FirestoreRepositoryImpl<P, Q> implements FirestoreRepository<Q> {
  final FirestoreObjectModel<P, Q> objectModel;
  final FirebaseFirestore firestore;
  final Collection collection;
  const FirestoreRepositoryImpl({
    required this.firestore,
    required this.collection,
    required this.objectModel,
  });
  @override
  Future<Either<Failure, Q>> getData(String documentId) async {
    final documentSnapshot = await firestore
        .collection(CollectionUtils.getCollectionPath(collection))
        .doc(documentId)
        .get();
    final model = objectModel.getModelFromDocumentSnapshot(documentSnapshot);
    return model.fold<Either<Failure, Q>>(
      (l) => Left(l),
      (r) => Right(objectModel.toEntity(r)),
    );
  }

  @override
  Future<Either<Failure, void>> putData(data,
      {String? documentId,
      required OnSuccessCallbackListener onSuccessCallbackListener}) async {
    try {
      await firestore
          .collection(CollectionUtils.getCollectionPath(collection))
          .doc(documentId)
          .set(
            objectModel.toJson(
              objectModel.fromEntity(data),
            ),
          );
      onSuccessCallbackListener.onSuccess();
      return const Right(null);
    } on SocketException {
      return const Left(Failure(message: 'Socket Exception'));
    } on FirebaseException {
      return const Left(Failure(message: 'Firebase Exception'));
    }
  }

  @override
  Future<Either<Failure, void>> updateData(String documentId, Q data,
      {required OnSuccessCallbackListener onSuccessCallbackListener}) {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
