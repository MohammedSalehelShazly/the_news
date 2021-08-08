import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:the_news/global/appClrs.dart';
import 'package:the_news/localization/demo_localization.dart';
import 'package:the_news/localization/language_constants.dart';
import 'package:the_news/screens/loginScreen.dart';
import 'package:the_news/services/newsServices.dart';
import 'package:the_news/services/providers/settingsProv.dart';
import 'package:the_news/services/providers/themeProv.dart';
import 'package:the_news/services/weatherServices.dart';
import 'global/staticVariables.dart';
import 'StructPage.dart';
import 'package:provider/provider.dart';
import 'services/providers/mainProvider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/splashScreen.dart';

// import 'package:intl/intl.dart';  ======> its not allow to use Directionality
// add time of read weather to known user weather is very dakek


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: appClrs.mainColor, // navigation bar color
      statusBarColor: appClrs.mainAlphaColor100,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: appClrs.mainColor,
      statusBarIconBrightness: Brightness.light
  ));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>MainProvider()),
      ChangeNotifierProvider(create: (_)=>NewsApi()),
      ChangeNotifierProvider(create: (_)=>ThemeProv()),
      ChangeNotifierProvider(create: (_)=>SettingsProv()),
      ChangeNotifierProvider(create: (_)=>WeatherService()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ThemeProv themeProv;

  Locale _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    themeProv = Provider.of<ThemeProv>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'The News',
        debugShowCheckedModeBanner: false,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
        theme: appClrs.appThem(false),
        darkTheme: appClrs.appThem(true),
        themeMode: themeProv.isDark
            ? ThemeMode.dark :ThemeMode.light,

        // localization =>
        locale: _locale,
        supportedLocales: [
          Locale("ar", ""),
          Locale("en", ""),
        ],
        localizationsDelegates: [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },




        home: SplashScreen()
    );
  }
}