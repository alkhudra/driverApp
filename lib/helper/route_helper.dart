import 'package:alkhudhrah_app/helper/shared_pref_helper.dart';
import 'package:alkhudhrah_app/network/helper/network_helper.dart';
import 'package:alkhudhrah_app/network/repository/contact_us_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:alkhudhrah_app/router/route_constants.dart';
import 'package:flutter/material.dart';

void moveToNewStack(BuildContext context , String routeString){
  Navigator.of(context).pushNamedAndRemoveUntil(routeString, (Route<dynamic> route) => false);

}
void moveToNewStackWithArgs(context, MaterialPageRoute materialPageRoute) {
  Navigator.pushAndRemoveUntil(context,  materialPageRoute, (route) => false);

}


void logoutUser(context)async{


 Map<String, dynamic> map = await getHeaderMap();

 await ContactUsRepository(map).logoutUser().then((value) => print('success'));

  PreferencesHelper.setUser(null);
  PreferencesHelper.setUserLoggedIn(false);
  PreferencesHelper.setUserFirstLogIn(false);

  moveToNewStack(context, loginRoute);
}
