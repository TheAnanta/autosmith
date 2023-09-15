import 'package:equatable/equatable.dart';

class AutomobileVariant extends Equatable {
  final int id;
  final String variant;
  final String manufactureYear;

  const AutomobileVariant({
    required this.id,
    required this.variant,
    required this.manufactureYear,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [id,variant];
}
