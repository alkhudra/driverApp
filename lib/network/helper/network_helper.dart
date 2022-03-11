import 'package:alkhudhrah_app/designs/no_item_design.dart';
import 'package:alkhudhrah_app/dialogs/progress_dialog.dart';
import 'package:alkhudhrah_app/helper/shared_pref_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:alkhudhrah_app/constants/colors.dart';
import 'package:alkhudhrah_app/locale/locale_keys.g.dart';
import 'package:lottie/lottie.dart';

Future<Map<String, dynamic>> getHeaderMap() async {
  String token = await PreferencesHelper.getUserToken;

  String selectedLanguage = await PreferencesHelper.getSelectedLanguage;
  print('token from method $token');
  print('selectedLanguage from method $selectedLanguage');
  return {
    "Accept-Language": "$selectedLanguage",
    "Authorization": "Bearer $token"
  };
}

Future<Map<String, dynamic>> getAuthHeaderMap() async {
  String selectedLanguage = await PreferencesHelper.getSelectedLanguage;
  print('selectedLanguage from method $selectedLanguage');
  return {
    "Accept-Language": "$selectedLanguage",

  };
}


Widget errorCase(AsyncSnapshot<dynamic?> snapshot) {
   if (snapshot.hasError) {
    return Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          height: 250,
          child: Image.asset(
            'images/logo.png',
            ),
        ),
        SizedBox(height: 15,),
        // Text('Oops!', style: TextStyle(
        //   color: CustomColors().darkBlueColor,
        //   fontSize: 16,
        //   fontWeight: FontWeight.w700
        // ),),
        SizedBox(height: 5,),
        errorText('${snapshot.error}'),

        // Image(image: AssetImage('images/green_fruit.png')),
        // Text('${snapshot.error}' ,),
      ],
    ));
   } else

    // By default, show a loading spinner.
     return loadingProgress();
}
