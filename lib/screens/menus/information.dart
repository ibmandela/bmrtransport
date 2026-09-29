import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:site_bmr_transport/common/data.dart';
import 'package:site_bmr_transport/common/widget.dart';
import 'package:site_bmr_transport/services/firebase/firebase.dart';
import 'package:site_bmr_transport/services/hive/hiveBoxe.dart';
import 'package:site_bmr_transport/services/hive/hive_database.dart';
import 'package:site_bmr_transport/utils/utils.dart';

class InformationView extends StatefulWidget {
  const InformationView({super.key});

  @override
  State<InformationView> createState() => _InformationViewState();
}

class _InformationViewState extends State<InformationView> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _dateTime;
  TimeOfDay? _departureTime;
  final TextEditingController _departureAddressController =
      TextEditingController();
  final TextEditingController _arrivalAddressController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  List<String> _addressSuggestions = [];
  List<String> _addressList = [];
  bool _isSearchingAddresses = false;
  bool _isDepartureAddress = false;
  bool _isArrivalAddress = false;
  int _searchRequest = 0;
  int _personNumber = 1;
  int _suitcaseNumber = 1;
  MyCar _car = ActivitiesBox.myCarBox.get("current");
  double _price = 0.0;

  @override
  void dispose() {
    _departureAddressController.dispose();
    _arrivalAddressController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Information du trajet",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              mySubTitleText("Date de départ", 18),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: Text(
                          _dateTime != null
                              ? '${_dateTime!.month}/${_dateTime!.day}/${_dateTime!.year}'
                              : 'Jour',
                        ),
                        onTap: () async {
                          final d = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          if (d != null) setState(() => _dateTime = d);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.access_time),
                        title: Text(
                          _departureTime != null
                              ? _departureTime!.format(context)
                              : 'Heure',
                        ),
                        onTap: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) {
                            setState(() {
                              _departureTime = time;
                              final date = _dateTime ?? DateTime.now();
                              _dateTime = DateTime(
                                date.year,
                                date.month,
                                date.day,
                                time.hour,
                                time.minute,
                              );
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              requiredInput(
                "Adresse de départ",
                TextInputType.text,
                _departureAddressController,
                (value) {
                  _searchAddresses(value);
                  _isDepartureAddress = true;
                  _isArrivalAddress = false;
                },
              ),

              if (_isSearchingAddresses && _isDepartureAddress)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: LinearProgressIndicator(),
                ),
              if (_addressSuggestions.isNotEmpty && _isDepartureAddress)
                Card(
                  margin: EdgeInsets.zero,
                  child: _showAdressList(_departureAddressController),
                ),
              const SizedBox(height: 16),

              requiredInputandIcon(
                "Adresse d'arrivée",
                TextInputType.text,
                _arrivalAddressController,
                (value) {
                  _searchAddresses(value);
                  _isArrivalAddress = true;
                  _isDepartureAddress = false;
                },
                TextButton(
                  onPressed: () {
                    setState(() {
                      _addressList.add(_arrivalAddressController.text);
                      _arrivalAddressController.clear();
                      _addressSuggestions = [];
                      _isArrivalAddress = false;
                      _isDepartureAddress = false;
                    });
                  },
                  child: const Text(
                    "Ajouter\nune étape",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              if (_isSearchingAddresses && _isArrivalAddress)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: LinearProgressIndicator(),
                ),
              if (_addressSuggestions.isNotEmpty && _isArrivalAddress)
                Card(
                  margin: EdgeInsets.zero,
                  child: _showAdressList(_arrivalAddressController),
                ),
              if (_addressList.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mySmallText(_departureAddressController.text, 15),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _addressList.length,
                      itemBuilder: (context, index) {
                        final address = _addressList[index];
                        return Column(
                          children: [
                            Icon(Icons.arrow_downward),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: mySmallText(address, 15)),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      _addressList.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        );

                        //  ListTile(
                        //   leading: const Icon(Icons.location_on_outlined),
                        //   title: Text(address),
                        //   trailing: IconButton(
                        //     icon: const Icon(Icons.delete),
                        //     onPressed: () {
                        //       setState(() {
                        //         _addressList.removeAt(index);
                        //       });
                        //     },
                        //   ),
                        // );
                      },
                    ),
                  ],
                ),
              if (_arrivalAddressController.text.isNotEmpty ||
                  _departureAddressController.text.isNotEmpty)
                _priceRow(),
              const SizedBox(height: 16),
              Text(
                "Information du client",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 5),
              requiredInput(
                "Nom du client",
                TextInputType.text,
                _nameController,
                (value) {},
              ),
              const SizedBox(height: 5),
              requiredInput(
                "Numéro de téléphone",
                TextInputType.phone,
                _phoneController,
                (value) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  mySmallText(
                    "Passagers",
                    MediaQuery.of(context).size.width / subtitleSize,
                  ),
                  _incrementRow(
                    _personNumber,
                    MediaQuery.of(context).size.width / subtitleSize,
                    (value) => setState(() => _personNumber = value),
                  ),

                  mySmallText(
                    "Bagages",
                    MediaQuery.of(context).size.width / subtitleSize,
                  ),
                  _incrementRow(
                    _suitcaseNumber,
                    MediaQuery.of(context).size.width / subtitleSize,
                    (value) => setState(() => _suitcaseNumber = value),
                  ),
                ],
              ),
              ValueListenableBuilder<Box>(
                valueListenable: ActivitiesBox.myCarBox.listenable(),
                builder: (context, value, child) {
                  var vehicule = value.get("current");
                  return mydoubleText(
                    "Véhicule:  ",
                    vehicule.name,
                    MediaQuery.of(context).size.width / subtitleSize,
                  ); // Replace with your desired widget
                },
              ),
              mybutton("Valider", () {
                MyCar vehicule = ActivitiesBox.myCarBox.get("current");
                if (_formKey.currentState!.validate()) {
                  // Form is valid, proceed with submission
                  // You can access the form values here
                  ActivitiesBox.orderBox
                      .put(
                        DateTime.now().millisecondsSinceEpoch.toString(),
                        Order(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          departureDate: _dateTime!,
                          costumerName: _nameController.value.text,
                          costumerPhone: _phoneController.value.text,
                          departureAddress:
                              _departureAddressController.value.text,
                          steps:
                              _addressList +
                              [_arrivalAddressController.value.text],
                          personNumber: _personNumber,
                          suitcaseNumber: _suitcaseNumber,
                          vehicule: vehicule.name,
                          status: "en cours",
                          price: _price,
                          carImages: vehicule.imgUrl,
                        ),
                      )
                      .then((a) {
                        _addressList.clear();
                        _nameController.clear();
                        _arrivalAddressController.clear();
                        _departureAddressController.clear();
                        _phoneController.clear();
                        _dateTime = null;
                        _departureTime = null;
                        setState(() {});
                      });
                  print(_addressList);
                }
              }),
            ],
          ),
        ),
      ),
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
              _isDepartureAddress = false;
              _isArrivalAddress = false;
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

  Widget _incrementRow(int quantity, double size, ValueChanged<int> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            if (quantity > 1) onChanged(quantity - 1);
          },
          icon: const Icon(Icons.remove),
        ),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: Text('$quantity', key: ValueKey(quantity)),
        ),
        IconButton(
          onPressed: () {
            onChanged(quantity + 1);
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  String _getArea(String address) {
    final postalCode = RegExp(r'\b\d{5}\b').firstMatch(address)?.group(0);
    if (postalCode == null) return '';
    if (paris.contains(postalCode)) return 'paris';
    if (banlieue.contains(postalCode)) return 'banlieue';
    if (province.contains(postalCode)) return 'province';
    return '';
  }

  Row _priceRow() {
    String departureArea = _getArea(_departureAddressController.text);
    String arrivalArea = _getArea(_arrivalAddressController.text);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        mySmallText(departureArea, 15),
        const Icon(Icons.arrow_forward),
        mySmallText(arrivalArea, 15),
        if (departureArea.isNotEmpty && arrivalArea.isNotEmpty)
          ValueListenableBuilder(
            valueListenable: ActivitiesBox.myCategoryBox.listenable(),
            builder: (context, value, child) {
              final category = value.get("current");
              final matchingPrices = category.prices.where(
                (e) =>
                    e.departure.toUpperCase() == departureArea.toUpperCase() &&
                    e.arrival.toUpperCase() == arrivalArea.toUpperCase(),
              );
              _price = matchingPrices.isNotEmpty
                  ? matchingPrices.first.price
                  : 0;
              return mySmallText("Prix: $_price €", 15);
            },
          ),
      ],
    );
  }
}
