import 'package:flutter/material.dart';
import 'package:test_aplikasi/pages/auth/login_page.dart';
import 'package:test_aplikasi/utils/constant.dart';
import 'package:test_aplikasi/widgets/button_widget.dart';
import 'package:test_aplikasi/widgets/dialog_widget.dart';
import 'package:test_aplikasi/widgets/textfield_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

TextEditingController _controllerNama = TextEditingController();
TextEditingController _controllerEmail = TextEditingController();
TextEditingController _controllerPassword = TextEditingController();

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "REGISTER",
                style: titleTS,
              ),
            ),
            sh20,
            Center(
              child: Stack(
                children: [
                  ClipOval(
                      child: Material(
                          child: Ink.image(
                    image: NetworkImage(
                        "https://www.pngmart.com/files/21/Admin-Profile-Vector-PNG-Clipart.png"),
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                  ))),
                  Positioned(
                      bottom: 0,
                      right: 4,
                      child: InkWell(
                        onTap: () async {},
                        child: ClipOval(
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.blueAccent,
                                    shape: BoxShape.circle,
                                    border: Border.fromBorderSide(BorderSide(
                                        width: 2.5, color: Colors.white))),
                                padding: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.white,
                                ))),
                      ))
                ],
              ),
            ),
            sh10,
            TextFieldWidget(controllerName: _controllerNama, fieldName: "Nama"),
            sh5,
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
                btnName: "CONFIRM",
                isPressed: false,
                onPressed: () {
                  customDialog(context,
                      title: "Confirm Regist",
                      confirmButton: true,
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(_controllerEmail.text),
                            Text(_controllerPassword.text)
                          ],
                        ),
                      ), yesPressed: () {
                    print("Regist sucess!");
                    print("Regist success!");
                    print("Regist succsess!");
                  });
                }),
            ButtonWidget(
              btnName: "Login",
              isNavReplace: true,
              page: const LoginPage(),
            )
          ],
        ),
      ),
    );
  }
}
