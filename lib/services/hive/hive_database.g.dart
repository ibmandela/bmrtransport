// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyCarAdapter extends TypeAdapter<MyCar> {
  @override
  final int typeId = 0;

  @override
  MyCar read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyCar(
      id: fields[0] as String,
      name: fields[1] as String,
      category: fields[2] as String,
      imgUrl: (fields[3] as List).cast<String>(),
      description: fields[4] as String,
      placeNumber: fields[5] as int,
      suitcaseNumber: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MyCar obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.imgUrl)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.placeNumber)
      ..writeByte(6)
      ..write(obj.suitcaseNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyCarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MyCategoryAdapter extends TypeAdapter<MyCategory> {
  @override
  final int typeId = 1;

  @override
  MyCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyCategory(
      id: fields[0] as String,
      name: fields[1] as String,
      imgUrl: fields[2] as String,
      prices: (fields[3] as List).cast<CatePrice>(),
      description: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MyCategory obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.imgUrl)
      ..writeByte(3)
      ..write(obj.prices)
      ..writeByte(4)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MyUserAdapter extends TypeAdapter<MyUser> {
  @override
  final int typeId = 2;

  @override
  MyUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyUser(
      id: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      email: fields[3] as String,
      phoneNumber: fields[4] as String,
      address: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MyUser obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrderAdapter extends TypeAdapter<Order> {
  @override
  final int typeId = 3;

  @override
  Order read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Order(
      id: fields[0] as String,
      departureDate: fields[1] as DateTime,
      costumerName: fields[2] as String,
      costumerPhone: fields[3] as String,
      departureAddress: fields[4] as String,
      steps: (fields[5] as List).cast<String>(),
      personNumber: fields[6] as int,
      suitcaseNumber: fields[7] as int,
      status: fields[8] as String,
      vehicule: fields[9] as String,
      price: fields[10] as double,
      carImages: (fields[11] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.departureDate)
      ..writeByte(2)
      ..write(obj.costumerName)
      ..writeByte(3)
      ..write(obj.costumerPhone)
      ..writeByte(4)
      ..write(obj.departureAddress)
      ..writeByte(5)
      ..write(obj.steps)
      ..writeByte(6)
      ..write(obj.personNumber)
      ..writeByte(7)
      ..write(obj.suitcaseNumber)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.vehicule)
      ..writeByte(10)
      ..write(obj.price)
      ..writeByte(11)
      ..write(obj.carImages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PayWayAdapter extends TypeAdapter<PayWay> {
  @override
  final int typeId = 4;

  @override
  PayWay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PayWay(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      type: fields[2] as String,
      amount: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, PayWay obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PayWayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MyCartAdapter extends TypeAdapter<MyCart> {
  @override
  final int typeId = 5;

  @override
  MyCart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyCart(
      id: fields[0] as String,
      userId: fields[2] as String,
      order: (fields[3] as List).cast<Order>(),
      description: fields[4] as String,
      totalPrice: fields[5] as double,
      discount: fields[6] as double,
      commission: fields[7] as double,
      payWay: (fields[8] as List).cast<PayWay>(),
      commandeDate: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MyCart obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.commandeDate)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.order)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.totalPrice)
      ..writeByte(6)
      ..write(obj.discount)
      ..writeByte(7)
      ..write(obj.commission)
      ..writeByte(8)
      ..write(obj.payWay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyCartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CatePriceAdapter extends TypeAdapter<CatePrice> {
  @override
  final int typeId = 7;

  @override
  CatePrice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CatePrice(
      departure: fields[0] as String,
      arrival: fields[1] as String,
      price: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CatePrice obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.departure)
      ..writeByte(1)
      ..write(obj.arrival)
      ..writeByte(2)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatePriceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
