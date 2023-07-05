import 'package:flutter/material.dart';
import 'package:test_aplikasi/utils/constant.dart';
import 'package:test_aplikasi/widgets/transition_widget.dart';

class ButtonWidget extends StatefulWidget {
  ButtonWidget(
      {required this.btnName,
      this.isNavPush = false,
      this.isNavReplace = false,
      this.isNavBack = false,
      this.isPressed = true,
      this.onPressed,
      this.page,
      super.key});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();

  String btnName;
  bool isNavPush;
  bool isNavReplace;
  bool isNavBack;
  bool isPressed;
  Widget? page;
  VoidCallback? onPressed;
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isPressed
          ? () => widget.isNavBack
              ? navBackTransition(context)
              : widget.isNavPush
                  ? navPushTransition(context, widget.page!)
                  : widget.isNavReplace
                      ? navReplaceTransition(context, widget.page!)
                      : widget.page
          : widget.onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          side: const BorderSide(
            width: 1,
          )),
      child: Text(widget.btnName, style: buttonTS),
    );
  }
}
