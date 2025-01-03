// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomBorderedButton extends StatelessWidget {
  const CustomBorderedButton({
    super.key,
    required this.text,
    this.bgColor,
    this.fgColor,
    this.radius,
    this.onPressed,
  });
  final String text;
  final Color? bgColor;
  final Color? fgColor;
  final double? radius;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(bgColor ?? Colors.white),
        foregroundColor: MaterialStateProperty.all(fgColor ?? Colors.blue),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: BorderSide(color: fgColor ?? Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 5)),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 8, horizontal: 35),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}