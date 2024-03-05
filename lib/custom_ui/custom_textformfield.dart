import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomForm extends StatelessWidget {
  CustomForm({
    super.key,
    this.labelText,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.hintText,
    this.keyboardType,
    required this.obscureText,
  });
String? hintText;
TextInputType? keyboardType;
  String? labelText;
  String? Function(String?)? validator;
  Widget? suffixIcon;
  Widget? prefixIcon;
  Function(String)? onChanged;
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,

      ),
    );
  }
}
