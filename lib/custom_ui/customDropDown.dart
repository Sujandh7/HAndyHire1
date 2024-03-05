import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDropDown extends StatelessWidget {
  String? Function(String?)? validator;
  Function(String?)? onChanged;
  InputDecoration? decoration;
  String? value;
  Widget? icon;
  CustomDropDown(
      {super.key,
      required this.itemList,
      this.decoration,
      this.icon,
      this.onChanged,
      this.validator,
      this.value});
  

  List<String> itemList;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        items: itemList
            .map((e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ))
            .toList(),
        icon: icon,
        decoration: decoration,
        validator: validator,
        value: value,
        onChanged: onChanged);
  }
}
