import 'package:flutter/material.dart';
import 'package:test_aplikasi/pages/auth/register_page.dart';
import 'package:test_aplikasi/pages/navbar/home_page/home_page.dart';
import 'package:test_aplikasi/pages/navbar/navbar.dart';
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
            sh20,
            TextFieldWidget(
              controllerName: _controllerEmail,
              fieldName: "Email",
            ),
            sh5,
            TextFieldWidget(
              controllerName: _controllerPassword,
              fieldName: "Password",
              isVisibility: true,
            ),
            sh5,
            ButtonWidget(
              btnName: "Register",
              isNavPush: true,
              page: RegisterPage(),
            ),
            ButtonWidget(
              btnName: "Login",
              isNavReplace: true,
              page: NavBottomBar(),
            ),
          ],
        ),
      ),
    );
  }
}
