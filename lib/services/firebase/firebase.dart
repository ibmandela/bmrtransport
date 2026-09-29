import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:site_bmr_transport/services/hive/hiveBoxe.dart';
import 'package:site_bmr_transport/services/hive/hive_database.dart';

class FireServices {
  // Add your Firebase service methods here

  // Example: Get articles from Firestore
  static Stream<List<MyCar>> getCarStream() {
    // Import 'package:cloud_firestore/cloud_firestore.dart' in your file
    return FirebaseFirestore.instance
        .collection('Cars')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => MyCar.fromFirestore(doc)).toList(),
        );
  }

  static Stream<QuerySnapshot> getCarByCategory(String category) {
    // Import 'package:cloud_firestore/cloud_firestore.dart' in your file
    return FirebaseFirestore.instance
        .collection('Cars')
        .where("Categories", isEqualTo: category)
        .snapshots();
  }

  static Stream<List<MyCategory>> getCategoryStream() {
    // Import 'package:cloud_firestore/cloud_firestore.dart' in your file
    try {
      return FirebaseFirestore.instance
          .collection('Categories')
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => MyCategory.fromFirestore(doc))
                .toList(),
          );
    } on FirebaseException catch (e) {
      print("Error fetching categories: $e");
      return Stream.empty(); // Return an empty stream on error
    }
  }

  // For example, you can add methods to fetch data from Firestore, upload files to Firebase Storage, etc.

  // manage commande
  static Future<void> addCommande(MyCart commande) async {
    try {
      return await FirebaseFirestore.instance
          .collection('Commandes')
          .doc(commande.id)
          .set(MyCart.toJson(commande))
          .then((doc) {
            ActivitiesBox.addtoBox(commande, ActivitiesBox.cartBox);
            ActivitiesBox.cartBox.clear();
          });
    } catch (e) {
      print("Error adding commande: $e");
      throw e; // Rethrow the error for further handling
    }
  }

  static Future<void> addToUserColl({
    required MyCart commande,
    required String userId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Commandes')
          .doc(commande.id)
          .set(MyCart.toJson(commande));
    } catch (e) {
      print("Error adding commande: $e");
      throw e; // Rethrow the error for further handling
    }
  }

  // get user by id
  static Future<DocumentSnapshot> getUserById(String userId) async {
    try {
      return await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();
    } catch (e) {
      print("Error fetching user: $e");
      throw e; // Rethrow the error for further handling
    }
  }

  static Future<void> addtofire(List<MyCar> cars, List<MyCategory> cate) async {
    // for (var car in cars) {
    //   await FirebaseFirestore.instance
    //       .collection('Cars')
    //       .add(MyCar.toJson(car));
    //   print("car");
    // }
    for (var ca in cate) {
      await FirebaseFirestore.instance
          .collection('Categories')
          .add(MyCategory.toJson(ca));
      print("cate");
    }
    // }
  }
}
