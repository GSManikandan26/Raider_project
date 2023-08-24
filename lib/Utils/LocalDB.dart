import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../View/LoginView.dart';
import 'NavigateController.dart';

class LocalDB{

  // set Local Data
  static setLDB(String key,String value) async {
     SharedPreferences pref = await SharedPreferences.getInstance();
     pref.setString(key, value);
  }


  // Clear All Local Data && Logout
  static void clearAllLDB(BuildContext context) async {
    NavigateController.pagePush(context, const LoginView());
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }


  // Retrieve Local Data
  static Future<String> getLDB(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return Future.value(pref.getString(key) ?? '');
  }


}