import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/custom_widgets/brandname.dart';
import 'package:alkhudhrah_app/designs/buttons_design.dart';
import 'package:alkhudhrah_app/helper/shared_pref_helper.dart';
import 'package:alkhudhrah_app/ui/welcome.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageSetting extends StatefulWidget {
  @override
  _LanguageSettingState createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {


  void onLanguageButtonPressed(BuildContext context , String localeName) async{
    //todo: edit locale problem


    if(localeName == 'en')
      await context.setLocale(Locale('en'));
    else   await context.setLocale(Locale('ar'));

    PreferencesHelper.setSelectedLanguage(localeName);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WelcomeScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: cardBackgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: brandName(250.0, 250.0, 30.0),
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: MaterialButton(
                onPressed: () {
                  onLanguageButtonPressed(context,'ar');
                },
                height: ButtonsDesign.buttonsHeight,
                shape: StadiumBorder(),
                child: ButtonsDesign.buttonsText('عربي',kWhite),
                color: kLogoBrown,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: MaterialButton(
                onPressed: () {
                  onLanguageButtonPressed(context,'en');
                },
                height: ButtonsDesign.buttonsHeight,
                shape: StadiumBorder(),
                child: ButtonsDesign.buttonsText('english',kWhite),
                color: kLogoGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}