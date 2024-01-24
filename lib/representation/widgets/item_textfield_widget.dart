import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';

class ItemTextField extends StatelessWidget {
  final dynamic controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  const ItemTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }
}
