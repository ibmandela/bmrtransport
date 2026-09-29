import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:site_bmr_transport/common/data.dart';
import 'package:site_bmr_transport/firebase_options.dart';
import 'package:site_bmr_transport/screens/home.dart';
import 'package:site_bmr_transport/services/hive/hiveBoxe.dart';
import 'package:site_bmr_transport/services/hive/hive_database.dart';
import 'package:site_bmr_transport/services/stripe/payment_cancel.dart';
import 'package:site_bmr_transport/services/stripe/payment_success.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ActivitiesBox.initBox().then((e) {
    ActivitiesBox.myCarBox.put(
      "current",
      MyCar(
        id: '1',
        name: 'Mercedes-Benz Maybach',
        category: 'Luxury',
        imgUrl: [
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC5qHdx6GpJaEpHu-OfGoueAvI1CJIIADA2bPSLJFCEg&s=10",
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzTuzQmyYmqCD5MPbhTm5x2xlAI_xXmIJopY4i1c77xQ&s=10",
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmNqYuQ-w9Tv_oDWp927xgP_DauB0GODxpVZi60ckaKQ&s=10",
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4a5bzNHwdxuq0mj2QSr5mX3KPP6FHNS1LPozTV7_Umw&s",
        ],
        description: 'La Mercedes-Benz Maybach est une berline de luxe haut de gamme qui allie performance, confort et technologies avancées. Elle offre un habitacle spacieux, des matériaux de grande qualité et une gamme de motorisations puissantes.',
        placeNumber: 5,
        suitcaseNumber: 4,
      ),
    );
    ActivitiesBox.myCategoryBox.put(
      "current",
      MyCategory(
        id: '1',
        name: 'Luxury',
        imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC5qHdx6GpJaEpHu-OfGoueAvI1CJIIADA2bPSLJFCEg&s=10",
        prices: [
          CatePrice(departure: 'paris', arrival: 'banlieue', price: 150.0),
          CatePrice(departure: 'banlieue', arrival: 'paris', price: 150.0),
          CatePrice(departure: 'paris', arrival: 'province', price: 200.0),
          CatePrice(departure: 'banlieue', arrival: 'province', price: 200.0),
        ],
        description: 'Véhicules de luxe offrant confort et performance.',
      ),
    );
  });
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = publicKey;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/success': (context) => PaymentSuccessPage(),
        '/cancel': (context) => PaymentCancelPage(),
      },
      home: Scaffold(
        body: MyHome(),

        // MyHome()
      ),
    );
  }
}
