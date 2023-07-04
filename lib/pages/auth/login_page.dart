import 'package:flutter/material.dart';
import 'package:test_aplikasi/pages/auth/register_page.dart';
import 'package:test_aplikasi/utils/constant.dart';
import 'package:test_aplikasi/widgets/button_widget.dart';
import 'package:test_aplikasi/widgets/textfield_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerEmail = TextEditingController();
    TextEditingController _controllerPassword = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "LOGIN",
                style: titleTS,
              ),
            ),
            TextFieldWidget(
              controllerName: _controllerEmail,
              fieldName: "Email",
            ),
            TextFieldWidget(
              controllerName: _controllerPassword,
              fieldName: "Password",
              isVisibility: true,
            ),
            ButtonWidget(
              btnName: "Register",
              isNavPush: true,
              page: RegisterPage(),
            )
          ],
        ),
      ),
    );
  }
}