import 'package:autosmith/domain/enums/automobile_brand.dart';
import 'package:autosmith/domain/enums/automobile_variants.dart';

const List<AutomobileBrand> cars = [
  AutomobileBrand(
    name: 'Audi',
    cover: 'https://www.freepnglogos.com/uploads/audi-logo-2.png',
    variants: [AutomobileVariant(variant: 'Audi R8', manufactureYear: '2003')],
  ),
  AutomobileBrand(
    name: 'Mercedes Benz',
    cover: 'https://www.freepnglogos.com/uploads/audi-logo-2.png',
    variants: [
      AutomobileVariant(variant: 'Benz Bolwalski', manufactureYear: '2003')
    ],
  ),
  AutomobileBrand(
    name: 'Rolls Royce',
    cover: 'https://www.freepnglogos.com/uploads/audi-logo-2.png',
    variants: [
      AutomobileVariant(variant: 'Royce Phantom', manufactureYear: '2003')
    ],
  ),
  AutomobileBrand(
    name: 'Ford',
    cover: 'https://www.freepnglogos.com/uploads/audi-logo-2.png',
    variants: [
      AutomobileVariant(variant: 'Ford Mustang', manufactureYear: '2003')
    ],
  ),
  AutomobileBrand(
    name: 'Tata',
    cover: 'https://www.freepnglogos.com/uploads/audi-logo-2.png',
    variants: [
      AutomobileVariant(variant: 'Tata Nano', manufactureYear: '2003')
    ],
  ),
];

const List<AutomobileBrand> bikes = [
  AutomobileBrand(
    name: 'Royal Enfield',
    cover:
        'https://m.media-amazon.com/images/I/61+gxqqO8LL._AC_UF1000,1000_QL80_.jpg',
    variants: [
      AutomobileVariant(variant: 'Hunter 350', manufactureYear: '2020'),
    ],
  ),
  AutomobileBrand(
    name: 'BMW',
    cover:
        'https://m.media-amazon.com/images/I/61+gxqqO8LL._AC_UF1000,1000_QL80_.jpg',
    variants: [
      AutomobileVariant(variant: 'Interceptor 350', manufactureYear: '2023'),
    ],
  ),
  AutomobileBrand(
    name: 'Bajaj',
    cover:
        'https://m.media-amazon.com/images/I/61+gxqqO8LL._AC_UF1000,1000_QL80_.jpg',
    variants: [
      AutomobileVariant(variant: 'GT Twin', manufactureYear: '2023'),
    ],
  ),
  AutomobileBrand(
    name: 'Honda',
    cover:
        'https://m.media-amazon.com/images/I/61+gxqqO8LL._AC_UF1000,1000_QL80_.jpg',
    variants: [
      AutomobileVariant(variant: 'Bullet 350', manufactureYear: '2017'),
    ],
  ),
];
