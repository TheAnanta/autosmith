import 'package:autosmith/domain/enums/automobile_brand.dart';
import 'package:autosmith/domain/enums/automobile_variants.dart';

const List<AutomobileBrand> cars = [
  AutomobileBrand(
    id: 0,
    name: 'Audi',
    cover: 'https://www.freepnglogos.com/uploads/audi-logo-2.png',
    variants: [
      AutomobileVariant(
        id: 0,
        variant: 'Audi R8',
        manufactureYear: '2003',
      )
    ],
  ),
  AutomobileBrand(
    id: 1,
    name: 'Mercedes Benz',
    cover: 'https://www.freepnglogos.com/uploads/audi-logo-2.png',
    variants: [
      AutomobileVariant(
          id: 1, variant: 'Benz Bolwalski', manufactureYear: '2003')
    ],
  ),
  AutomobileBrand(
    id: 2,
    name: 'Rolls Royce',
    cover: 'https://www.freepnglogos.com/uploads/audi-logo-2.png',
    variants: [
      AutomobileVariant(
          id: 2, variant: 'Royce Phantom', manufactureYear: '2003')
    ],
  ),
  AutomobileBrand(
    id: 3,
    name: 'Ford',
    cover: 'https://www.freepnglogos.com/uploads/audi-logo-2.png',
    variants: [
      AutomobileVariant(id: 3, variant: 'Ford Mustang', manufactureYear: '2003')
    ],
  ),
  AutomobileBrand(
    id: 4,
    name: 'Tata',
    cover: 'https://www.freepnglogos.com/uploads/audi-logo-2.png',
    variants: [
      AutomobileVariant(id: 4, variant: 'Tata Nano', manufactureYear: '2003')
    ],
  ),
];

const List<AutomobileBrand> bikes = [
  AutomobileBrand(
    id: 5,
    name: 'Royal Enfield',
    cover:
        'https://m.media-amazon.com/images/I/61+gxqqO8LL._AC_UF1000,1000_QL80_.jpg',
    variants: [
      AutomobileVariant(id: 5, variant: 'Hunter 350', manufactureYear: '2020'),
    ],
  ),
  AutomobileBrand(
    id: 6,
    name: 'BMW',
    cover:
        'https://m.media-amazon.com/images/I/61+gxqqO8LL._AC_UF1000,1000_QL80_.jpg',
    variants: [
      AutomobileVariant(
          id: 6, variant: 'Interceptor 350', manufactureYear: '2023'),
    ],
  ),
  AutomobileBrand(
    id: 7,
    name: 'Bajaj',
    cover:
        'https://m.media-amazon.com/images/I/61+gxqqO8LL._AC_UF1000,1000_QL80_.jpg',
    variants: [
      AutomobileVariant(id: 7, variant: 'GT Twin', manufactureYear: '2023'),
    ],
  ),
  AutomobileBrand(
    id: 8,
    name: 'Honda',
    cover:
        'https://m.media-amazon.com/images/I/61+gxqqO8LL._AC_UF1000,1000_QL80_.jpg',
    variants: [
      AutomobileVariant(id: 8, variant: 'Bullet 350', manufactureYear: '2017'),
    ],
  ),
];
