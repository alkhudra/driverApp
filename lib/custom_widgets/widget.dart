import 'package:flutter/material.dart';

Widget brandName(logoW, logoH, fontS) {
  return Column(
    children: [
      //company logo
      Container(
        width: logoW,
        height: logoH,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            //TODO: change image to company logo
            image: AssetImage('assets/images/logo.png')
          )
        ),
      ),
      SizedBox(height: 20,),
      //company name
      RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: fontS,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(103, 156, 65, 1),
          ),
          children: <TextSpan> [
            TextSpan(text: "Alkhadra United"),
          ]
        ),
      ),
    ],
  );
}