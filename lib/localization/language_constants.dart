import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'demo_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ARABIC = 'ar';
const String ENGLISH = 'en';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "ar";
  return _locale(languageCode);
}


Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH: // 'en'
      return Locale(ENGLISH, 'US');
    case ARABIC:
      return Locale(ARABIC, "SA");
    default:
      return Locale(ENGLISH, 'US');
  }
}

String getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context).translate(key);
}
