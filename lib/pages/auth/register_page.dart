import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:test_aplikasi/pages/auth/login_page.dart';
import 'package:test_aplikasi/services/firebase_services.dart';
import 'package:test_aplikasi/utils/constant.dart';
import 'package:test_aplikasi/widgets/button_widget.dart';
import 'package:test_aplikasi/widgets/dialog_widget.dart';
import 'package:test_aplikasi/widgets/textfield_widget.dart';
import 'package:file_picker/file_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

TextEditingController _controllerNama = TextEditingController();
TextEditingController _controllerEmail = TextEditingController();
TextEditingController _controllerPassword = TextEditingController();

class _RegisterPageState extends State<RegisterPage> {
  String? avatarName;
  String? avatarURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: pagePadding,
        physics: const BouncingScrollPhysics(),
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
                    image: NetworkImage(avatarURL == null
                        ? "https://www.pngmart.com/files/21/Admin-Profile-Vector-PNG-Clipart.png"
                        : avatarURL!),
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                  ))),
                  Positioned(
                      bottom: 0,
                      right: 4,
                      child: InkWell(
                        onTap: () async {
                          uploadImage();
                        },
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
                isPressed: true,
                onPressed: () {
                  customDialog(context,
                      title: "Confirm Regist",
                      confirmButton: true,
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nama : ${_controllerNama.text}",
                                style: dialogContentTS),
                            Text("Email : ${_controllerEmail.text}",
                                style: dialogContentTS),
                          ],
                        ),
                      ), yesPressed: () {
                    FirebaseService(FirebaseAuth.instance).signUpEmail(
                        email: _controllerEmail.text,
                        password: _controllerPassword.text,
                        name: _controllerNama.text,
                        avaURL: avatarURL!,
                        avaName: avatarName!,
                        context: context);
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

  uploadImage() async {
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);
    if (result != null) {
      final path = result.files.single.path!;
      final fileName = result.files.single.name;

      FirebaseStorage storage = FirebaseStorage.instance;
      await storage
          .ref('users/${_controllerEmail.text}/avatar/$fileName')
          .putFile(File(path));
      String getDownloadUrl = await storage
          .ref('users/${_controllerEmail.text}/avatar/$fileName')
          .getDownloadURL();
      // print("DOWNLOAD AVATAR = $getDownloadUrl");
      setState(() {
        avatarName = fileName;
        avatarURL = getDownloadUrl;
      });

      // ignore: use_build_context_synchronously
      customDialog(context,
          title: "INFO", content: const Text("Avatar sukses diupload!"));
    } else {
      customDialog(context,
          title: "INFO", content: const Text("Avatar gagal diupload!"));
    }
  }
}
