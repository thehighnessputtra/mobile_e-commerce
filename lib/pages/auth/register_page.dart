import 'package:flutter/material.dart';
import 'package:test_aplikasi/widgets/button_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("REGISTER")),
      body: ButtonWidget(
        btnName: "Login",
        isNavBack: true,
      ),
    );
  }
}
