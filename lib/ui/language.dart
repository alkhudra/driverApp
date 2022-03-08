import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/custom_widgets/brandname.dart';
import 'package:alkhudhrah_app/designs/bottom_nav_bar.dart';
import 'package:alkhudhrah_app/designs/buttons_design.dart';
import 'package:alkhudhrah_app/designs/drawer_design.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:alkhudhrah_app/ui/wallet.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'home.dart';
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
        backgroundColor: Colors.grey[100],
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              // collapsedHeight: 200,
              title: Text(LocaleKeys.app_lang.tr(), style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22
              ),),
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    left: 180,
                    child: Image.asset('assets/images/grapevector.png'),
                  ),
                ],
              ),
              expandedHeight: 160,
              elevation: 0.0,
              backgroundColor: kLogoGreen,
              iconTheme: IconThemeData(color: kWhite),
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios), 
                color: kWhite,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
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
            Container(
              margin: EdgeInsets.only(left: 40, right: 40),
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
              margin: EdgeInsets.only(left: 40, right: 40),
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
                    // ListTile(
                    //   title: Text(LocaleKeys.english.tr(),
                    //   style: TextStyle(
                    //     color: kLogoGreen,
                    //     fontWeight: FontWeight.w700
                    //   ),),
                    //   leading: Radio<Languages>(
                    //     activeColor: kLogoGreen,
                    //     value: Languages.english,
                    //     groupValue: _character,
                    //     onChanged: (Languages? value) {
                    //       setState(() {
                    //         _character = value;
                    //         onLanguageButtonPressed(context,'en');
                    //       });
                    //     },
                    //   ),
                    // ),
                    //add english button

                    // ListTile(
                    //   title: Text(LocaleKeys.arabic.tr(),
                    //   style: TextStyle(
                    //     color: kLogoGreen,
                    //     fontWeight: FontWeight.w700
                    //   ),),
                    //   leading: Radio<Languages>(
                    //     activeColor: kLogoGreen,
                    //     value: Languages.arabic,
                    //     groupValue: _character,
                    //     onChanged: (Languages? value) {
                    //       setState(() {
                    //         _character = value;
                    //         onLanguageButtonPressed(context,'ar');
                    //       });
                    //     },
                    //   ),
                    // ),
                    //add arabic button
                  ],
                ),
              ),
            ),
          ],
        ),
        endDrawer: drawerDesign(context),
      ),
    );
  }
}