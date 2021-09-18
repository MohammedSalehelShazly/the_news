import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/providers/settingsProv.dart';
import '../services/providers/themeProv.dart';
import '../StructPage.dart';
import '../widgets/theNewsLogo.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {


  ThemeProv themeProv;
  bool first = true;

  @override
  void didChangeDependencies() {

    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, CupertinoPageRoute(
        builder: (context)=>StructPage(),
      ));
    });

    if(first){
      themeProv = Provider.of<ThemeProv>(context);
      Provider.of<ThemeProv>(context ,listen: false).getThemeMode();
      Provider.of<SettingsProv>(context ,listen: false).getLang();
      first = false;
    }
    super.didChangeDependencies();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeProv.mainClr100(),
      body: Center(
        child: TheNewsLogo(ctx: context ,keyVal: ValueKey(1) ,heroTag: 'logo',)
      ),
    );
  }
}
