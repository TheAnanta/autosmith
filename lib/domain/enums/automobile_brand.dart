import 'package:autosmith/domain/enums/automobile_variants.dart';

class AutomobileBrand {
  final String name;
  final cover;
  final List<AutomobileVariant> variants;

  const AutomobileBrand({
    required this.name,
    required this.cover,
    required this.variants,
  });
}
