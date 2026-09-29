import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:site_bmr_transport/common/widget.dart';
import 'package:site_bmr_transport/utils/utils.dart';

class Fireauth {
  static Future register(
    String firstName,
    String lastName,
    String phone,
    String email,
    String adress,
    String password,
    BuildContext context,
  ) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      // Creation du nouvel utilisateur sur firebase
      await firestore.collection("Users").doc(user!.uid).set({
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "email": email,
        "adress": adress,
      });

      return user;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        if (e.code == "network-request-failed") {
          showMessage(
            context,
            "Vérifiez que vous êtes bien connecté à internet puis réessayez.",
            Colors.red,
            failedDuration,
          );
        } else if (e.code == "email-already-in-use") {
          showMessage(
            context,
            "Cet email est déja utilisé.\nMerci de le vérifier  puis réessayer.",
            Colors.red,
            failedDuration,
          );
        } else {
          showMessage(
            context,
            "Une erreur est survenue lors de la création de votre compte.\nVeuillez réessayer.",
            Colors.red,
            failedDuration,
          );
        }
      }
    }
  }

  static Future signIn(
    String email,
    String password,
    BuildContext context,
  ) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    try {
      // UserCredential result =
      final user = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user.user;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        if (e.code == "network-request-failed") {
          showMessage(
            context,
            "Vérifiez que vous êtes bien connecté à internet puis réessayez.",
            Colors.red,
            failedDuration,
          );
        } else if (e.code == "wrong-password") {
          showMessage(
            context,
            "Votre mot de passe est incorrect.\nMerci de le vérifier puis réessayer.",
            Colors.red,
            failedDuration,
          );
        } else if (e.code == "user-not-found" ||
            e.code == "invalid-credential") {
          showMessage(
            context,
            "Votre email est incorrect.\nMerci de le vérifier  puis réessayer.",
            Colors.red,
            failedDuration,
          );
        } else {
          showMessage(
            context,
            "Une erreur de connexion est survenue.\nVeuillez réessayer.",
            Colors.red,
            failedDuration,
          );
        }
      }
    }
  }

  Future sendResetMessage(String email, BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        if (e.code == "network-request-failed") {
          showMessage(
            context,
            "Erreur de connexion:\nVérifiez que vous êtes bien connecté à internet puis réessayez.",
            Colors.red,
            failedDuration,
          );
        } else if (e.code == "user-not-found") {
          showMessage(
            context,
            "Aucun utilisateur trouvé avec cette adresse e-mail.\n Vérifiez le puis réessayez.",
            Colors.red,
            failedDuration,
          );
        } else {
          showMessage(
            context,
            "Une erreur est survenue.\nVeuillez réessayer.",
            Colors.red,
            failedDuration,
          );
        }
      }
    }
  }

  Future signOut(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      return await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showMessage(
          context,
          "Erreur de connexion: ${e.code}",
          Colors.red,
          failedDuration,
        );
      }

      return null;
    }
  }

  Future logout(BuildContext context) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      return await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      showMessage(context, "Erreur de deconnexion", Colors.red, failedDuration);
      return null;
    }
  }
}
