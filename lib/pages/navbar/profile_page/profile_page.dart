import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_aplikasi/pages/navbar/profile_page/update_profile_page/update_profile_page.dart';
import 'package:test_aplikasi/services/firebase_services.dart';
import 'package:test_aplikasi/utils/constant.dart';
import 'package:test_aplikasi/widgets/button_widget.dart';
import 'package:test_aplikasi/widgets/textfield_widget.dart';
import 'package:test_aplikasi/widgets/transition_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String avaURL =
      "https://w7.pngwing.com/pngs/321/641/png-transparent-load-the-map-loading-load-waiting-thumbnail.png";
  String email = "...";
  String nama = "...";

  Future getDocID() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          avaURL = value.data()!['avatarURL'];
          email = value.data()!['email'];
          nama = value.data()!['name'];
        });
      }
    });
  }

  @override
  void initState() {
    getDocID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(children: [
          Center(
            child: Stack(
              children: [
                ClipOval(
                    child: Material(
                        child: Ink.image(
                  image: NetworkImage(avaURL),
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                ))),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonWidget(
                btnName: "Logout",
                isPressed: true,
                onPressed: () {
                  FirebaseService(FirebaseAuth.instance).signOut(context);
                },
              ),
              ButtonWidget(
                btnName: "Update",
                isPressed: true,
                onPressed: () {
                  navPushTransition(context, const UpdateProfilePage());
                },
              ),
            ],
          ),
          TextFieldWidget(
            isReadOnly: true,
            fieldName: nama,
          ),
          TextFieldWidget(
            isReadOnly: true,
            fieldName: email,
          )
        ]),
      ),
    );
  }
}
