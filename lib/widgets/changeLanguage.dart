import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../localization/languageClass.dart';
import '../localization/language_constants.dart';
import '../services/providers/settingsProv.dart';

import '../services/providers/mainProvider.dart';
import '../screens/splashScreen.dart';
import '../widgets/dialog.dart';

class ChangeLanguage extends StatelessWidget {

  Widget body;
  ChangeLanguage(this.body);

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
  
  SettingsProv settingsProvWrite;
  bool first = true;


  @override
  Widget build(BuildContext context) {
    if(first){
      settingsProvWrite = Provider.of<SettingsProv>(context ,listen: false);
    }
    return PopupMenuButton(
        offset: Offset(0, settingsProvWrite.appLang=='en'?0 :100),
        itemBuilder: (context)=> Language.languageList().map((e)=>
            PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(e.name),
                    Text(e.flag),
                  ],
                ),
                value:  e.languageCode //settingsProv.getLang(),
            )).toList(),

        initialValue: settingsProvWrite.appLang,
        onSelected: (value) async{
          print(value);
          await settingsProvWrite.setLang(context, value);
          Phoenix.rebirth(context);
        },
        icon: body,
        tooltip: getTranslated(context, 'Language'),
        
      );
  }
}