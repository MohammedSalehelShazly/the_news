import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/providers/settingsProv.dart';
import '../services/providers/themeProv.dart';

import '../StructPage.dart';
import '../screens/loginScreen.dart';
import '../widgets/theNewsLogo.dart';
import '../services/providers/mainProvider.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  
   SharedPreferences prefs ;

  String user ='No';
  user_get() async{
    prefs = await SharedPreferences.getInstance();
    user = prefs.getString('user') ?? 'No' ;
  }

  @override
  void initState() {
    user_get();

    Future.delayed(Duration(seconds: 2),(){
      if(user=='No'){
        Navigator.pushReplacement(context, CupertinoPageRoute(
            builder: (context)=>LoginScreen(),
          ));
      }else{
        Navigator.pushReplacement(context, CupertinoPageRoute(
            builder: (context)=>StructPage(),
          ));
      }
    });


    super.initState();
  }


  ThemeProv themeProv;

  bool appOpenedNow = true;
  bool first = true;
  
  @override
  Widget build(BuildContext context) {
    if(appOpenedNow==true){
      user_get().then((_)=>  Provider.of<MainProvider>(context ,listen: false).setUser(user)  );
      appOpenedNow = false ;
    }
    if(first){
      themeProv = Provider.of<ThemeProv>(context);
      Provider.of<ThemeProv>(context ,listen: false).getThemeMode();
      Provider.of<SettingsProv>(context ,listen: false).getLang();
      first = false;
    }

    return Scaffold(
      backgroundColor: themeProv.mainClr100(),
      body: Center(
        child: TheNewsLogo(ctx: context ,keyVal: ValueKey(1) ,heroTag: 'logo',)
      ),
    );
  }
}
