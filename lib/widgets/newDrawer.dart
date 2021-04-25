import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_news/providerReT.dart';

class ChangeLanguage extends StatelessWidget {
  @override
  //sWidth([ratio=1])=>MediaQuery.of(context).size.width*ratio;
  //sHeight([ratio=1])=>MediaQuery.of(context).size.height*ratio;

  SharedPreferences prefs;

  language_set(isEng) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool('isEnglish', isEng);
  }

  static Map <String, String> countryLangFlagTitle = {
    'English': '🇺🇸',
    'عربي': '🇪🇬'
  };
  List countryLangFlag = countryLangFlagTitle.values.toList();
  static List countryLangTitle = countryLangFlagTitle.keys.toList();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) =>
          List.generate(2, (index) =>
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(countryLangFlag[index]),
                    Text(countryLangTitle[index]),
                  ],
                ),
                value: countryLangTitle[index],
              ),
          ),
      initialValue: Provider
          .of<MyProviderReT>(context)
          .isEnglish ? countryLangTitle[0] : countryLangTitle[1],
      onSelected: (value) {
        if (value == countryLangTitle[0]) {
          Provider.of<MyProviderReT>(context, listen: false).setIsEnglish(true);
          language_set(true);
        }
        else {
          Provider.of<MyProviderReT>(context, listen: false).setIsEnglish(
              false);
          language_set(false);
        }
      },
      icon: Icon(Icons.language ,color: Colors.black87,),
    );
  }
}