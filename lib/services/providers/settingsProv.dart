
import 'package:flutter/cupertino.dart';
import '../../helper/sharedPrefsHelper.dart';
import '../../localization/languageClass.dart';
import '../../localization/language_constants.dart';
import '../../main.dart';

class SettingsProv with ChangeNotifier{

  Future<void> setLang(BuildContext context ,String languageCode) async {
    Locale _locale = await setLocale(languageCode);
    MyApp.setLocale(context, _locale);
    getLang();
  }

  String appLang = 'ar';
  Future<void> getLang() async{
    await getLocale().then((value) {
      appLang = value.languageCode;
      notifyListeners();
    });
  }

  SharedPrefsHelper sharedPrefsHelper = SharedPrefsHelper();

  bool isLogin = false;
  getIsLogin(){
    sharedPrefsHelper.getThemeMode().then((_isLogin){
      isLogin = _isLogin ?? false;
      notifyListeners();
    });
  }
  reverseIsLogin(){
    isLogin = !isLogin;
    sharedPrefsHelper.setThemeMode(isLogin);
    notifyListeners();
  }


}