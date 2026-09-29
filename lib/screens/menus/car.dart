import 'package:flutter/material.dart';
import 'package:site_bmr_transport/common/data.dart';
import 'package:site_bmr_transport/common/widget.dart';
import 'package:site_bmr_transport/services/firebase/firebase.dart';
import 'package:site_bmr_transport/services/hive/hiveBoxe.dart';
import 'package:site_bmr_transport/services/hive/hive_database.dart';
import 'package:site_bmr_transport/widgets/myCarCard.dart';
import 'package:site_bmr_transport/widgets/myCategory.dart';

class SplitView extends StatefulWidget {
  final List<MyCategory> categoryList;
  final List<MyCar> carList;
  const SplitView({
    super.key,
    required this.categoryList,
    required this.carList,
  });

  @override
  State<SplitView> createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  MyCar _selectedCar = ActivitiesBox.myCarBox.get("current");
  var _showDetail = true;
  MyCategory _selectedCategory = ActivitiesBox.myCategoryBox.get("current");
  // List<MyCar> get _selectedCarList => ActivitiesBox.myCarBox.values
  //     .map((e) => MyCar.fromJson(e))
  //     .where((e) => e.category == _selectedCategory.name)
  //     .toList();
  // List<MyCategory> get _categoryList => ActivitiesBox.myCategoryBox.values
  //     .map((e) => MyCategory.fromJson(e))
  // .toList();
  bool _categoryIsSelected = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 600;
        if (isNarrow) {
          return _buildNarrowLayout();
        }
        return Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 400,
                child: Column(
                  children: [
                    myTitleText("Nos modèles de véhicules", 20),
                    _showCategoryList(),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          myTitleText("Nos modèles de véhicules", 20),
                          _showCarList(),
                        ],
                      ),
                    ),
                    // if (_showDetail && _choise != null)
                    //   Expanded(
                    //     flex: 1,
                    //     child: Card(
                    //       margin: const EdgeInsets.all(8),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(16),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Text(
                    //                   _selectedCars[_choise!].name,
                    //                   style: Theme.of(context)
                    //                       .textTheme
                    //                       .titleLarge,
                    //                 ),
                    //                 IconButton(
                    //                   icon: const Icon(Icons.close),
                    //                   onPressed: () =>
                    //                       setState(() => _showDetail = false),
                    //                 ),
                    //               ],
                    //             ),
                    //             const SizedBox(height: 16),
                    //             const Text(
                    //               'Email content goes here. This is the master-detail layout pattern.',
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNarrowLayout() {
    if (_categoryIsSelected != false && _showDetail) {
      return Column(
        children: [
          AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => setState(() => _showDetail = false),
            ),
            title: Text(_selectedCategory.name),
          ),
          _showCarList(),
        ],
      );
    }
    return _showCategoryList();
  }

  ListView _showCarList() {
    final selectedCarList = widget.carList
        .where((car) => car.category == _selectedCategory.name)
        .toList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: selectedCarList.length,
      itemBuilder: (context, i) {
        final currentCar = selectedCarList[i];
        return Mycarcard(
          name: currentCar.name,
          description: currentCar.description,
          imgUrl: currentCar.imgUrl.first,
          placeNumber: currentCar.placeNumber,
          suitcaseNumber: currentCar.suitcaseNumber,
          isSelected: currentCar.name == _selectedCar.name,
          onSelected: (car) {
            ActivitiesBox.myCarBox.put("current", currentCar);
            setState(() {
              _selectedCar = currentCar;
              _categoryIsSelected = true;
              _showDetail = false;
            });
          },
        );
      },
    );
  }

  ListView _showCategoryList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.categoryList.length,
      itemBuilder: (context, i) => MycategoryCard(
        name: widget.categoryList[i].name,
        description: widget.categoryList[i].description,
        imgUrl: widget.categoryList[i].imgUrl,
        onSelected: (category) {
          ActivitiesBox.myCategoryBox.put("current", widget.categoryList[i]);
          if (_selectedCategory != widget.categoryList[i]) {
            ActivitiesBox.myCarBox.put(
              "current",
              widget.carList.firstWhere(
                (car) => car.category == widget.categoryList[i].name,
              ),
            );
          }

          setState(() {
            _selectedCategory = widget.categoryList[i];
            _showDetail = true;
            _categoryIsSelected = true;
          });
        },
        isSelected: widget.categoryList[i].name == _selectedCategory.name,
      ),
    );
  }
}
