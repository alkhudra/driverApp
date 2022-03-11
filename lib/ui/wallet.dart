import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/designs/appbar_design.dart';
import 'package:alkhudhrah_app/designs/bottom_nav_bar.dart';
import 'package:alkhudhrah_app/designs/drawer_design.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:easy_localization/easy_localization.dart';

import 'home.dart';
import 'my_orders.dart';
import 'notifications.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({ Key? key }) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: appBarDesign(context, LocaleKeys.wallet.tr()),
      body: Container()
    );
  }
}