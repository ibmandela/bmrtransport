import 'dart:io';

import 'package:flutter/material.dart';

input(
  String label,
  TextInputType type,
  TextEditingController? controler,
  ValueChanged onChanged,
) {
  return TextFormField(
    controller: controler,
    onChanged: onChanged,
    keyboardType: type,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(10.0),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.red, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: const Color.fromARGB(255, 170, 144, 243),
          width: 2.0,
        ),
      ),
      labelText: label,
      hintText: label,
    ),
  );
}

TextFormField requiredInput(
  String label,
  TextInputType type,
  TextEditingController? controler,
  ValueChanged<String> onChanged,
) {
  return TextFormField(
    onChanged: onChanged,
    keyboardType: type,
    controller: controler,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),

        borderSide: BorderSide(color: Colors.red, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(
          color: const Color.fromARGB(255, 170, 144, 243),
          width: 1.0,
        ),
      ),
      labelText: label,
      hintText: label,
    ),

    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Ce champ est obligatoire';
      }
      return null;
    },
  );
}

TextFormField requiredInputandIcon(
  String label,
  TextInputType type,
  TextEditingController? controler,
  ValueChanged<String> onChanged,
  Widget? suffix,
) {
  return TextFormField(
    onChanged: onChanged,
    keyboardType: type,
    controller: controler,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
      suffixIcon: suffix,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),

        borderSide: BorderSide(color: Colors.red, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: const Color.fromARGB(255, 170, 144, 243),
          width: 2.0,
        ),
      ),
      labelText: label,
      hintText: label,
    ),

    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Ce champ est obligatoire';
      }
      return null;
    },
  );
}

TextFormField specialInput(
  String label,
  TextInputType type,
  TextEditingController? controler,
  ValueChanged<String> onChanged,
  FormFieldValidator<String>? validator,
) {
  return TextFormField(
    onChanged: onChanged,
    keyboardType: type,
    controller: controler,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(10.0),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.red, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: const Color.fromARGB(255, 170, 144, 243),
          width: 2.0,
        ),
      ),
      labelText: label,
      hintText: label,
    ),

    validator: validator,
  );
}

TextFormField autherInput(
  String label,
  TextInputType type,
  TextEditingController controler,
  ValueChanged<String> onChanged,
) {
  return TextFormField(
    keyboardType: type,
    controller: controler,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.all(10.0),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.red, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: const Color.fromARGB(255, 170, 144, 243),
          width: 2.0,
        ),
      ),
      labelText: label,
      hintText: label,
    ),
    onChanged: onChanged,

    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Ce champ est obligatoire';
      }
      return null;
    },
  );
}

ElevatedButton mybutton(String label, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      backgroundColor: const Color.fromARGB(255, 170, 144, 243),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    ),
    child: Text(label),
  );
}

TextButton myTextButton(String label, VoidCallback onPressed) {
  return TextButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      padding: EdgeInsets.all(10.0),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
    child: Text(label),
  );
}

Widget myTab(String text, IconData? icon) {
  return Tab(
    text: text,
    // icon: Icon(icon, size: 15),
    height: 50,
    iconMargin: EdgeInsets.all(0),
  );
}

void showMessage(
  BuildContext context,
  String message,
  Color color,
  int duration,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration),
      backgroundColor: color,
    ),
  );
}

Future<dynamic> showAlert(
  String message,
  VoidCallback callback,
  BuildContext context,
  double size,
) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: myTitleText("Attention!!!", size),
      content: mySubTitleText(message, size),
      contentPadding: EdgeInsets.all(20),
      actions: [
        myTextButton("Annuler", () {
          Navigator.pop(context);
        }),
        myTextButton("Valider", callback),
      ],
    ),
  );
}

DropdownButton<String> myStringDropdown(
  List<String> items,
  String value,
  ValueChanged onChanged,
) {
  return DropdownButton<String>(
    underline: const Visibility(visible: false, child: Icon(Icons.ac_unit)),
    value: value,
    // icon: const Visibility(visible: false, child: Icon(Icons.ac_unit)),
    elevation: 16,
    // style: TextStyle(color: _setColor(state)),
    onChanged: onChanged,
    items: items.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      );
    }).toList(),
  );
}

Card myExpandedTile(
  String title,
  String? subtitle,
  String leading,
  Widget? trailing,
  List<Widget> children,
  Color color,
  double size,
) {
  return Card(
    shape: RoundedRectangleBorder(
      side: BorderSide(color: color, width: 3),
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    // color en foction de l'état du barra
    child: ExpansionTile(
      leading: CircleAvatar(child: Image.file(File(leading))),
      title: mySubTitleBoldText(title, size),
      subtitle: subtitle != null ? mySubTitleText(subtitle, size) : null,
      trailing: trailing,
      expandedAlignment: Alignment.center,
      children: children,
    ),
  );
}

ExpansionTile myUserExpandedTile(
  String title,
  String subtitle,
  String leading,
  Widget trailing,
  List<Widget> children,
) {
  return ExpansionTile(
    leading: CircleAvatar(child: Text(leading.substring(0, 1))),
    title: Text(title),
    subtitle: Text(subtitle),
    trailing: trailing,
    expandedAlignment: Alignment.center,
    children: children,
  );
}

ListTile myTile(
  String title,
  String? subtitle,
  String url,
  String? trailing,
  VoidCallback onLongPress,
) {
  return ListTile(
    leading: CircleAvatar(child: Image.file(File(url))),
    title: Text(title),
    subtitle: subtitle != null ? Text(subtitle) : null,
    trailing: trailing != null ? Text(trailing) : null,
    // onLongPress: onLongPress,
  );
}

const loader = Center(child: CircularProgressIndicator(color: Colors.blue));

Text myTitleText(String text, double size) {
  return Text(
    text,
    style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
  );
}

Text mySubTitleText(String text, double size) {
  return Text(text, style: TextStyle(fontSize: size));
}

Text mySubTitleBoldText(String text, double size) {
  return Text(
    text,
    style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
  );
}

Text myText(String text, double size) {
  return Text(
    text,
    style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
  );
}

Text mySmallText(String text, double size) {
  return Text(
    text,
    style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
  );
}

Row mydoubleText(String label, String text, double size) {
  return Row(
    children: [mySubTitleText(label, size), mySubTitleBoldText(text, size)],
  );
}

// Widget incrementRow(MyArticleH article, VoidCallback setState, double size) {
//   print(article.id);
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       IconButton(
//         onPressed: () async {
//           if (article.quantity > 1) {
//             await ActivitiesBox.addtoCart(
//               MyArticleH(
//                 id: article.id,
//                 category: article.category,
//                 decription: article.decription,
//                 imgUrl: article.imgUrl,
//                 label: article.label,
//                 price: article.price,
//                 quantity: article.quantity - 1,
//                 comments: article.comments,
//                 caracteristics: article.caracteristics,
//               ),
//             );
//           } else {
//             ActivitiesBox.deleteFromCart(article.id);
//           }
//           setState();
//         },
//         icon: Icon(
//           article.quantity == 1 ? Icons.delete : Icons.remove,
//           size: size * 1.5,
//         ),
//       ),
//       Column(
//         children: [
//           mySmallText("Qtité", size),
//           mySubTitleBoldText(article.quantity.toString(), size),
//         ],
//       ),
//       IconButton(
//         onPressed: () async {
//           await ActivitiesBox.addtoCart(
//             MyArticleH(
//               id: article.id,
//               category: article.category,
//               decription: article.decription,
//               imgUrl: article.imgUrl,
//               label: article.label,
//               price: article.price,
//               quantity: article.quantity + 1,
//               comments: article.comments,
//               caracteristics: article.caracteristics,
//             ),
//           );
//           setState();
//         },
//         icon: Icon(Icons.add, size: size * 1.5),
//       ),
//     ],
//   );
// }
