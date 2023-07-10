import 'package:flutter/material.dart';
import 'package:test_aplikasi/pages/auth/login_page.dart';
import 'package:test_aplikasi/pages/navbar/navbar.dart';
import 'package:test_aplikasi/services/shared_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> route() async {
    final pref = SharedServices();
    String? email = await pref.getEmail();
    Future.delayed(const Duration(seconds: 3), () {
      if (email != null) {
        // print(email);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavBottomBar()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  void initState() {
    route();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
            "https://assets-global.website-files.com/5d8a2888296e91abbdcb65f0/627a462a56881ace6ce1ae16_Big_phone_with_cart.jpg",
            scale: 2),
      ),
    );
  }
}
