import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:site_bmr_transport/common/myAppBar.dart';
import 'package:site_bmr_transport/screens/menus/car.dart';
import 'package:site_bmr_transport/screens/menus/information.dart';
import 'package:site_bmr_transport/services/firebase/firebase.dart';
import 'package:site_bmr_transport/services/hive/hive_database.dart';
import 'package:site_bmr_transport/utils/utils.dart';

class Categoryview extends StatefulWidget {
  const Categoryview({super.key});

  @override
  State<Categoryview> createState() => _CategoryviewState();
}

class _CategoryviewState extends State<Categoryview> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  Timer? _timer;

  String _search = "";
  ValueNotifier<String> _currentMessage = ValueNotifier("Bienvenue au Bazar ");
  Color _currentColor = Colors.blue;
  ValueNotifier<bool> _searching = ValueNotifier(false);
  final List<String> _messages = [
    "Bienvenue chez BMR Transport",
    "Découvrez notre large gamme de véhicules",
    "Profitez de tarifs compétitifs et de services de qualité",
  ];
  final List<Color> _colors = [Colors.blue, Colors.green, Colors.red];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: Myappbar(
          title: "Bienvenue chez BMR Transport",
          onChanged: (newValuer) {},
          bottom: null,
        ),
      ),

      body: StreamBuilder<List<MyCategory>>(
        stream: FireServices.getCategoryStream(),
        builder: (context, categorySnapshot) {
          if (categorySnapshot.hasError) {
            return const Center(
              child: Text('Erreur lors de la lecture des catégories'),
            );
          }
          if (categorySnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return StreamBuilder<List<MyCar>>(
            stream: FireServices.getCarStream(),

            builder: (context, carSnapshot) {
              if (carSnapshot.hasError) {
                return const Center(
                  child: Text('Erreur lors de la lecture des véhicules'),
                );
              }
              if (carSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final categories = categorySnapshot.data ?? [];
              final cars = carSnapshot.data ?? [];

              return SingleChildScrollView(
                child: SizedBox(
                  child: Stack(
                    children: [
                      // Background image slider
                      Positioned.fill(
                        child: PageView(
                          controller: _pageController,
                          children: [
                            Image.asset('assets/first.png', fit: BoxFit.cover),
                            Image.asset('assets/second.png', fit: BoxFit.cover),
                            Image.asset('assets/third.png', fit: BoxFit.cover),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _pageController.animateToPage(
                                    _currentPage = _currentPage - 1,
                                    duration: Duration(milliseconds: 350),
                                    curve: Curves.easeIn,
                                  );
                                },
                                icon: Icon(Icons.arrow_back_ios_new),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                                child: ValueListenableBuilder(
                                  valueListenable: _currentMessage,
                                  builder: (context, value, child) {
                                    return Text(
                                      value,
                                      style: TextStyle(
                                        color: _currentColor,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                            veryBigSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _pageController.animateToPage(
                                    _currentPage = _currentPage + 1,
                                    duration: Duration(milliseconds: 350),
                                    curve: Curves.easeIn,
                                  );
                                },
                                icon: Icon(Icons.arrow_forward_ios),
                              ),
                            ],
                          ),

                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white.withAlpha(0),
                                  Colors.white.withAlpha(2000),
                                ],
                              ),
                              // borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  if (constraints.maxWidth >= 700) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ConstrainedBox(
                                          constraints: const BoxConstraints(
                                            maxWidth: 450,
                                            minWidth: 350,
                                          ),
                                          child: SizedBox(
                                            width: constraints.maxWidth * 0.30,
                                            child: InformationView(),
                                          ),
                                        ),
                                        Expanded(
                                          child: SplitView(
                                            carList: cars,
                                            categoryList: categories,
                                          ),
                                          // child: Padding(
                                          //   padding: const EdgeInsets.all(8.0),
                                          //   child: LayoutBuilder(
                                          //     builder: (context, constraints) {
                                          //       return Row(
                                          //         mainAxisAlignment:
                                          //             MainAxisAlignment.spaceAround,
                                          //         children: [
                                          //           Container(
                                          //             color: Colors.blue,
                                          //             width: constraints.maxWidth * 0.30,
                                          //           ),
                                          //           Expanded(
                                          //             child: Container(
                                          //               color: Colors.grey[200],
                                          //             ),
                                          //           ),
                                          //         ],
                                          //       );
                                          //     },
                                          //   ),
                                          // ),
                                        ),
                                      ],
                                    );
                                  }

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      InformationView(),
                                      const SizedBox(height: 16),
                                      SplitView(
                                        carList: cars,
                                        categoryList: categories,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
      _currentMessage.value = _messages[_currentPage];
      _currentColor = _colors[_currentPage];
    });
  }
}
