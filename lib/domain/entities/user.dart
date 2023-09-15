import 'package:equatable/equatable.dart';

import '../enums/social_platforms.dart';

class User extends Equatable {
  final String name;
  final String? email;
  final String? phone;
  final String? image;

  const User({
    required this.name,
    this.email,
    this.phone,
    this.image,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
