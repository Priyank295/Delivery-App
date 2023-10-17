import 'package:flutter/material.dart';

Widget textField(BuildContext ctx, String text) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      // color: Colors.white,
    ),
    height: 50,
    child: TextField(
      cursorColor: Colors.black,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(129, 117, 117, 0.349),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(129, 117, 117, 0.349),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12)),
        hintText: text,
        contentPadding: EdgeInsets.only(left: 20, top: 15),
      ),
    ),
  );
}
