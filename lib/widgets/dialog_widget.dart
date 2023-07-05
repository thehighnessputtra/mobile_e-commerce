import 'package:flutter/material.dart';
import 'package:test_aplikasi/utils/constant.dart';

void customDialog(BuildContext context,
    {required String title,
    required Widget content,
    VoidCallback? yesPressed,
    bool confirmButton = false}) async {
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          content: content,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          actions: [
            confirmButton
                ? Row(children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: yesPressed,
                          child: Text("Yes",
                              style: buttonTS.copyWith(color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Colors.lightBlue),
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "No",
                            style: buttonTS.copyWith(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ])
                : SizedBox()
          ]);
    },
  );
}
