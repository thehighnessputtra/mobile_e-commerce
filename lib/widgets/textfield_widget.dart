import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget(
      {this.fieldName,
      this.controllerName,
      this.isVisibility = false,
      this.isReadOnly = false,
      this.validator,
      super.key});
  TextEditingController? controllerName;
  String? fieldName;
  bool? isVisibility;
  FormFieldValidator? validator;
  bool? isReadOnly;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool hideText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        readOnly: widget.isReadOnly!,
        controller: widget.controllerName,
        obscureText: widget.isVisibility! ? hideText : false,
        validator: widget.validator,
        decoration: InputDecoration(
          isDense: true,
          hintText: widget.fieldName,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(1)),
          ),
          suffixIcon: widget.isVisibility!
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      hideText = !hideText;
                    });
                  },
                  icon:
                      Icon(hideText ? Icons.visibility : Icons.visibility_off))
              : const SizedBox(),
        ));
  }
}
