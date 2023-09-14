class FirebaseCodeResponse {
  final String phoneNumber;
  final String verificationId;
  final int? resendToken;
  FirebaseCodeResponse(
      {required this.phoneNumber,
      required this.verificationId,
      required this.resendToken});
}
