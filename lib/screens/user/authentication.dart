import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:site_bmr_transport/common/widget.dart';
import 'package:site_bmr_transport/services/firebase/fireAuth.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameControler = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confPasswordController = TextEditingController();
  List<String> _addressSuggestions = [];

  bool _signIn = true;
  bool _isSearchingAddresses = false;
  int _searchRequest = 0;

  @override
  void dispose() {
    _firstNameControler.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailControler.dispose();
    _adressController.dispose();
    _passwordController.dispose();
    _confPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(_signIn ? "Connectez-vous" : "Enregistrez-vous"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        if (!_signIn)
                          requiredInput(
                            "Nom ",
                            TextInputType.text,
                            _lastNameController,
                            (newValue) {},
                          ),
                        SizedBox(height: 10),
                        if (!_signIn)
                          requiredInput(
                            "Prenom ",
                            TextInputType.text,
                            _firstNameControler,
                            (newValue) {},
                          ),
                        SizedBox(height: 10),
                        if (!_signIn)
                          input(
                            "Téléphone(optionnel)",
                            TextInputType.phone,
                            _phoneController,
                            (newValue) {},
                          ),
                        SizedBox(height: 10),
                        requiredInput(
                          "Email ",
                          TextInputType.emailAddress,
                          _emailControler,
                          (newValue) {},
                        ),
                        SizedBox(height: 10),

                        if (!_signIn)
                          requiredInput(
                            "Adresse de départ",
                            TextInputType.text,
                            _adressController,
                            (value) {
                              _searchAddresses(value);
                            },
                          ),

                        if (_isSearchingAddresses)
                          const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: LinearProgressIndicator(),
                          ),
                        if (_addressSuggestions.isNotEmpty)
                          Card(
                            margin: EdgeInsets.zero,
                            child: _showAdressList(_adressController),
                          ),
                        SizedBox(height: 10),
                        specialInput(
                          "Mode de passe",
                          TextInputType.text,
                          _passwordController,
                          (newValue) {},
                          (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return "Le mot de passe doit contenir au moins 6 caractères";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        if (!_signIn)
                          specialInput(
                            "Confirmer le mot de passe",
                            TextInputType.text,
                            _confPasswordController,
                            (newValue) {},
                            (value) {
                              if (value != _passwordController.text) {
                                return "Les mots de passe ne correspondent pas";
                              }
                              return null;
                            },
                          ),
                        SizedBox(height: 10),
                        mybutton(_signIn ? "Connexion" : "Enregistrer", () {
                          setState(() {});
                          if (_signIn) {
                            _authWithEmail();
                          } else {
                            _registerWithEmail();
                          }
                        }),
                        SizedBox(height: 10),
                        myTextButton(
                          _signIn ? "Créer un compte" : "Se connecter",
                          () {
                            _toggle();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _toggle() {
    setState(() {
      _signIn = !_signIn;
    });
  }

  _authWithEmail() {
    if (_formKey.currentState!.validate()) {
      // Perform authentication logic here
      Fireauth.signIn(_emailControler.text, _passwordController.text, context);
    }
  }

  _registerWithEmail() {
    if (_formKey.currentState!.validate()) {
      // Perform registration logic here
      Fireauth.register(
        _firstNameControler.text,
        _lastNameController.text,
        _phoneController.text,
        _emailControler.text,
        _adressController.text,
        _passwordController.text,
        context,
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Veuillez corriger les erreurs')));
    }
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
}
