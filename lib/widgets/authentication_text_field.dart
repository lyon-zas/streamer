import 'package:flutter/material.dart';

Widget authenticationTextField(
    {required TextEditingController controller,
    required TextInputType keyboardType,
    required String hintText,
    required String label}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 5),
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
      TextField(
        keyboardType: keyboardType,
        cursorColor: Colors.white30,
        controller: controller,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        decoration: InputDecoration(
            hintText: hintText,
            focusColor: Colors.white30,
            hoverColor: Colors.white30,
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white30)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white30)),
            hintStyle: const TextStyle(color: Colors.white30)),
      ),
    ],
  );
}
