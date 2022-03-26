import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alkhudhrah_app/constants/api_const.dart';
import 'package:alkhudhrah_app/constants/cont.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:alkhudhrah_app/dialogs/progress_dialog.dart';
import 'package:alkhudhrah_app/helper/custom_btn.dart';
import 'package:alkhudhrah_app/helper/image_helper.dart';
import 'package:alkhudhrah_app/network/API/api_response.dart';
import 'package:alkhudhrah_app/network/API/api_response_type.dart';
import 'package:alkhudhrah_app/network/helper/exception_helper.dart';
import 'package:alkhudhrah_app/network/helper/network_helper.dart';
import 'package:alkhudhrah_app/network/models/message_response_model.dart';
import 'package:alkhudhrah_app/network/models/product/product_model.dart';
import 'package:alkhudhrah_app/constants/colors.dart';

Widget cartDetailsItem(String title, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
    child: RichText(
      text: TextSpan(
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Almarai',
            color: kLogoGreen,
          ),
          children: <TextSpan>[
            TextSpan(
                text: title + ': ',
                style: TextStyle(color: kDarkBlue)),
            TextSpan(
                text: value,
                style: TextStyle(
                  color: kLogoGreen,
                  fontFamily: 'Almarai',
                )),
          ]),
    ),
  );
}

Widget cartTotalDesign(num total) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: RichText(
      text: TextSpan(
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            fontFamily: 'Almarai',
            color: kLogoGreen,
          ),
          children: <TextSpan>[
            TextSpan(
                text: LocaleKeys.total.tr() + ': ',
                style: TextStyle(
                  color: kLogoGreen,
                )),
            TextSpan(
                text: getTextWithCurrency(total),
                style: TextStyle(
                  color: kLogoGreen,
                )),
          ]),
    ),
  );
}


String currency = LocaleKeys.sar.tr();

String getTextWithCurrency(num value) {
  return ' $value ' + currency;
}

String getTextWithPercentage(num value) {
  return ' $value %';
}
