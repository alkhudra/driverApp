import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/designs/buttons_design.dart';
import 'package:flutter/material.dart';


Widget greenBtn(String txt,EdgeInsetsGeometry edgeInsetsGeometry, Function() onPressed) {
  return Container(
      height: ButtonsDesign.buttonsHeight,
      margin: edgeInsetsGeometry,

      child: MaterialButton(
        onPressed: onPressed,
        shape: StadiumBorder(),
        child: ButtonsDesign.buttonsText(txt, kWhite, 15),
        color: kLogoGreen,
      ));
}

payButtonDesign(context, color, text, iconData) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.27,
    height: MediaQuery.of(context).size.height * 0.094,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: color)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          iconData,
          color: color,
          size: 25,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Text(
            text,
            style: TextStyle(color: color, fontSize: 13),
          ),
        )
      ],
    ),
  );
}
