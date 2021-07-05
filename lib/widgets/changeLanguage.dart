import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providerReT.dart';
import '../screens/splashScreen.dart';
import '../widgets/dialog.dart';

import '../languages.dart';

class ChangeLanguage extends StatelessWidget {
  bool atLoginScreen;
  BuildContext mainCtx;
  ChangeLanguage(this.atLoginScreen ,[this.mainCtx]);

  SharedPreferences prefs;

  language_set(isEng) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('isEnglish', isEng);
  }

  user_remove() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('user', 'No');
  }

  static Map <String, dynamic> countryLangFlagTitle = {
    'English': '🇺🇸',
    'عربي': '🇪🇬',
  };
  List countryLangFlag = countryLangFlagTitle.values.toList();
  static List countryLangTitle = countryLangFlagTitle.keys.toList();


  @override
  Widget build(BuildContext context) {
    final provListen = Provider.of<MyProviderReT>(context);

    return PopupMenuButton(
        offset: Offset(0, provListen.isEnglish?0 :100),
        itemBuilder: (context)=>[
          
                PopupMenuItem(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(countryLangFlag[0]),
                      Text(countryLangTitle[0]),
                    ],
                  ),
                  value: countryLangTitle[0],
                ),
                PopupMenuItem(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(countryLangFlag[1]),
                      Text(countryLangTitle[1]),
                    ],
                  ),
                  value: countryLangTitle[1],
                ),
                
                if(!atLoginScreen) PopupMenuItem(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(Icons.logout ,color: Colors.red,),
                      Text(  Language().widgetsTit(provListen.isEnglish ,3)  ),
                    ],
                  ),
                  value: 'logout',
                ),

        ],


        initialValue: Provider
            .of<MyProviderReT>(context)
            .isEnglish ? countryLangTitle[0] : countryLangTitle[1],
        onSelected: (value) {
          if (value == countryLangTitle[0]) {
            Provider.of<MyProviderReT>(context, listen: false).setIsEnglish(true);
            language_set(true);
          }
          else if(value == countryLangTitle[1]){
            Provider.of<MyProviderReT>(context, listen: false).setIsEnglish(
                false);
            language_set(false);
          }
          else{ // 'logout'
            
            showDialog(
              context: context ,
              builder: (context)=> AppDialog(
                ctx: context,
                contentTxt: Language().loginFomrs(provListen.isEnglish ,7),
                isEnglish: provListen.isEnglish,
                secondActTxt: Language().loginFomrs(provListen.isEnglish ,8),
                func: () {
                  Provider.of<MyProviderReT>(context, listen: false).setUser('No');
                  user_remove().then((_){
                    Navigator.pushReplacement(this.mainCtx, CupertinoPageRoute(
                      builder: (mainCtx)=>SplashScreen(),
                    ));
                  });
                },
              )
            );
          }
        },
        icon: Icon(Icons.language ,color: Colors.white.withOpacity(0.95) ,),
        tooltip: Language().widgetsTit(Provider.of<MyProviderReT>(context,).isEnglish ,2),
        
      );
  }
}