import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_aplikasi/services/firebase_services.dart';
import 'package:test_aplikasi/widgets/button_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        ButtonWidget(
          btnName: "Logout",
          isPressed: true,
          onPressed: () {
            FirebaseService(FirebaseAuth.instance).signOut(context);
          },
        )
      ]),
    );
  }
}
