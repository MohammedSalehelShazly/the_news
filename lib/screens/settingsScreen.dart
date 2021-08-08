import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../localization/languageClass.dart';
import '../localization/language_constants.dart';
import '../screens/splashScreen.dart';
import '../services/providers/mainProvider.dart';
import '../services/providers/settingsProv.dart';
import '../services/providers/themeProv.dart';
import '../widgets/changeLanguage.dart';
import '../widgets/dialog.dart';
import '../widgets/settingItem.dart';

class SettingsScreen extends StatelessWidget {

  SharedPreferences prefs;
  language_set(isEng) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('isEnglish', isEng);
  }
  user_remove() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('user', 'No');
  }

  MainProvider mainProvider;
  MainProvider mainProviderWrite;
  SettingsProv settingsProv;
  SettingsProv settingsProvWrite;
  ThemeProv themeProvWrite;
  ThemeProv themeProv;

  bool first = true;


  @override
  Widget build(BuildContext context) {
    if(first){
      mainProvider = Provider.of<MainProvider>(context);
      mainProviderWrite = Provider.of<MainProvider>(context, listen: false);
      settingsProv = Provider.of<SettingsProv>(context);
      settingsProvWrite = Provider.of<SettingsProv>(context, listen: false);
      themeProvWrite = Provider.of<ThemeProv>(context, listen: false);
      themeProv = Provider.of<ThemeProv>(context);


      first = false;
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context ,'Settings')),
        ),
        body: ListView(
          children: [

               SettingItem(txtKey: 'App Language',
                  trailing: ChangeLanguage( Text(settingsProv.appLang=='en' ? "🇬🇧" :"🇪🇬")),
                  onTap:null),

            SettingItem(
              trailing: Switch(
                value: themeProv.isDark,
                onChanged: (val){
                  themeProvWrite.reverseIsDark();
                },
              ),
              txtKey: 'Dark mode',
              onTap: (){
                themeProvWrite.reverseIsDark();
              },
            ),


            SettingItem(
              txtKey: 'logout',
              trailing: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(Icons.logout ,color: Colors.red,),
              ),
              onTap:(){
                showDialog(
                    context: context ,
                    builder: (context)=> AppDialog(
                      ctx: context,
                      contentTxt: getTranslated(context, 'logout hint_1') +'\n' +getTranslated(context, 'logout hint_2') ,
                      secondActTxt: getTranslated(context, 'logout'),
                      func: () {
                        mainProviderWrite.setUser('No');
                        settingsProvWrite.reverseIsLogin();
                        user_remove().then((_){
                          Navigator.pushReplacement(context, CupertinoPageRoute(
                            builder: (mainCtx)=>SplashScreen(),
                          ));
                        });
                      },
                    )
                );
              },),

          ],
        )
      ),
    );
  }
}
