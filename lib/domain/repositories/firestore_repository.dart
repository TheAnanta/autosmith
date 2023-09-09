import 'package:dartz/dartz.dart';

import '../../data/callbacks.dart';
import '../../data/failure.dart';

abstract class FirestoreRepository<T> {
  Future<Either<Failure, T>> getData(String documentId);
  Future<Either<Failure, void>> putData(T data,
      {String? documentId,
      required OnSuccessCallbackListener onSuccessCallbackListener});
  Future<Either<Failure, void>> updateData(String documentId, T data,
      {required OnSuccessCallbackListener onSuccessCallbackListener});
}
