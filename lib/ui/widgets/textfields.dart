import 'package:flutter/material.dart';

class CustomTextFields extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? Function(String?) validation;

  const CustomTextFields(
      {super.key,
      required this.controller,
      required this.hint,
      required this.validation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffF7F8F9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hint,
            hintStyle: const TextStyle(
                color: Color(0xff8391A1),
                fontSize: 15,
                fontWeight: FontWeight.w500),
            contentPadding: const EdgeInsetsDirectional.symmetric(
                horizontal: 25, vertical: 20),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(
                  color: Color(0xffDADADA),
                ))),
        validator: validation,
      ),
    );
  }
}
