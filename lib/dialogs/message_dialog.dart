
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/ui/login_email.dart';
import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:alkhudhrah_app/router/route_constants.dart';

Widget showMessageDialog(BuildContext context, String title, String txt,String pageRout) {
  if (Platform.isIOS) {
    return CupertinoAlertDialog(
      title: Text(title), // To display the title it is optional
      content: Text(txt), // Message which will be pop up on the screen
      actions: [
        if(pageRout == loginRoute)
          directToLoginPageBtns(context)
        else
        messageDialogBtns(context ),
      ],
    );
  } else {
    return AlertDialog(
      title: Text(title), // To display the title it is optional
      content: Text(txt), // Message which will be pop up on the screen
      actions: [
        if(pageRout == loginRoute)
          directToLoginPageBtns(context)
        else
          messageDialogBtns(context ),
      ],
    );
  }
}

TextButton messageDialogBtns(BuildContext context) {
  return TextButton(
    style: TextButton.styleFrom(
      backgroundColor: kLogoGreen,
    ),
    onPressed: () {
      Navigator.pop(context);
      },
    child: Text(
      LocaleKeys.ok.tr(),
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}


TextButton directToLoginPageBtns(BuildContext context) {

  return TextButton(
    style: TextButton.styleFrom(
      backgroundColor: kLogoGreen,
    ),
    onPressed: () {
      Navigator.pop(context);
      Navigator.push(context,

          MaterialPageRoute(builder: (context) {
            return LoginEmail();
          }));
    },
    child: Text(
      LocaleKeys.ok.tr(),
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}