import 'package:flutter/cupertino.dart';
import '../../global/appClrs.dart';
import '../../helper/sharedPrefsHelper.dart';

class ThemeProv with ChangeNotifier{

  SharedPrefsHelper sharedPrefsHelper = SharedPrefsHelper();

  bool isDark = true;
  getThemeMode(){
    sharedPrefsHelper.getThemeMode().then((_isDark){
      isDark = _isDark ?? true;
      notifyListeners();
    });
  }
  reverseIsDark(){
    isDark = !isDark;
    sharedPrefsHelper.setThemeMode(isDark);
    notifyListeners();
  }



  
  Color bkgroundClr() =>
      isDark ? appClrs.scaffoldBackgroundColorDark :appClrs.scaffoldBackgroundColor;

  Color reverseBkgroundClr() =>
      isDark ? appClrs.scaffoldBackgroundColor :appClrs.scaffoldBackgroundColorDark;

  Color mainClr() =>
      isDark ? appClrs.mainColorDark : appClrs.mainColor;

  Color reversSecondClr() =>
      isDark ? appClrs.secondColor : appClrs.secondColorDark;


  Color reverseMainClr() =>
      isDark ? appClrs.mainColor : appClrs.mainColorDark;


  Color mainClr100() =>
      isDark ? appClrs.mainAlphaColor100Dark : appClrs.mainAlphaColor100;

  Color reverseMainClr100() =>
      isDark ? appClrs.mainAlphaColor100 : appClrs.mainAlphaColor100Dark;


}