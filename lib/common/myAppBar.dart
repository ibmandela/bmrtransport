import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:site_bmr_transport/common/widget.dart';
import 'package:site_bmr_transport/screens/cartView.dart';
import 'package:site_bmr_transport/screens/user/authentication.dart';
import 'package:site_bmr_transport/services/hive/hiveBoxe.dart';
import 'package:site_bmr_transport/utils/utils.dart';

class Myappbar extends StatefulWidget {
  final String title;
  final PreferredSizeWidget? bottom;
  final ValueChanged onChanged;
  const Myappbar({
    super.key,
    required this.onChanged,
    required this.title,
    this.bottom,
  });

  @override
  State<Myappbar> createState() => _MyappbarState();
}

class _MyappbarState extends State<Myappbar> {
  User? _user;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AppBar(
      shadowColor: Colors.black,
      title: myTitleText(widget.title, width / titleSize),
      actions: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 200),
          child: input(
            "Rechercher",
            TextInputType.text,
            null,
            widget.onChanged,
          ),
        ),
        StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return loader;
            }
            _user = snapshot.data;
            if (_user == null) {
              return TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Authentication()),
                  );
                },
                icon: Icon(Icons.person_add_alt),
                label: Text("connectez-vous"),
              );
            } else {
              return TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, "/profil");
                },
                icon: Icon(Icons.person),
                label: Text("votre espace"),
              );
            }
          },
        ),
        ValueListenableBuilder(
          valueListenable: ActivitiesBox.orderBox.listenable(),
          builder: (context, value, child) {
            return TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cartview(
                      paymentIsFailed: false,
                      paymentIsSuccessul: false,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.shopping_basket),
              label: mySmallText("${value.values.length}", width / smallSize),
            );
          },
        ),
        SizedBox(width: 50),
      ],
      bottom: widget.bottom,
    );
  }
}
