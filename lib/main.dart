import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_news/screens/loginScreen.dart';
import './staticVariables.dart';
import 'StructPage.dart';
import 'package:provider/provider.dart';
import 'providerReT.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/splashScreen.dart';

// import 'package:intl/intl.dart';  ======> its not allow to use Directionality
// add time of read weather to known user weather is very dakek


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: appColorPrimary, // navigation bar color
      statusBarColor: appColorAccent,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: appColorPrimary,
      statusBarIconBrightness: Brightness.light
  ));
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=>MyProviderReT(),
        ),
      ],

      child: MaterialApp(
          title: 'The News',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: appColorPrimary,
          accentColor: appColorAccent,
          fontFamily: 'Cairo',
          // to selected text
          textSelectionColor: appColorPrimary.withOpacity(0.8),
          cursorColor: appColorPrimary,
          primarySwatch: appColorPrimaryMaterialClr,

          appBarTheme: AppBarTheme(
            color: appColorPrimary,
          ),
          scaffoldBackgroundColor: Colors.white
      ),
          
          home: SplashScreen()
      ),
    );
  }
}