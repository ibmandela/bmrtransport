import 'package:flutter/material.dart';
import 'package:site_bmr_transport/categoryView.dart';
import 'package:site_bmr_transport/screens/menus/car.dart';
import 'package:site_bmr_transport/screens/menus/information.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Categoryview();
  }
}
