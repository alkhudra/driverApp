import 'dart:convert';

import 'package:alkhudhrah_app/network/models/driver_user.dart';
import 'package:flutter/widgets.dart';
import 'package:alkhudhrah_app/constants/pref_cont.dart';
import 'package:alkhudhrah_app/helper/pref_manager.dart';

class PreferencesHelper {
  static Future<bool> get getIsUserFirstLogIn =>
      SharedPrefsManager.getBool(firstLogin);
  static Future setUserFirstLogIn(bool value) =>
      SharedPrefsManager.setBool(firstLogin, value);

  //----------------
  static Future<bool> get getIsUserLoggedIn =>
      SharedPrefsManager.getBool(isLoggedIn);
  static Future setUserLoggedIn(bool value) =>
      SharedPrefsManager.setBool(isLoggedIn, value);

  //------------------

  static Future<bool> get getIsUserLoggedOut =>
      SharedPrefsManager.getBool(isLoggedOut);
  static Future setUserLoggedOut(bool value) =>
      SharedPrefsManager.setBool(isLoggedOut, value);

  //------------------

  static Future<String> get getUserID => SharedPrefsManager.getString(userID);
  static Future setUserID(String value) =>
      SharedPrefsManager.setString(userID, value);

  //--------------------
  static Future<String> get getSelectedLanguage =>
      SharedPrefsManager.getString(currentLanguage);

  static Future setSelectedLanguage(String value) =>
      SharedPrefsManager.setString(currentLanguage, value);
  //--------------------

  static Future<String> get getUserToken => SharedPrefsManager.getString(token);

  static Future setUserToken(String value) =>
      SharedPrefsManager.setString(token, value);
  //--------------------
/*
  static Future<List<Cities>> get getCities async {
    List<Cities> citiesList =[];
  */ /*  Map<String, dynamic> userMap =
    await SharedPrefsManager.getFromJson(cities);*/ /*
   List< Cities> o = SharedPrefsManager.getFromJson(cities);
    o.forEach((v) {
      citiesList.add(Cities.fromJson(v));
    });
    return citiesList;//Cities.fromJson(userMap);
  }

  static Future setCities(List<Cities>? citiesValue) {
    //  user = User.fromJson(user);
    if (citiesValue != null)
      return SharedPrefsManager.setToJson(cities, citiesValue);
    else
      return SharedPrefsManager.setToJson(cities, '');
  }*/
  //--------------------

  static Future<DriverUser> get getUser async {
    Map<String, dynamic> userMap =
        await SharedPrefsManager.getFromJson(currentUser);
    return DriverUser.fromJson(userMap);
  }

  static Future setUser(DriverUser? driverUser) {
    //  user = User.fromJson(user);
    if (driverUser != null)
      return SharedPrefsManager.setToJson(currentUser, driverUser);
    else
      return SharedPrefsManager.setToJson(currentUser, '');
  }

//--------------------

  // static Future removeFromUserList(BranchModel model) async {
  //   Map<String, dynamic> userMap =
  //       await SharedPrefsManager.getFromJson(currentUser);
  //   User user = User.fromJson(userMap);
  //   List<BranchModel>? list = user.branches;

  //   list?.remove(model);
  // }

  static void clearPrefs() {
    SharedPrefsManager.clear();
  }
/*  Future<void> clear() async {
    await Future.wait(<Future>[
      setAuthenticated(false),
      setTutorialString(''),
      setPasscode(''),
    ]);
  }*/
}
