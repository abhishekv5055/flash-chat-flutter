import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Function onChanged;
  final TextInputType keyboardType;
  final bool obscureText;

  InputTextField({
    this.hintText,
    this.labelText,
    @required this.onChanged,
    this.keyboardType,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
      ),
    );
  }
}
