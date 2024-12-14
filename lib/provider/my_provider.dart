/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  String local = "en";
  ThemeMode theme = ThemeMode.light;

  changeLanguage(String langCode) {
    local = langCode;
    notifyListeners();
  }

  changeTheme(ThemeMode mode) {
    theme = mode;
    notifyListeners();
  }
}
*/
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProvider extends ChangeNotifier {
  SharedPreferences? sharedPref;

  String currentLocal = 'en';

  String get locale => currentLocal;

  ThemeMode theme = ThemeMode.light;

  ThemeMode get themeMode => theme;

  void changeLanguage(String newLocale) {
    currentLocal = newLocale;
    notifyListeners();
    saveLanguage();
  }

  void changeTheme(ThemeMode mode) {
    theme = mode;
    notifyListeners();
    saveTheme(themeMode);
  }

  bool get isDarkMode => theme == ThemeMode.dark;

  //1. Function to save the data
  Future<void> saveTheme(ThemeMode themeMode) async {
    /*shared preference only stores string or int, double
    can not stores special data like themeData*/
    String newTheme = themeMode == ThemeMode.dark ? 'dark' : 'light';
    await sharedPref!.setString('theme', newTheme);
  }

  //2. Function to retrieve the data
  String? getTheme() {
    return sharedPref!.getString('theme');
  }

  //3. Initialize shared preference
  Future<void> loadThemeData() async {
    sharedPref = await SharedPreferences.getInstance();
    //Check if there is a data or not
    String? oldTheme = getTheme();
    if (oldTheme != null) {
      theme = oldTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
  }

  Future<void> saveLanguage() async {
    if (sharedPref != null) {
      await sharedPref?.setString('language', currentLocal);
    }
  }

  String? getLangyage() {
    return sharedPref!.getString('language');
  }

  Future<void> loadLanguageData() async {
    sharedPref = await SharedPreferences.getInstance();
    String? oldLanguage = getLangyage();
    if (oldLanguage != null) {
      currentLocal = oldLanguage;
    }
  }
}
