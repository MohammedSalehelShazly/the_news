import 'package:flutter/material.dart';


AppClrs appClrs = AppClrs();

class AppClrs{

  Color mainColor = Color(0xff295980);
  Color mainAlphaColor300 = Color(0xFF407BB8);
  Color mainAlphaColor100 = Color(0xff609ee0);
  Color scaffoldBackgroundColor = Color(0xffFAFAFA);
  Color secondColor = Colors.yellow[700];

  MaterialColor colorPrimarySwatch = const MaterialColor(
    0xff295980,
    const <int, Color>{
      50:Color.fromRGBO(41,89,128, 1),
      100:Color.fromRGBO(41,89,128, 1),
      200:Color.fromRGBO(41,89,128, 1),
      300:Color.fromRGBO(41,89,128, 1),
      400:Color.fromRGBO(41,89,128, 1),
      500:Color.fromRGBO(41,89,128, 1),
      600:Color.fromRGBO(41,89,128, 1),
      700:Color.fromRGBO(41,89,128, 1),
      800:Color.fromRGBO(41,89,128, 1),
      900:Color.fromRGBO(41,89,128, 1),
    },
  );

  Color mainColorDark = Color(0xff234d6c);
  Color mainAlphaColor300Dark = Color(0xFF376CA0);
  Color mainAlphaColor100Dark = Color(0xff4372a3);
  Color scaffoldBackgroundColorDark = Color(0xff2E2E2E);
  Color secondColorDark = Colors.yellow[700];

  MaterialColor colorPrimarySwatchDark = const MaterialColor(
    0xff234d6c,
    const <int, Color>{
      50:Color.fromRGBO(35,77,108, 1),
      100:Color.fromRGBO(35,77,108, 1),
      200:Color.fromRGBO(35,77,108, 1),
      300:Color.fromRGBO(35,77,108, 1),
      400:Color.fromRGBO(35,77,108, 1),
      500:Color.fromRGBO(35,77,108, 1),
      600:Color.fromRGBO(35,77,108, 1),
      700:Color.fromRGBO(35,77,108, 1),
      800:Color.fromRGBO(35,77,108, 1),
      900:Color.fromRGBO(35,77,108, 1),
    },
  );

  List<Color> gradintClrs()=> [
    mainColor,
    mainAlphaColor300,
    mainAlphaColor100
  ];

  String mainFontFamily = 'Cairo';
  //String secondFontFamily = 'Amiri';

  ThemeData appThem(bool isDark)=> ThemeData(
    brightness: isDark ?Brightness.dark :Brightness.light,
    fontFamily: mainFontFamily,
    primaryColor: isDark ? mainAlphaColor300Dark :mainAlphaColor300,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold ,fontFamily: mainFontFamily)
      ),
    ),
    dialogTheme: DialogTheme(
      titleTextStyle: TextStyle(color: mainColor ),
    ),
  );


}