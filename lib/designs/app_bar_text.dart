import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appBarText(String txt, bool backBtnEnabled, {actions}) {
  return AppBar(
    actions: actions,
    centerTitle: true,
    backgroundColor: kCard,
    automaticallyImplyLeading: backBtnEnabled,
    iconTheme: IconThemeData(
      color: kDarkBlue,
    ),
    title: Text(
      txt.toUpperCase(),
      style: TextStyle(color: kDarkBlue),
    ),
  );
}
