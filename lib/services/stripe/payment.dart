import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:site_bmr_transport/common/widget.dart';
import 'package:site_bmr_transport/services/firebase/firebase.dart';
import 'package:site_bmr_transport/services/hive/hiveBoxe.dart';
import 'package:site_bmr_transport/services/hive/hive_database.dart';
import 'package:site_bmr_transport/services/stripe/stripe.dart';
import 'package:site_bmr_transport/utils/utils.dart';
import 'package:web/web.dart ' as web;

class MyPayment extends StatefulWidget {
  final bool paymentIsSuccessul;
  final bool paymentIsFailed;
  const MyPayment({
    super.key,
    required this.paymentIsSuccessul,
    required this.paymentIsFailed,
  });

  @override
  State<MyPayment> createState() => _MyPaymentState();
}

class _MyPaymentState extends State<MyPayment>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _formKey = GlobalKey<FormState>();
  final User? _user = FirebaseAuth.instance.currentUser;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  List<PayWay> _payWay = [];
  List<String> _addressSuggestions = [];
  int _searchRequest = 0;
  bool _isSearchingAddresses = false;

  @override
  void initState() {
    if (widget.paymentIsSuccessul) {
      _payWay.add(
        PayWay(
          id: checkoutId ?? "",
          date: DateTime.now(),
          type: "Stripe",
          amount: ActivitiesBox.orderBox.values.fold(
            0,
            (previousValue, element) => previousValue + element.price,
          ),
        ),
      );
      final List<Order> cart =
          ActivitiesBox.orderBox.values.toList() as List<Order>;

      _addToCommndeBox(cart, ActivitiesBox.currentUserBox.get("currentUser")!);
      if (_user != null) {
        _addToUserColl(cart, ActivitiesBox.currentUserBox.get("currentUser")!);
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAlert(
          "Le paiement a été effectué avec succès.\n Vous recevrez un email de confirmation avec le suivi de votre commande.\n Merci de votre confiance.",

          () {
            Navigator.pop(context);
            setState(() {});
          },
          context,
          MediaQuery.of(context).size.width / subtitleSize,
        );
      });
      setState(() {});
    }

    if (widget.paymentIsFailed) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => showAlert(
          "Le paiement a échoué. Veuillez réessayer plus tard.",
          () {
            Navigator.pop(context);
          },
          context,
          MediaQuery.of(context).size.width / subtitleSize,
        ),
      );
    }

    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _phoneController.dispose();
    _emailControler.dispose();
    _adressController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ActivitiesBox.orderBox.listenable(),
      builder: (context, value, child) {
        List<dynamic> cart = value.values.toList();
        double total = cart.fold(
          0,
          (previousValue, element) => previousValue + element.price,
        );

        return ValueListenableBuilder(
          valueListenable: ActivitiesBox.currentUserBox.listenable(),
          builder: (context, value, child) {
            MyUser currentUser =
                value.get("currentUser") ??
                MyUser(
                  id: _emailControler.text,
                  firstName: _nameController.text,
                  lastName: "",
                  phoneNumber: _phoneController.text,
                  email: _emailControler.text,
                  address: _adressController.text,
                );
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_user == null)
                    requiredInput(
                      "Nom ",
                      TextInputType.text,
                      _nameController,
                      (newValue) {},
                    ),
                  SizedBox(height: 5),
                  if (_user == null)
                    requiredInput(
                      "Email ",
                      TextInputType.emailAddress,
                      _emailControler,
                      (newValue) {},
                    ),
                  SizedBox(height: 5),
                  if (_user == null)
                    input(
                      "Téléphone",
                      TextInputType.phone,
                      _phoneController,
                      (newValue) {},
                    ),
                  SizedBox(height: 5),
                  if (_user == null)
                    requiredInput(
                      "Adresse",
                      TextInputType.text,
                      _adressController,
                      (value) {
                        _searchAddresses(value);
                      },
                    ),
                  _showAdressList(_adressController),
                  SizedBox(height: 5),
                  if (_user == null) SizedBox(height: 10),
                  mybutton(
                    cart.isEmpty
                        ? "Payer"
                        : "Payer les ${numberFormat.format(total)}",
                    () async {
                      if (_user == null) {
                        ActivitiesBox.currentUserBox.put(
                          "currentUser",
                          MyUser(
                            id: DateTime.now().millisecondsSinceEpoch
                                .toString(),
                            firstName: _nameController.text,
                            lastName: "",
                            phoneNumber: _phoneController.text,
                            email: _emailControler.text,
                            address: _adressController.text,
                          ),
                        );
                      }
                      setState(() {});
                      if (_formKey.currentState!.validate()) {
                        // Use the new Checkout service to create a session
                        await Checkout.createCheckoutSession(
                              cart: cart,
                              email: _emailControler.text,
                            )
                            .then(
                              (body) => {
                                setState(() {
                                  checkoutId = body['id'];
                                }),
                                web.window.open(body['url']),
                              },
                            )
                            .then(
                              (_) => _addToCommndeBox(
                                cart as List<Order>,
                                currentUser,
                              ),
                            );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  ListView _showAdressList(TextEditingController controller) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _addressSuggestions.length,
      itemBuilder: (context, index) {
        final address = _addressSuggestions[index];
        return ListTile(
          leading: const Icon(Icons.location_on_outlined),
          title: Text(address),
          onTap: () {
            controller.text = address;
            controller.selection = TextSelection.collapsed(
              offset: address.length,
            );
            setState(() {
              _addressSuggestions = [];
            });
          },
        );
      },
    );
  }

  Future<void> _searchAddresses(String value) async {
    final request = ++_searchRequest;
    final query = value.trim();
    if (query.length < 3) {
      setState(() => _addressSuggestions = []);
      return;
    }

    setState(() => _isSearchingAddresses = true);
    try {
      final uri = Uri.https('api-adresse.data.gouv.fr', '/search/', {
        'q': query,
        'limit': '8',
        'autocomplete': '1',
      });
      final response = await http.get(uri);
      if (!mounted || request != _searchRequest) return;

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final features = json['features'] as List<dynamic>? ?? [];
        setState(() {
          _addressSuggestions = features
              .map(
                (feature) =>
                    ((feature as Map<String, dynamic>)['properties']
                            as Map<String, dynamic>)['label']
                        as String,
              )
              .toList();
        });
      }
    } catch (_) {
      if (mounted && request == _searchRequest) {
        setState(() => _addressSuggestions = []);
      }
    } finally {
      if (mounted && request == _searchRequest) {
        setState(() => _isSearchingAddresses = false);
      }
    }
  }

  void _addToCommndeBox(List<Order> cart, MyUser currentUser) {
    ActivitiesBox.cartBox
        .put(
          'current',
          MyCart(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            commandeDate: DateTime.now(),
            userId: currentUser.id,
            discount: 0.0,
            payWay: _payWay,
            totalPrice: cart.fold(
              0,
              (previousValue, element) => previousValue + element.price,
            ),
            order: cart,
            description: "",
            commission: 0.0,
          ),
        )
        .then((e) {
          if (mounted) Navigator.pop(context);
        });
  }

  _addToUserColl(List<Order> cart, MyUser currentUser) {
    FireServices.addToUserColl(
      commande: MyCart(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        commandeDate: DateTime.now(),
        userId: _user!.uid,
        discount: 0.0,
        payWay: _payWay,
        totalPrice: cart.fold(
          0,
          (previousValue, element) => previousValue + element.price,
        ),
        order: cart,
        description: "",
        commission: 0.0,
      ),
      userId: _user.uid,
    ).then((e) => setState(() {}));
  }
}
