import 'dart:convert';

import 'package:alkhudhrah_app/constants/pref_cont.dart';
import 'package:alkhudhrah_app/helper/pref_manager.dart';
import 'package:alkhudhrah_app/network/models/user_model.dart';

class PreferencesHelper {
  static Future<String> get getUserID => SharedPrefsManager.getString(userID);

  static Future setUserID(String value) =>
      SharedPrefsManager.setString(userID, value);

  static Future<String> get getSelectedLanguage =>
      SharedPrefsManager.getString(currentLanguage);

  static Future setSelectedLanguage(String value) =>
      SharedPrefsManager.setString(currentLanguage, value);

  static Future<String> get getUserToken => SharedPrefsManager.getString(token);

  static Future setUserToken(String value) =>
      SharedPrefsManager.setString(token, value);

  static Future<User> get getUser async => User.fromJson(SharedPrefsManager.getFromJson(currentUser));

  static Future setUser(User user) => SharedPrefsManager.setToJson(currentUser, user);


/*  Future<void> clear() async {
    await Future.wait(<Future>[
      setAuthenticated(false),
      setTutorialString(''),
      setPasscode(''),
    ]);
  }*/
}