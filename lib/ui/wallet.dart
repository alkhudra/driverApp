import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/designs/appbar_design.dart';
import 'package:alkhudhrah_app/designs/bottom_nav_bar.dart';
import 'package:alkhudhrah_app/designs/drawer_design.dart';
import 'package:alkhudhrah_app/helper/shared_pref_helper.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/network/models/driver_user.dart';
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

  String name = '', email = '', image = '';

  void setValues() async {
  DriverUser user = await PreferencesHelper.getUser;
  name = user.driverName!;
  email = user.email!;
  image = user.image!;
  }
  
  @override
  void initState() {
    // TODO: implement initState
    setValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: bnbAppBar(context, LocaleKeys.wallet.tr()),
      // endDrawer: drawerDesign(context, name, email, image),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(LocaleKeys.credit.tr() + ' : ',
              style: TextStyle(
                color: kLogoGreen,
                fontWeight: FontWeight.w600,
                fontSize: 18
              ),),
            ),
            SizedBox(width: 5,),
                        Container(
              child: Text(' -  ' + LocaleKeys.sar.tr(),
              style: TextStyle(
                color: kDarkGray.withOpacity(0.8),
                fontWeight: FontWeight.w500,
                fontSize: 17
              ),),
            ),
          ],
        ),
      ),
    );
  }
}