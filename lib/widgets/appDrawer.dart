import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/awesomeDrawer.dart';
import '../localization/language_constants.dart';
import '../services/providers/settingsProv.dart';
import '../services/providers/themeProv.dart';
import 'changeLanguage.dart';
import 'settingItem.dart';

import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {

  bool endDrawer; /// its mean drawer is from right
  AppDrawer({@required this.endDrawer});

  // SharedPreferences prefs;
  // user_remove() async {
  //   prefs = await SharedPreferences.getInstance();
  //   prefs.setString('user', 'No');
  // }

  @override
  Widget build(BuildContext context) {
    return AwesomeDrawer(
      endDrawer: endDrawer,
      child: Column(
        children: [

          Center(child: Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: Text(getTranslated(context, 'Settings')),
          ),),

          Selector<SettingsProv, String>(
            selector: (_, prov) => prov.appLang,
            builder: (_, appLang, __) => SettingItem(
                txtKey: 'App Language',
                trailing:
                ChangeLanguage(Text(appLang == 'en' ? "🇬🇧" : "🇪🇬")),
                onTap: null),
          ),

          Consumer<ThemeProv>(
            builder:(_,prov,__)=> SettingItem(
              trailing: Switch(
                value: prov.isDark,
                onChanged: (val){
                  prov.reverseIsDark();
                },
              ),
              txtKey: 'Dark mode',
              onTap: (){
                prov.reverseIsDark();
              },
            ),
          ),

          /*SettingItem(
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
              },),*/

        ],
      ),
    );
  }
}


// url && urlLancher