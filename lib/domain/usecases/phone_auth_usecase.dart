// import 'package:dartz/dartz.dart';

// import '../../data/failure.dart';
// import '../repositories/firebase_auth_repository.dart';

// class PhoneAuthUseCase {
//   final FirebaseAuthRepository firebaseAuthRepository;
//   const PhoneAuthUseCase({required this.firebaseAuthRepository});

//   bool get isLoggedIn => firebaseAuthRepository.isLoggedIn;

//   Future<Either<Failure, bool>> signInUser() async {
//     return credential.fold((l) => Left(l),
//         (r) async => await firebaseAuthRepository.linkWithFirebase(r));
//   }
// }
