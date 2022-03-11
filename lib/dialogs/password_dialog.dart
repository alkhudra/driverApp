//-------------------------

import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/designs/buttons_design.dart';
import 'package:alkhudhrah_app/designs/card_design.dart';
import 'package:alkhudhrah_app/designs/textfield_design.dart';
import 'package:alkhudhrah_app/helper/forget_pass_helper.dart';
import 'package:alkhudhrah_app/helper/info_correcter_helper.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Widget showEnterEmailDialog(BuildContext context,bool isForgetPassBtnEnabled) {
  final TextEditingController controller = TextEditingController();
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //this right here
    child: Container(
      height: CardDesign.cardsHeight,
      width: CardDesign.cardsWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            LocaleKeys.reset_PW_title.tr(),
            style: TextStyle(
              fontSize: 20,
              color: kDarkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (!isValidEmail(controller.text)) {
                  return LocaleKeys.invalid_email.tr();
                }
              },
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                  color: kBlack,
                  fontWeight: FontWeight.bold),
              decoration: textFieldDecorationWithIcon(
                  LocaleKeys.email_textfield.tr(), Icons.email),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Container(
              height: ButtonsDesign.buttonsHeight,
              margin: EdgeInsets.only(left: 50, right: 50),
              child: MaterialButton(
                onPressed: () {
                  if(isForgetPassBtnEnabled)
                    forgetPasswordProcess(context,controller.text,isForgetPassBtnEnabled);
                },
                shape: StadiumBorder(),
                child: ButtonsDesign.buttonsText(
                    LocaleKeys.reset_PW_btn.tr(),
                    kWhite, 15),
                color: kLogoGreen,
              ))
        ],
      ),
    ),
  );
}