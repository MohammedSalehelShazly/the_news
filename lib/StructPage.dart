import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';

import './providerReT.dart';
import './screens/searchNews.dart';
import './screens/weather_input_cntry.dart';
import './staticVariables.dart';
import './widgets/changeLanguage.dart';
import './languages.dart';
import 'screens/allNews.dart';
import 'widgets/dialog.dart';

class StructPage extends StatefulWidget {

  @override
  _StructPageState createState() => _StructPageState();
}

class _StructPageState extends State<StructPage> {

  SharedPreferences prefs ;
  bool isEnglish = true;

  Language lang = Language();

  List pages = [ AllNews('all')  ,AllNews('Health'), AllNews('Technology') ,AllNews('Business') ,AllNews('Sports') ,AllNews('Art') ,AllNews('Scince & space') ,AllNews('Saved') ,Weather_input_cntry() ];

  int currentPageIndex = 0;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  

  @override
  Widget build(BuildContext context){
    final provListen = Provider.of<MyProviderReT>(context);

    return SafeArea(
      child: Directionality(
        textDirection: provListen.isEnglish ? TextDirection.ltr : TextDirection.rtl,
        child: DefaultTabController(
          length: pages.length,
          initialIndex: 0,
          child: WillPopScope(
            onWillPop: ()async{
              return showDialog(
              context: context,
              builder: (context)=> AppDialog(
              ctx: context,
              contentTxt: Language().dialogTit(provListen.isEnglish, 3),
              isEnglish: provListen.isEnglish,
              secondActTxt: Language().dialogTit(provListen.isEnglish, 4),
              func: (){
                SystemNavigator.pop();
              },
            )
           );
            },
            child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(lang.newsTit(provListen.isEnglish, currentPageIndex) ,style: myTextStyle(context ,clr: Colors.white ,ratioSize: 20),),
              centerTitle: true,
              backgroundColor: appColorPrimary,

              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search ,color: Colors.white.withOpacity(0.95),),
                  onPressed: (){
                    Navigator.of(context).push(CupertinoPageRoute(builder: (context)=> SearchNews()));
                  },
                )
              ],
              leading: ChangeLanguage(false ,context),

              bottom: TabBar(
                isScrollable: true,
                onTap: (index){
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                unselectedLabelColor: Colors.white54,
                labelColor: Colors.white,
                indicator: BoxDecoration(),
                labelStyle: myTextStyle(context ,clr: Colors.black),
                tabs: List.generate(pages.length, (index) =>
                    Tab( text: lang.newsTit(provListen.isEnglish, index),),
                ),
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(pages.length, (index) => pages[index]),
            ),
          ),
          )
        ),
      ),
    );
  }


}

