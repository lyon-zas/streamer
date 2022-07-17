import 'package:flutter/material.dart';

Widget homeScreenTextField({required TextEditingController controller}) {
  return TextField(
    controller: controller,
    style: TextStyle(color: Colors.grey[500]),
    decoration: InputDecoration(
        suffixIcon: const Icon(
          Icons.check_box,
          size: 30,
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 1.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 1.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[500]),
        hintText: "Type in your text",
        fillColor: Colors.grey.shade900),
  );
}
