import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:site_bmr_transport/common/myAppBar.dart';
import 'package:site_bmr_transport/common/widget.dart';
import 'package:site_bmr_transport/services/stripe/payment.dart';
import 'package:site_bmr_transport/services/hive/hiveBoxe.dart';
import 'package:site_bmr_transport/services/hive/hive_database.dart';
import 'package:site_bmr_transport/services/stripe/stripe.dart';
import 'package:site_bmr_transport/utils/utils.dart';

class Cartview extends StatefulWidget {
  final bool paymentIsSuccessul;
  final bool paymentIsFailed;
  const Cartview({
    super.key,
    required this.paymentIsSuccessul,
    required this.paymentIsFailed,
  });

  @override
  State<Cartview> createState() => _CartviewState();
}

class _CartviewState extends State<Cartview> {
  final User? user = FirebaseAuth.instance.currentUser;
  Iterable<dynamic> userCart = ActivitiesBox.orderBox.values;
  double get _cartTotal =>
      userCart.fold<double>(0, (sum, item) => sum + (item.price as double));
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: Myappbar(title: "Votre Panier", onChanged: (value) {}),
      ),
      body: userCart.isEmpty
          ? Center(
              child: myTitleText("Votre panier est vide", width / titleSize),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isNarrow = constraints.maxWidth < 600;
                    if (isNarrow) {
                      return _buildNarrowLayout(width);
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // runSpacing: 10,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.7,
                          // constraints: BoxConstraints(maxWidth: 900),
                          child: _buildList(width),
                        ),
                        Expanded(
                          child: MyPayment(
                            paymentIsSuccessul: widget.paymentIsSuccessul,
                            paymentIsFailed: widget.paymentIsFailed,
                          ),
                        ),
                        // StripePaymentPage(totalAmount: _cartTotal),
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }

  Column _buildNarrowLayout(double width) {
    return Column(
      children: [
        _buildList(width),
        MyPayment(
          paymentIsSuccessul: widget.paymentIsSuccessul,
          paymentIsFailed: widget.paymentIsFailed,
        ),
        // StripePaymentPage(totalAmount: _cartTotal),
      ],
    );
  }

  ValueListenableBuilder<Box<dynamic>> _buildList(double width) {
    return ValueListenableBuilder(
      valueListenable: ActivitiesBox.orderBox.listenable(),
      builder: (context, Box box, _) {
        var cart = box.values.toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final Order order = cart[index];
                return GestureDetector(
                  onTap: () {
                    // Handle tap event here
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 5, right: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(1000),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(4, 4), // shadow at bottom and right
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 8,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(order.carImages!.first),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            mySubTitleBoldText(
                              order.costumerName.toUpperCase(),
                              width / subtitleSize,
                            ),

                            Text(
                              "${order.departureAddress}→${order.steps.isNotEmpty ? order.steps.last : ""}${order.steps.length > 1 ? " (${order.steps.length} étapes)" : ""}",
                            ),
                          ],
                        ),
                        mySubTitleBoldText(
                          numberFormat.format(order.personNumber * order.price),
                          width / subtitleSize,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                mySubTitleText("Pour un Total de:  ", width / normalSize),
                mySubTitleBoldText(
                  numberFormat.format(
                    cart.fold<double>(0, (sum, item) => sum + item.price),
                  ),
                  width / titleSize,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
