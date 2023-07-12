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
                    avaName: avaName, avaURL: avaURL, email: email, name: name),
                postKeranjangToFirestore(email: email)
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

  Future<void> updateProfile(
      {required String email,
      required String name,
      required String avaURL,
      required String avaName,
      required BuildContext context}) async {
    try {
      await updateProfileToFirestore(
          email: email, name: name, avaURL: avaURL, avaName: avaName);

      // ignore: use_build_context_synchronously
      authRoute(
          context,
          "Update profile success!",
          NavBottomBar(
            currentIndex: 3,
          ));
    } on FirebaseAuthException catch (e) {
      // dialogInfo(context, e.message!);
      customDialog(context, title: "INFO", content: Text(e.message!));
    }
  }

  Future<void> updateToKeranjang(
      {required String email,
      required int totalHarga,
      required String totalGame,
      required BuildContext context}) async {
    try {
      await updateKeranjangToFirestore(
        email: email,
        totalHarga: totalHarga,
        totalGame: totalGame,
      );

      // ignore: use_build_context_synchronously
      authRoute(
          context,
          "Sukses memasukan ke keranjang!",
          NavBottomBar(
            currentIndex: 4,
          ));
    } on FirebaseAuthException catch (e) {
      // dialogInfo(context, e.message!);
      customDialog(context, title: "INFO", content: Text(e.message!));
    }
  }

  Future<void> deleteFromKeranjang(
      {required String email,
      required int totalHarga,
      required String totalGame,
      required BuildContext context}) async {
    try {
      await deleteKeranjangToFirestore(
        email: email,
        totalHarga: totalHarga,
        totalGame: totalGame,
      );

      // ignore: use_build_context_synchronously
      authRoute(
          context,
          isBack: true,
          "Sukses delete $totalGame!",
          NavBottomBar(
            currentIndex: 3,
          ));
    } on FirebaseAuthException catch (e) {
      // dialogInfo(context, e.message!);
      customDialog(context, title: "INFO", content: Text(e.message!));
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

  authRoute(context, String text, Widget page, {bool isBack = false}) {
    customDialog(context, title: "INFO", content: Text(text));
    isBack == false
        ? Future.delayed(
            const Duration(seconds: 2),
            () => navReplaceTransition(context, page),
          )
        : Future.delayed(
            const Duration(seconds: 2),
            () => navBackTransition(context),
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

  postKeranjangToFirestore({
    required String email,
  }) async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref =
        FirebaseFirestore.instance.collection('keranjang');
    ref.doc(user!.email).set({
      'email': email,
      'totalGame': [],
      'totalHarga': [],
    });
  }

  updateKeranjangToFirestore({
    required String email,
    required String totalGame,
    required int totalHarga,
  }) async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref =
        FirebaseFirestore.instance.collection('keranjang');
    ref.doc(user!.email).update({
      'email': email,
      'totalGame': FieldValue.arrayUnion([totalGame]),
      'totalHarga': FieldValue.arrayUnion([totalHarga]),
    });
  }

  deleteKeranjangToFirestore({
    required String email,
    required String totalGame,
    required int totalHarga,
  }) async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref =
        FirebaseFirestore.instance.collection('keranjang');
    ref.doc(user!.email).update({
      'email': email,
      'totalGame': FieldValue.arrayRemove([totalGame]),
      'totalHarga': FieldValue.arrayRemove([totalHarga]),
    });
  }

  updateProfileToFirestore(
      {required String email,
      required String name,
      required String avaURL,
      required String avaName}) async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.email).update({
      'email': email,
      'name': name,
      'avatarURL': avaURL,
      'avatarName': avaName
    });
  }
}
