import 'package:site_bmr_transport/services/hive/hive_database.dart';

// List<MyCar> myCars = [
//   MyCar(
//     id: '1',
//     name: 'Mercedes-Benz Maybach',
//     category: 'Luxury',
//     imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC5qHdx6GpJaEpHu-OfGoueAvI1CJIIADA2bPSLJFCEg&s=10",
//     description: 'La Mercedes-Benz Maybach est une berline de luxe haut de gamme qui allie performance, confort et technologies avancées. Elle offre un habitacle spacieux, des matériaux de grande qualité et une gamme de motorisations puissantes.',
//     placeNumber: 5,
//     suitcaseNumber: 4,
//   ),
//   MyCar(
//     id: '2',
//     name: 'Mercedes-Benz Class-S',
//     category: 'Luxury',
//     imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVQWVwuAgu5uIrjexjjuSN79m3k0KfdgVRxvE7rhoq2g&s",
//     description: 'La Mercedes-Benz Classe S est une berline de luxe haut de gamme qui allie performance, confort et technologies avancées. Elle offre un habitacle spacieux, des matériaux de grande qualité et une gamme de motorisations puissantes.',
//     placeNumber: 5,
//     suitcaseNumber: 4,
//   ),
//   MyCar(
//     id: '3',
//     name: 'BMW Série 7',
//     category: 'Luxury',
//     imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNH9WJfhSNp8EWCuQROoF-U8HPJuy0enKJxTrjPZXG7Q&s=10",
//     description: 'La BMW Série 7 est une berline de luxe haut de gamme qui allie performance, confort et technologies avancées. Elle offre un habitacle spacieux, des matériaux de grande qualité et une gamme de motorisations puissantes.',
//     placeNumber: 5,
//     suitcaseNumber: 4,
//   ),
//   MyCar(
//     category: 'SUV',
//     id: '4',
//     name: 'Lexus RX',
//     imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTH0E88k0m6gqtc99Kj3cMn-pCXwKJNZOtSO7pTMvm6aQ&s=10",
//     description: 'Le Lexus RX est un SUV de luxe qui allie performance, confort et technologies avancées. Il offre un habitacle spacieux, des matériaux de grande qualité et une gamme de motorisations puissantes.',
//     placeNumber: 5,
//     suitcaseNumber: 4,
//   ),
//   MyCar(
//     category: 'SUV',
//     id: '5',
//     name: 'Tesla Model Y',
//     imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTN2hMPD6k6ofM-Mdc8_6C1FSa9iTyLBN5fOmqYEukPaw&s=10",
//     description: 'Le Tesla Model Y est un SUV de luxe qui allie performance, confort et technologies avancées. Il offre un habitacle spacieux, des matériaux de grande qualité et une gamme de motorisations puissantes.',
//     placeNumber: 5,
//     suitcaseNumber: 4,
//   ),
//   MyCar(
//     category: 'SUV',
//     id: '6',
//     name: 'Toyota Bz4X',
//     imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSNMgqLBSxaIqxMA0G2wumH_f15mUQpMGgkqIIgVPxaQ&s=10",
//     description: 'Le Toyota Bz4X est un SUV de luxe qui allie performance, confort et technologies avancées. Il offre un habitacle spacieux, des matériaux de grande qualité et une gamme de motorisations puissantes.',
//     placeNumber: 5,
//     suitcaseNumber: 4,
//   ),
//   MyCar(
//     category: 'van',
//     id: '7',
//     name: 'Mercedes-Benz Maybach Classe V',
//     imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6-ZYztNvo4TIzII3pY2E7MUgqN5V26wouiUwlLY1-qw&s=10",
//     description: 'Le Mercedes-Benz Maybach Classe V est un van de luxe qui allie performance, confort et technologies avancées. Il offre un habitacle spacieux, des matériaux de grande qualité et une gamme de motorisations puissantes.',
//     placeNumber: 8,
//     suitcaseNumber: 6,
//   ),
//   MyCar(
//     category: 'van',
//     id: '8',
//     name: 'Mercedes-Benz Classe V',
//     imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_vEio4NQ0TjhjU6coxmypF2eXz34XrpaDN3xbtGK8eg&s=10",
//     description: 'Le Mercedes-Benz Classe V est un van de luxe qui allie performance, confort et technologies avancées. Il offre un habitacle spacieux, des matériaux de grande qualité et une gamme de motorisations puissantes.',
//     placeNumber: 8,
//     suitcaseNumber: 6,
//   ),
//   MyCar(
//     category: 'van',
//     id: '9',
//     name: 'Kia Carnival',
//     imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDMNXphN_Po-9jvmTcxyq8bAfJ1v-lqOc7C1jXK6HS5Q&s",
//     description: 'Le Kia Carnival est un van de luxe qui allie performance, confort et technologies avancées. Il offre un habitacle spacieux, des matériaux de grande qualité et une gamme de motorisations puissantes.',
//     placeNumber: 8,
//     suitcaseNumber: 6,
//   ),
// ];

// List<MyCategory> myCategorys = [
//   MyCategory(
//     id: '1',
//     name: 'Luxury',
//     imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC5qHdx6GpJaEpHu-OfGoueAvI1CJIIADA2bPSLJFCEg&s=10",
//     prices: [
//       CatePrice(departure: 'paris', arrival: 'banlieue', price: 150.0),
//       CatePrice(departure: 'banlieue', arrival: 'paris', price: 150.0),
//       CatePrice(departure: 'paris', arrival: 'province', price: 200.0),
//       CatePrice(departure: 'banlieue', arrival: 'province', price: 200.0),
//     ],

//     description: 'La catégorie "Luxury" regroupe des véhicules haut de gamme offrant un confort exceptionnel, des performances supérieures et des technologies avancées. Ces voitures sont conçues pour les conducteurs recherchant une expérience de conduite raffinée et prestigieuse.',
//   ),
//   MyCategory(
//     id: '2',
//     name: 'SUV',
//     imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTH0E88k0m6gqtc99Kj3cMn-pCXwKJNZOtSO7pTMvm6aQ&s=10",
//     prices: [
//       CatePrice(departure: 'paris', arrival: 'banlieue', price: 120.0),
//       CatePrice(departure: 'banlieue', arrival: 'paris', price: 120.0),
//       CatePrice(departure: 'paris', arrival: 'province', price: 180.0),
//       CatePrice(departure: 'banlieue', arrival: 'province', price: 180.0),
//     ],
//     description: 'La catégorie "SUV" regroupe des véhicules polyvalents et robustes, idéaux pour les déplacements en famille ou les aventures hors route.',
//   ),
//   MyCategory(
//     id: '3',
//     name: 'van',
//     imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6-ZYztNvo4TIzII3pY2E7MUgqN5V26wouiUwlLY1-qw&s=10",
//     prices: [
//       CatePrice(departure: 'paris', arrival: 'banlieue', price: 100.0),
//       CatePrice(departure: 'banlieue', arrival: 'paris', price: 100.0),
//       CatePrice(departure: 'paris', arrival: 'province', price: 150.0),
//       CatePrice(departure: 'banlieue', arrival: 'province', price: 150.0),
//     ],
//     description: 'La catégorie "van" regroupe des véhicules spacieux et pratiques, parfaits pour les besoins de transport de personnes ou de marchandises.',
//   ),
// ];

/// Codes postaux des départements d'Île-de-France, hors Paris (75).
/// Les codes sont générés à partir des tranches départementales.
final List<String> banlieue = [
  for (final department in [77, 78, 91, 92, 93, 94, 95])
    for (var code = 0; code <= 999; code++)
      '${department.toString().padLeft(2, '0')}${code.toString().padLeft(3, '0')}',
];
final List<String> paris = [
  for (var code = 0; code <= 999; code++)
    '75${code.toString().padLeft(3, '0')}',
];

/// Codes postaux des autres départements de France métropolitaine.
final List<String> province = [
  for (final department in [
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
    21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37,
    38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54,
    55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71,
    72, 73, 74, 76, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90,
    //  900,
    // 901, 902, 903, 904, 905, 906, 907, 908, 909, 910, 911, 912, 913, 914,
    // 915, 916, 917, 918, 919, 920, 921, 922, 923, 924, 925, 926, 927, 928,
    // 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942,
    // 943, 944, 945, 946, 947, 948, 949, 950, 951, 952, 953, 954, 955, 956,
    // 957, 958, 959,
  ])
    for (var code = 0; code <= 999; code++)
      '${department.toString().padLeft(2, '0')}${code.toString().padLeft(3, '0')}',
  for (var code = 0; code <= 999; code++) '2${code.toString().padLeft(4, '0')}',
];
const secretKey =
    "sk_test_51UIjXvFoJhLIcIwMLp3dYXo6hwy1b0QlwSKJFp4NwCdrOjRzZDEjdolOwyJ3OQRBBPlUCuAWwaRMTKdqxJdloNCq00wRZ0o4Ox";
String publicKey =
    "pk_test_51UIjXvFoJhLIcIwMRlSnnjX4Sv0wSYeZqUrJlF5m0u9dlzKmEyiIwuxkgM8uZJgvxbZIudKwo6DFw0wq2plXz3zt00eTFMKiAx";
