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
  List<Object?> get props => [id, variant];

  factory AutomobileVariant.fromJson(Map<String, dynamic> json) {
    return AutomobileVariant(
        id: json["id"],
        variant: json["variant"],
        manufactureYear: json["manufactureYear"]);
  }
  Map<String, dynamic> toJson() {
    return {"id": id, "variant": variant, "manufactureYear": manufactureYear};
  }
}
