import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/designs/buttons_design.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Widget greenBtn(
    String txt, EdgeInsetsGeometry edgeInsetsGeometry, Function() onPressed) {
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

Widget redBtn(
    String txt, EdgeInsetsGeometry edgeInsetsGeometry, Function() onPressed) {
  return Container(
      height: ButtonsDesign.buttonsHeight,
      margin: edgeInsetsGeometry,
      child: MaterialButton(
        onPressed: onPressed,
        shape: StadiumBorder(),
        child: ButtonsDesign.buttonsText(txt, kWhite, 15),
        color: kRed,
      ));
}

Widget greenBtnWithIcon(String txt, IconData icon,
    EdgeInsetsGeometry edgeInsetsGeometry, Function() onPressed) {
  return Container(
      height: ButtonsDesign.buttonsHeight,
      margin: edgeInsetsGeometry,
      decoration: BoxDecoration(),
      child: MaterialButton(
        onPressed: onPressed,
        shape: StadiumBorder(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: kWhite,
            ),
            SizedBox(width: 15),
            ButtonsDesign.buttonsText(txt, kWhite, 15),
          ],
        ),
        color: kLogoGreen,
      ));
}

Widget loadMoreBtn(BuildContext context, Function() onPressed) {
  return Container(
    margin: EdgeInsets.only(top:20, bottom: 40),
    alignment: Alignment.bottomCenter,
    child: SizedBox(
      height: 45,
      width: 180,
      child: FloatingActionButton(
        child: Text(LocaleKeys.load_more.tr(), style: TextStyle(
            fontWeight: FontWeight.w600
        ),),
        onPressed: () {
         onPressed();
        },
        backgroundColor: kGray,
        foregroundColor: kDarkBlue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40)
        ),
        elevation: 0.0,
      ),
    ),
  );
}

Widget unAvailableBtn(String txt, EdgeInsetsGeometry edgeInsetsGeometry, double scHeight, double txtSize) {
  return Container(
    // height: ButtonsDesign.buttonsHeight,
    height: scHeight,
    margin: edgeInsetsGeometry,
    decoration: BoxDecoration(
      color: kLogoBrown.withOpacity(0.6),
      borderRadius: BorderRadius.circular(30),
    ),
    child: ButtonsDesign.buttonsText(txt, kWhite, txtSize),
  );
}

Widget cartBtn(IconData icon,
    EdgeInsetsGeometry edgeInsetsGeometry, Function() onPressed) {
  return Container(
      height: 40,
      width: 80,
      margin: edgeInsetsGeometry,
      decoration: BoxDecoration(),
      child: MaterialButton(
        onPressed: onPressed,
        shape: StadiumBorder(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: kWhite,
              size: 26,
            ),
          ],
        ),
        color: kLogoGreen,
      ));
}