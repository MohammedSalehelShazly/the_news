
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {

  setThemeMode(bool _isDark) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', _isDark);
  }
  Future<bool> getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDark');
  }


  setIsLogin(bool _isLogin) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', _isLogin);
  }
  Future<bool> getIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLogin');
  }



}