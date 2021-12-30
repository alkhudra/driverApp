import 'package:alkhudhrah_app/helper/pref_manager.dart';
import 'package:alkhudhrah_app/constants/pref_cont.dart';

class PreferencesHelper {

  static Future<String> get getUserID => SharedPrefsManager.getString(userID);

  static Future setUserID(String value) => SharedPrefsManager.setString(userID, value);

/*
  static Future<bool> get authenticated => SharedPrefsManager.getBool(Const.AUTHENTICATED);

  static Future setAuthenticated(bool value) => SharedPrefsManager.setBool(Const.AUTHENTICATED, value);

  static Future<String> get passcode => SharedPrefsManager.getString(Const.PASSCODE);

  static Future setPasscode(String value) => SharedPrefsManager.setString(Const.PASSCODE, value);
*/

/*  Future<void> clear() async {
    await Future.wait(<Future>[
      setAuthenticated(false),
      setTutorialString(''),
      setPasscode(''),
    ]);
  }*/
}