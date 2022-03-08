import 'package:flutter/material.dart';
import 'package:alkhudhrah_app/designs/buttons_design.dart';
import 'package:alkhudhrah_app/custom_widgets/brandname.dart';
import 'package:alkhudhrah_app/helper/shared_pref_helper.dart';
import 'package:alkhudhrah_app/ui/login_email.dart';
import 'package:alkhudhrah_app/ui/home.dart';
import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/router/route_constants.dart';
import 'package:easy_localization/easy_localization.dart';


class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  @override
  void initState() {

    super.initState();
    print('welcome in language ');
  }

  void onLanguageButtonPressed(BuildContext context , String localeName) async{


    if(localeName == 'en')
      await context.setLocale(Locale('en'));
    else   await context.setLocale(Locale('ar'));
  //  PreferencesHelper.setUserFirstLogIn(false);

    PreferencesHelper.setSelectedLanguage(localeName);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LoginEmail();
    }));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
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
              child: ButtonsDesign.buttonsText('عربي', kWhite, 15),
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
              child: ButtonsDesign.buttonsText('english',kWhite, 15),
              color: kLogoGreen,
            ),
          ),
        ],
      ),
    );
  }
}
