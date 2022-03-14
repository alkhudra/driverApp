import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/designs/appbar_design.dart';
import 'package:alkhudhrah_app/designs/buttons_design.dart';
import 'package:alkhudhrah_app/helper/route_helper.dart';
import 'package:alkhudhrah_app/helper/shared_pref_helper.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/router/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

enum Languages { english, arabic }

class LanguageSetting extends StatefulWidget {
  @override
  _LanguageSettingState createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {
  void onLanguageButtonPressed(BuildContext context, String localeName) async {
    if (localeName == 'en')
      await context.setLocale(Locale('en'));
    else
      await context.setLocale(Locale('ar'));
    PreferencesHelper.setSelectedLanguage(localeName);
    moveToNewStack(context, dashBoardRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: appBarDesign(context, LocaleKeys.app_lang.tr()),
      body: Container(
        // margin: EdgeInsets.only(top: 100),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: kWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Text(
                LocaleKeys.select_lang.tr() + ':',
                style: TextStyle(
                    color: kBlack.withOpacity(0.7),
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 40, right: 40),
              child: MaterialButton(
                onPressed: () {
                  onLanguageButtonPressed(context, 'ar');
                },
                height: ButtonsDesign.buttonsHeight,
                shape: StadiumBorder(),
                child: ButtonsDesign.buttonsText(
                    'عربي', kWhite, 15),
                color: kLogoBrown,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 40, right: 40),
              child: MaterialButton(
                onPressed: () {
                  onLanguageButtonPressed(context, 'en');
                },
                height: ButtonsDesign.buttonsHeight,
                shape: StadiumBorder(),
                child: ButtonsDesign.buttonsText(
                    'english', kWhite, 15),
                color: kLogoGreen,
              ),
            ),
          ],
        ),
      ),
      // endDrawer: drawerDesign(context),
    );
  }
}
