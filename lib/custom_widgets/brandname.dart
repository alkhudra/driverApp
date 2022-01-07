import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
            color: kLogoGreen,
          ),
          children: <TextSpan> [
            TextSpan(text: LocaleKeys.alkhadra_united.tr()),
          ]
        ),
      ),
    ],
  );
}

Widget brandNameMiddle(){
  return Container(
    margin: EdgeInsets.only(top: 50),
    alignment: Alignment.topCenter,
    child: brandName(115.0, 115.0, 20.0),
  );
}