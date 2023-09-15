import 'package:autosmith/domain/enums/automobile_variants.dart';
import 'package:equatable/equatable.dart';

class AutomobileBrand extends Equatable {
  final int id;
  final String name;
  final String cover;
  final List<AutomobileVariant> variants;

  const AutomobileBrand({
    required this.id,
    required this.name,
    required this.cover,
    required this.variants,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [id,name];

  get isNotEmpty => null;
}
