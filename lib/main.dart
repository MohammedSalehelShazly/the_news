import 'package:flutter/material.dart';
import './screens/searchNews.dart';
import './staticVariables.dart';
import 'StructPage.dart';
import 'package:provider/provider.dart';
import 'providerReT.dart';

// import 'package:intl/intl.dart';  ======> its not allow to use Directionality
// add time of read weather to known user weather is very dakek


void main() => runApp(MyApp());

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
            primaryColor: appColorPrimary ,
          ),
          home: StructPage()
      ),
    );
  }
}