// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.labelText,
    this.hintText,
    this.textEditingController,
    this.validator,
    this.keyboardType,
  });
  final TextEditingController? textEditingController;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final String? Function(String? fieldContent)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: textEditingController,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        fillColor: Colors.white,
        filled: true,
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}
