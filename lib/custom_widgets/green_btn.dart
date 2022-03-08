import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/designs/buttons_design.dart';
import 'package:flutter/cupertino.dart';
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
