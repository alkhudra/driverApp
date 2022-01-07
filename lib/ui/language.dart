import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/custom_widgets/brandname.dart';
import 'package:alkhudhrah_app/designs/buttons_design.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

<<<<<<< HEAD
class LanguageSetting extends StatefulWidget {
=======
import 'login_email.dart';

class LanguageScreen extends StatefulWidget {
>>>>>>> 9396e415e47a6419c2b9a45da5f9aa563241745a
  @override
  _LanguageSettingState createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {


  void onLanguageButtonPressed(BuildContext context , String localeName) async{
    //todo: edit locale problem


    if(localeName == 'en')
      await context.setLocale(Locale('en'));
    else   await context.setLocale(Locale('ar'));

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginEmail();
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