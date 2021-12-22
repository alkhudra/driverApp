import 'package:flutter/cupertino.dart';
import 'package:alkhudhrah_app/constants/colors.dart';

class CardDesign {
  static const double cardsHeight = 350;
  static const double cardsWidth = 400;

  static BoxDecoration largeCardDesign() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: cardShadowBackgroundColor,
            offset: Offset(0.2, 6.0),
            blurRadius: 6.0,
            spreadRadius: -2.0),
      ],
      borderRadius: BorderRadius.circular(50),
      color: cardBackgroundColor1,
      border: Border.all(color: cardBackgroundColor),
    );
  }
}