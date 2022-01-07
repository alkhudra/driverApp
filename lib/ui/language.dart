import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/custom_widgets/brandname.dart';
import 'package:alkhudhrah_app/designs/buttons_design.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/ui/wallet.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'home.dart';
import 'login_email.dart';
import 'my_orders.dart';
import 'notifications.dart';

enum Languages { english, arabic }

class LanguageSetting extends StatefulWidget {

  @override
  _LanguageSettingState createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {

  Languages? _character = Languages.english;


  void onLanguageButtonPressed(BuildContext context , String localeName) async{
    //todo: edit locale problem


    if(localeName == 'en')
      await context.setLocale(Locale('en'));
    else   await context.setLocale(Locale('ar'));

    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return LanguageSetting();
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.app_lang.tr()),
          backgroundColor: kLogoGreen,
        ),
        backgroundColor: kWhite,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Text(LocaleKeys.select_lang.tr()+':',
              style: TextStyle(
                color: kBlack.withOpacity(0.7),
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),),
            ),
            SizedBox(
              height: 20,
            ),
             ListTile(
              title: Text(LocaleKeys.english.tr(),
              style: TextStyle(
                color: kLogoGreen,
                fontWeight: FontWeight.w700
              ),),
              leading: Radio<Languages>(
                activeColor: kLogoGreen,
                value: Languages.english,
                groupValue: _character,
                onChanged: (Languages? value) {
                  setState(() {
                    _character = value;
                    onLanguageButtonPressed(context,'en');
                  });
                },
              ),
            ),
            ListTile(
              title: Text(LocaleKeys.arabic.tr(),
              style: TextStyle(
                color: kLogoGreen,
                fontWeight: FontWeight.w700
              ),),
              leading: Radio<Languages>(
                activeColor: kLogoGreen,
                value: Languages.arabic,
                groupValue: _character,
                onChanged: (Languages? value) {
                  setState(() {
                    _character = value;
                    onLanguageButtonPressed(context,'ar');
                  });
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: GNav(
          backgroundColor: kWhite,
          rippleColor: kGray, // tab button ripple color when pressed
          hoverColor: kGray, // tab button hover color
          haptic: true, // haptic feedback
          tabBorderRadius: 20, 
          tabActiveBorder: Border.all(color: kLogoGreen, width: 1), // tab button border
          // tabBorder: Border.all(color: kLightGreen, width: 1), // tab button border
          // tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
          curve: Curves.easeOutCubic, // tab animation curves
          duration: Duration(milliseconds: 500), // tab animation duration
          gap: 8, // the tab button gap between icon and text 
          color: kBlack.withOpacity(0.4), // unselected icon color
          activeColor: kWhite, // selected icon and text color
          iconSize: 28, // tab button icon size
          tabBackgroundColor: kLogoGreen, // selected tab background color
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // navigation bar padding
          tabMargin: EdgeInsets.symmetric(horizontal: 3, vertical: 8),
          tabs: [
            GButton(
              icon: Icons.add_shopping_cart_outlined,
              text: LocaleKeys.new_orders.tr(),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Homescreen(),
                ));
              },
            ),
            GButton(
              icon: Icons.price_change,
              text: LocaleKeys.wallet.tr(),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => WalletScreen(),
                ));
              },
            ),
            GButton(
              icon: Icons.checklist_outlined,
              text: LocaleKeys.my_orders.tr(),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MyOrdersScreen(),
                ));
              },
            ),
            GButton(
              icon: Icons.notifications_none_outlined,
              text: LocaleKeys.notifications_tab.tr(),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                builder: (context) => NotificationsScreen(),
                ));
              },
            )
          ]
        ),
      ),
    );
  }
}