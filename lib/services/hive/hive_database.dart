import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'hive_database.g.dart';

//Definie car models
@HiveType(typeId: 0)
class MyCar {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String category;
  @HiveField(3)
  final List<String> imgUrl;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final int placeNumber;
  @HiveField(6)
  final int suitcaseNumber;

  MyCar({
    required this.id,
    required this.name,
    required this.category,
    required this.imgUrl,
    required this.description,
    required this.placeNumber,
    required this.suitcaseNumber,
  });

  factory MyCar.fromFirestore(DocumentSnapshot doc) {
    return MyCar(
      id: doc.id,
      name: doc['name'] as String,
      category: doc['category'] as String,
      imgUrl: List<String>.from(doc['imgUrl'] as List<dynamic>),
      description: doc['description'] as String,
      placeNumber: doc['placeNumber'] as int,
      suitcaseNumber: doc['suitcaseNumber'] as int,
    );
  }

  factory MyCar.fromJson(Map<dynamic, dynamic> doc) {
    return MyCar(
      id: doc["id"],
      name: doc['name'] as String,
      category: doc['category'] as String,
      imgUrl: List<String>.from(doc['imgUrl'] as List<dynamic>),
      description: doc['description'] as String,
      placeNumber: doc['placeNumber'] as int,
      suitcaseNumber: doc['suitcaseNumber'] as int,
    );
  }

  static Map<String, dynamic> toJson(MyCar car) {
    return {
      'id': car.id,
      'name': car.name,
      'category': car.category,
      'imgUrl': car.imgUrl,
      'description': car.description,
      'placeNumber': car.placeNumber,
      'suitcaseNumber': car.suitcaseNumber,
    };
  }
}

// Define Category class with fields and constructor, or remove if not needed
@HiveType(typeId: 1)
class MyCategory {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String imgUrl;
  @HiveField(3)
  final List<CatePrice> prices;
  @HiveField(4)
  final String description;

  MyCategory({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.prices,
    required this.description,
  });
  factory MyCategory.fromFirestore(DocumentSnapshot doc) {
    return MyCategory(
      id: doc.id,
      name: doc['name'] as String,
      imgUrl: doc['imgUrl'] as String,
      prices: (doc['prices'] as List<dynamic>)
          .map((e) => CatePrice.fromJson(e as Map<dynamic, dynamic>))
          .toList(),
      description: doc['description'] as String,
    );
  }

  // }
  factory MyCategory.fromJson(Map<dynamic, dynamic> doc) {
    return MyCategory(
      id: doc["id"],
      name: doc['name'] as String,
      imgUrl: doc['imgUrl'] as String,
      prices: (doc['prices'] as List<dynamic>)
          .map((e) => CatePrice.fromJson(e as Map<dynamic, dynamic>))
          .toList(),
      description: doc['description'] as String,
    );
  }

  static Map<String, dynamic> toJson(MyCategory category) {
    return {
      'id': category.id,
      'name': category.name,
      'imgUrl': category.imgUrl,
      'prices': category.prices.map((e) => CatePrice.toJson(e)).toList(),
      'description': category.description,
    };
  }
}

// Define user class with fields and constructor, or remove if not needed
@HiveType(typeId: 2)
class MyUser {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String phoneNumber;
  @HiveField(5)
  final String address;

  MyUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  factory MyUser.fromJson(Map<dynamic, dynamic> doc) {
    return MyUser(
      id: doc["id"],
      firstName: doc['firstName'] as String,
      lastName: doc['lastName'] as String,
      email: doc['email'] as String,
      phoneNumber: doc['phoneNumber'] as String,
      address: doc['address'] as String,
    );
  }

  static Map<String, dynamic> toJson(MyUser user) {
    return {
      'firstName': user.firstName,
      'lastName': user.lastName,
      'email': user.email,
      'phoneNumber': user.phoneNumber,
      'address': user.address,
    };
  }

  factory MyUser.fromFirestore(DocumentSnapshot doc) {
    return MyUser(
      id: doc.id,
      firstName: doc['firstName'] as String,
      lastName: doc['lastName'] as String,
      email: doc['email'] as String,
      phoneNumber: doc['phoneNumber'] as String,
      address: doc['address'] as String,
    );
  }
}

@HiveType(typeId: 3)
class Order {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final DateTime departureDate;
  @HiveField(2)
  final String costumerName;
  @HiveField(3)
  final String costumerPhone;
  @HiveField(4)
  final String departureAddress;
  @HiveField(5)
  final List<String> steps;
  @HiveField(6)
  final int personNumber;
  @HiveField(7)
  final int suitcaseNumber;
  @HiveField(8)
  final String status;
  @HiveField(9)
  final String vehicule;
  @HiveField(10)
  final double price;
  @HiveField(11)
  final List<String> carImages;

  Order({
    required this.id,
    required this.departureDate,
    required this.costumerName,
    required this.costumerPhone,
    required this.departureAddress,
    required this.steps,
    required this.personNumber,
    required this.suitcaseNumber,
    required this.status,
    required this.vehicule,
    required this.price,
    required this.carImages,
  });

  factory Order.fromJson(Map<dynamic, dynamic> doc) {
    return Order(
      id: doc["id"],
      departureDate: DateTime.parse(doc['departureDate'] as String),
      costumerName: doc['costumerName'] as String,
      costumerPhone: doc['costumerPhone'] as String,
      departureAddress: doc['departureAddress'] as String,
      steps: List<String>.from(doc['steps'] as List<dynamic>),
      personNumber: doc['personNumber'] as int,
      suitcaseNumber: doc['suitcaseNumber'] as int,
      status: doc['status'] as String,
      vehicule: doc['vehicule'] as String,
      price: doc['price'] as double,
      carImages: doc['carImages'],
    );
  }
  factory Order.fromFirestore(DocumentSnapshot doc) {
    return Order(
      id: doc.id,
      departureDate: (doc['departureDate'] as Timestamp).toDate(),
      costumerName: doc['costumerName'] as String,
      costumerPhone: doc['costumerPhone'] as String,
      departureAddress: doc['departureAddress'] as String,
      steps: List<String>.from(doc['steps'] as List<dynamic>),
      personNumber: doc['personNumber'] as int,
      suitcaseNumber: doc['suitcaseNumber'] as int,
      status: doc['status'] as String,
      vehicule: doc['vehicule'] as String,
      price: doc['price'] as double,
      carImages: [],
    );
  }

  static Map<String, dynamic> toFirestore(Order order) {
    return {
      'departureDate': order.departureDate,
      'costumerName': order.costumerName,
      'costumerPhone': order.costumerPhone,
      'departureAddress': order.departureAddress,
      'steps': order.steps,
      'personNumber': order.personNumber,
      'suitcaseNumber': order.suitcaseNumber,
      'status': order.status,
      'vehicule': order.vehicule,
      'price': order.price,
    };
  }

  static Map<String, dynamic> toJson(Order order) {
    return {
      'departureDate': order.departureDate,
      'costumerName': order.costumerName,
      'costumerPhone': order.costumerPhone,
      'departureAddress': order.departureAddress,
      'steps': order.steps,
      'personNumber': order.personNumber,
      'suitcaseNumber': order.suitcaseNumber,
      'status': order.status,
      'vehicule': order.vehicule,
      'price': order.price,
      'carImages': order.carImages,
    };
  }
}

@HiveType(typeId: 4)
class PayWay {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final String type;
  @HiveField(3)
  final double amount;

  PayWay({
    required this.id,
    required this.date,
    required this.type,
    required this.amount,
  });

  factory PayWay.fromJson(Map<dynamic, dynamic> doc) {
    return PayWay(
      id: doc['id'] as String,
      date: (doc['date'] as Timestamp).toDate(),
      type: doc['type'] as String,
      amount: doc['amount'] as double,
    );
  }
  static Map<String, dynamic> toJson(PayWay payWay) {
    return {
      'id': payWay.id,
      'date': payWay.date,
      'type': payWay.type,
      'amount': payWay.amount,
    };
  }
}

@HiveType(typeId: 5)
class MyCart {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final DateTime commandeDate;
  @HiveField(2)
  final String userId;
  @HiveField(3)
  final List<Order> order;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final double totalPrice;
  @HiveField(6)
  final double discount;
  @HiveField(7)
  final double commission;
  @HiveField(8)
  final List<PayWay> payWay;

  MyCart({
    required this.id,
    required this.userId,
    required this.order,
    required this.description,
    required this.totalPrice,
    required this.discount,
    required this.commission,
    required this.payWay,
    required this.commandeDate,
  });

  factory MyCart.fromJson(Map<dynamic, dynamic> doc) {
    return MyCart(
      id: doc["id"],
      commandeDate: (doc['commandeDate'] as Timestamp).toDate(),
      userId: doc['userId'] as String,
      order: (doc['order'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<dynamic, dynamic>))
          .toList(),
      description: doc['description'] as String,
      totalPrice: doc['totalPrice'] as double,
      discount: doc['discount'] as double,
      commission: doc['commission'] as double,
      payWay: (doc['payWay'] as List<dynamic>)
          .map((e) => PayWay.fromJson(e as Map<dynamic, dynamic>))
          .toList(),
    );
  }

  factory MyCart.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MyCart(
      id: doc.id,
      commandeDate: (data['commandeDate'] as Timestamp).toDate(),
      userId: data['userId'] as String,
      order: (data['order'] as List<dynamic>)
          .map((item) => Order.fromJson(item as Map<dynamic, dynamic>))
          .toList(),
      description: data['description'] as String,
      totalPrice: (data['totalPrice'] as num).toDouble(),
      discount: (data['discount'] as num).toDouble(),
      commission: (data['commission'] as num).toDouble(),
      payWay: (data['payWay'] as List<dynamic>)
          .map((item) => PayWay.fromJson(item as Map<dynamic, dynamic>))
          .toList(),
    );
  }
  static Map<String, Object> myCartToFirestore(MyCart cart) {
    return {
      'id': cart.id,
      'userId': cart.userId,
      'commandeDate': cart.commandeDate,
      'order': cart.order.map((order) => Order.toFirestore(order)).toList(),
      'description': cart.description,
      'totalPrice': cart.totalPrice,
      'discount': cart.discount,
      'commission': cart.commission,
      'payWay': cart.payWay.map((e) => PayWay.toJson(e)).toList(),
    };
  }

  static Map<String, dynamic> toJson(MyCart cart) {
    return {
      'id': cart.id,
      'userId': cart.userId,
      'commandeDate': cart.commandeDate,
      'order': cart.order.map((order) => Order.toJson(order)).toList(),
      'description': cart.description,
      'totalPrice': cart.totalPrice,
      'discount': cart.discount,
      'commission': cart.commission,
      'payWay': cart.payWay.map((e) => PayWay.toJson(e)).toList(),
    };
  }
}

@HiveType(typeId: 7)
class CatePrice {
  @HiveField(0)
  final String departure;
  @HiveField(1)
  final String arrival;
  @HiveField(2)
  final double price;

  CatePrice({
    required this.departure,
    required this.arrival,
    required this.price,
  });

  factory CatePrice.fromJson(Map<dynamic, dynamic> doc) {
    return CatePrice(
      departure: doc['departure'] as String,
      arrival: doc['arrival'] as String,
      price: doc['price'] as double,
    );
  }

  static Map<String, dynamic> toJson(CatePrice catePrice) {
    return {
      'departure': catePrice.departure,
      'arrival': catePrice.arrival,
      'price': catePrice.price,
    };
  }
}
