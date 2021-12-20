import 'package:flutter/material.dart';

Widget textButton({btnName, btnFunc}) {
  return TextButton(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(60),
      ),
      fixedSize: Size(250.0, 70.0),
      backgroundColor: Color.fromRGBO(103, 156, 65, 1),
    ),
    onPressed: btnFunc(),
    child: Text(btnName, style: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),),
  );
}