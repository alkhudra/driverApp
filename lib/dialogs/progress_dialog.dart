import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:alkhudhrah_app/constants/colors.dart';

showLoaderDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      if (Platform.isIOS)
        return iosProgress();
      else
        return androidProgress();
    },
  );
}

AlertDialog androidProgress() {
  return AlertDialog(
    content:alertContent(),
  );
}

CupertinoAlertDialog iosProgress() {
  return CupertinoAlertDialog(
    content:alertContent(),
  );
}


Widget alertContent(){
 return Column(
    children: [
      CircularProgressIndicator(color: kLogoGreen,),
      SizedBox(
        height: 5,
      ),
      Container(child: Text(LocaleKeys.wait.tr())),
    ],
  );
}