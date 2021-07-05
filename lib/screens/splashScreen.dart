import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../StructPage.dart';
import '../screens/loginScreen.dart';
import '../staticVariables.dart';
import '../widgets/theNewsLogo.dart';
import '../providerReT.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  
   SharedPreferences prefs ;
  bool isEnglish = true;

  language_get() async{
    prefs = await SharedPreferences.getInstance();
      if(prefs.getBool('isEnglish')==null){
        isEnglish = true  ;
      }else isEnglish = prefs.getBool('isEnglish') ;
  }

  String user ='No';
  user_get() async{
    prefs = await SharedPreferences.getInstance();
    user = prefs.getString('user') ?? 'No' ;
  }

  @override
  void initState() {
    language_get();
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
  
  bool appOpenedNow = true;
  
  @override
  Widget build(BuildContext context) {
    if(appOpenedNow==true){
      language_get().then((_)=>  Provider.of<MyProviderReT>(context ,listen: false).setIsEnglish(isEnglish)   );
      user_get().then((_)=>  Provider.of<MyProviderReT>(context ,listen: false).setUser(user)  );
      appOpenedNow = false ;
    }

    return Scaffold(
      backgroundColor: appColorPrimary.withOpacity(0.7),
      body: Center(
        child: TheNewsLogo(ctx: context ,keyVal: ValueKey(1) ,heroTag: 'logo',)
      ),
    );
  }
}
