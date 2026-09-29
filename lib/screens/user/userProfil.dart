import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:site_bmr_transport/common/widget.dart';
import 'package:site_bmr_transport/services/firebase/firebase.dart';
import 'package:site_bmr_transport/services/hive/hiveBoxe.dart';
import 'package:site_bmr_transport/services/hive/hive_database.dart';
import 'package:site_bmr_transport/utils/utils.dart';

class Userprofile extends StatefulWidget {
  final String userId;
  const Userprofile({super.key, required this.userId});

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  late MyUser _costumer;
  final Box _userBox = ActivitiesBox.currentUserBox;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    if (_userBox.isEmpty) {
      final user = await FireServices.getUserById(widget.userId);
      setState(() {
        _costumer = MyUser.fromFirestore(user);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: myTitleText(
                    _costumer.firstName.substring(0, 1),
                    width / bigSize,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Action à effectuer lors du clic sur le bouton d'édition
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            myTitleText(_costumer.lastName, width / titleSize),
            SizedBox(height: 10),
            myTitleText(_costumer.firstName, width / titleSize),
            SizedBox(height: 10),
            myTitleText(_costumer.phoneNumber, width / titleSize),
            SizedBox(height: 10),
            myTitleText(_costumer.email, width / titleSize),
            SizedBox(height: 10),
            myTitleText(_costumer.address, width / titleSize),

            SizedBox(height: 20),
            myTitleText("Vos commandes", width / titleSize),
          ],
        ),
      ),
    );
  }
}
