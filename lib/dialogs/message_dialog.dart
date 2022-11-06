
import 'dart:io';
import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/helper/route_helper.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/router/route_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alkhudhrah_app/main.dart';
import 'package:alkhudhrah_app/ui/login_email.dart';
import 'package:easy_localization/easy_localization.dart';

Widget showMessageDialog(BuildContext context, String title, String txt,String pageRout) {
  if (Platform.isIOS) {
    return CupertinoAlertDialog(
      title: Text(title), // To display the title it is optional
      content: Text(txt), // Message which will be pop up on the screen
      actions: [
        if(pageRout != noPage)
          directToPageBtns(context,pageRout)
        else
        messageDialogBtns(context ),
      ],
    );
  } else {
    return AlertDialog(
      title: Text(title), // To display the title it is optional
      content: Text(txt), // Message which will be pop up on the screen
      actions: [
        if(pageRout != noPage)
          directToPageBtns(context,pageRout)
        else
          messageDialogBtns(context ),
      ],
    );
  }
}

//------------------------------------
MaterialButton messageDialogBtns(BuildContext context) {
  return MaterialButton(
    textColor: kLogoGreen,
    onPressed: () {
      Navigator.pop(context);
      },
    child: Text(
      LocaleKeys.ok.tr(),
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
//------------------------------------


MaterialButton directToPageBtns(BuildContext context,String route) {

  return MaterialButton(
    textColor: kLogoGreen,
    onPressed: () {
      Navigator.pop(context);

      moveToNewStack(context , route);


    },
    child: Text(
      LocaleKeys.ok.tr(),
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}


void showErrorMessageDialog(BuildContext context ,String txt) {
  showDialog<String>(
      context: context,
      builder: (BuildContext context) =>
          showMessageDialog(context, LocaleKeys.error.tr(), txt, noPage));
}