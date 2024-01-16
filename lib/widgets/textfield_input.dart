import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  TextFieldInput({
    required this.textEditingController,
    required this.keyboardType,
    required this.hintText,
    this.ispass = false,
    super.key,
  });
  final String hintText;
  TextEditingController textEditingController;
  final keyboardType;
  final ispass;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        border: inputBorder,
        filled: true,
        contentPadding: EdgeInsets.all(8),
      ),
      keyboardType: keyboardType,
      obscureText: ispass,
    );
  }
}
