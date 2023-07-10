import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_aplikasi/pages/auth/login_page.dart';
import 'package:test_aplikasi/pages/navbar/navbar.dart';
import 'package:test_aplikasi/services/shared_services.dart';
import 'package:test_aplikasi/widgets/dialog_widget.dart';
import 'package:test_aplikasi/widgets/transition_widget.dart';

class FirebaseService {
  final FirebaseAuth auth;

  FirebaseService(this.auth);
  final pref = SharedServices();
  User get user => auth.currentUser!;
  bool isLoading = false;

  Stream<User?> get authState => auth.authStateChanges();

  Future<void> signUpEmail(
      {required String email,
      required String password,
      required String name,
      required String avaURL,
      required String avaName,
      required BuildContext context}) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postRegistToFirestore(
                    avaName: avaName, avaURL: avaURL, email: email, name: name)
              });

      // ignore: use_build_context_synchronously
      authRoute(context, "Register success!", const LoginPage());
    } on FirebaseAuthException catch (e) {
      customDialog(context,
          title: "WARNING!", content: Text("Email sudah digunakan!"));
    }
  }

  Future<void> signInEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      pref.saveEmail(email);

      // ignore: use_build_context_synchronously
      authRoute(context, "Login success!", NavBottomBar());
    } on FirebaseAuthException catch (e) {
      // dialogInfo(context, e.message!);
      if (e.message ==
          "The password is invalid or the user does not have a password.") {
        return customDialog(context,
            title: "WARNING!", content: Text("Password salah!"));
      } else {
        return customDialog(context,
            title: "WARNING!", content: Text("Email tidak terdaftar!"));
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await auth.signOut();
      pref.deleteEmail();
      // ignore: use_build_context_synchronously
      authRoute(context, "Logout success!", const LoginPage());
    } on FirebaseAuthException catch (e) {
      customDialog(context, title: "INFO", content: Text(e.message!));
    }
  }

  authRoute(context, String text, Widget page) {
    customDialog(context, title: "INFO", content: Text(text));

    Future.delayed(
      const Duration(seconds: 2),
      () => navReplaceTransition(context, page),
    );
  }

  postRegistToFirestore(
      {required String email,
      required String name,
      required String avaURL,
      required String avaName}) async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.email).set({
      'email': email,
      'name': name,
      'avatarURL': avaURL,
      'avatarName': avaName
    });
  }
}
