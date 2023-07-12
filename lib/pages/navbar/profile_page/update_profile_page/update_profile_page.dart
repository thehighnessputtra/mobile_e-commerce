import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:test_aplikasi/pages/navbar/navbar.dart';
import 'package:test_aplikasi/services/firebase_services.dart';
import 'package:test_aplikasi/utils/constant.dart';
import 'package:test_aplikasi/widgets/button_widget.dart';
import 'package:test_aplikasi/widgets/dialog_widget.dart';
import 'package:test_aplikasi/widgets/textfield_widget.dart';
import 'package:test_aplikasi/widgets/transition_widget.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  String avaName = "...";
  String avaURL =
      "https://w7.pngwing.com/pngs/321/641/png-transparent-load-the-map-loading-load-waiting-thumbnail.png";
  String email = "...";
  String nama = "...";
  TextEditingController controllerNama = TextEditingController();

  Future getDocID() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          avaURL = value.data()!['avatarURL'];
          avaName = value.data()!['avatarName'];
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
                                Icons.camera_alt,
                                size: 20,
                                color: Colors.white,
                              ))),
                    ))
              ],
            ),
          ),
          sh20,
          TextFieldWidget(
            controllerName: controllerNama,
            fieldName: nama,
          ),
          TextFieldWidget(
            isReadOnly: true,
            fieldName: email,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonWidget(
                btnName: "Update",
                isPressed: true,
                onPressed: () {
                  customDialog(context,
                      title: "KONFIRMASI", confirmButton: true, yesPressed: () {
                    FirebaseService(FirebaseAuth.instance).updateProfile(
                        email: email,
                        name: controllerNama.text == ""
                            ? nama
                            : controllerNama.text,
                        avaURL: avaURL,
                        avaName: avaName,
                        context: context);
                  },
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Nama = ${controllerNama.text == "" ? nama : controllerNama.text}",
                                style: dialogContentTS),
                          ],
                        ),
                      ));
                },
              ),
              ButtonWidget(
                btnName: "Kembali",
                isPressed: true,
                onPressed: () {
                  navReplaceTransition(
                      context,
                      NavBottomBar(
                        currentIndex: 3,
                      ));
                },
              ),
            ],
          ),
        ]),
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
      await storage.ref('users/$email/avatar/$fileName').putFile(File(path));
      String getDownloadUrl =
          await storage.ref('users/$email/avatar/$fileName').getDownloadURL();
      // print("DOWNLOAD AVATAR = $getDownloadUrl");
      setState(() {
        avaName = fileName;
        avaURL = getDownloadUrl;
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
