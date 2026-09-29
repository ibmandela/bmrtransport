import 'package:hive/hive.dart';
import 'package:site_bmr_transport/services/hive/hive_database.dart';

class ActivitiesBox {
  static Box myCarBox = Hive.box<MyCar>("cars");
  static Box myCategoryBox = Hive.box<MyCategory>("categories");
  static Box currentUserBox = Hive.box<MyUser>("currentUser");
  static Box orderBox = Hive.box<Order>("order");
  static Box cartBox = Hive.box<MyCart>("cart");
  static Box catePriceBox = Hive.box<CatePrice>("catePrice");

  static Future<void> initBox() async {
    String path = "/assets/db";
    Hive.registerAdapter(MyCarAdapter());
    Hive.registerAdapter(MyCategoryAdapter());
    Hive.registerAdapter(MyUserAdapter());
    Hive.registerAdapter(OrderAdapter());
    Hive.registerAdapter(MyCartAdapter());
    Hive.registerAdapter(CatePriceAdapter());
    Hive.init(path);
    await Hive.openBox<MyCar>("cars");
    await Hive.openBox<MyCategory>("categories");
    await Hive.openBox<MyUser>("currentUser");
    await Hive.openBox<Order>("order");
    await Hive.openBox<MyCart>("cart");
    await Hive.openBox<CatePrice>("catePrice");
  }
  // gerer les categories

  static Future<void> addtoBox(data, Box box) {
    return box.put(data.id, data);
  }

  static Future<void> deleteFromBox(String id, Box box) {
    return box.delete(id);
  }
}
