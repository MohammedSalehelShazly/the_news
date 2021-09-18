import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'global/responsive.dart';
import 'services/providers/settingsProv.dart';
import 'localization/language_constants.dart';
import 'screens/searchNewsScreen.dart';
import 'widgets/appDrawer.dart';
import 'global/enums.dart';
import 'services/providers/mainProvider.dart';
import './screens/weather_input_cntry.dart';
import 'global/staticVariables.dart';
import 'screens/allNews.dart';
import 'widgets/dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class StructPage extends StatelessWidget {
  SharedPreferences prefs ;
  bool isEnglish = true;

  List<Widget> pages = [ AllNews(newsCat.all)  ,AllNews(newsCat.Health), AllNews(newsCat.Technology) ,AllNews(newsCat.Business) ,AllNews(newsCat.Sports) ,AllNews(newsCat.Art) ,AllNews(newsCat.Science_space) ,Weather_input_cntry() ];

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: DefaultTabController(
        length: pages.length,
        initialIndex: 0,
        child: WillPopScope(
          onWillPop: ()async{
              return showDialog(
                  context: context,
                  builder: (context)=> AppDialog(
                    ctx: context,
                    contentTxt: getTranslated(context, 'Are you sure to exit application'),
                    secondActTxt: getTranslated(context, 'Exit'),
                    func: (){
                      SystemNavigator.pop();
                    },
                  )
              );

          },
          child: Scaffold(
          key: scaffoldKey,
          drawer: Selector<SettingsProv ,String>(
            selector: (_,prov)=> prov.appLang,
            builder: (_,appLang, __)=> AppDrawer(endDrawer: appLang == 'ar',),
          ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(responsive.responsiveHigh(context, .17)),
            child: Selector<MainProvider ,int>(
              selector: (_,prov)=> prov.currentPageIndex,
              builder: (_,appLang, __)=> AppBar(
                title: Text( getTranslated(context,
                    appLang == 7 ? 'Weather'
                        : newsCatToString(
                        newsCat.values.elementAt(appLang) ,true)),),
                centerTitle: true,

                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search ,color: Colors.white.withOpacity(0.95),),
                    onPressed: (){
                      Navigator.of(context).push(CupertinoPageRoute(builder: (context)=> SearchNewsScreen()));
                    },
                  )
                ],

                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(responsive.responsiveHigh(context, .65)),
                  child: Consumer<MainProvider>(
                    builder:(_,prov,__)=> TabBar(
                        isScrollable: true,
                        onTap: (index){
                          prov.changeCurrentPage(index);
                        },
                        indicator: BoxDecoration(),
                        tabs: [
                          ...newsCat.values.map(
                                  (e)=> Tab(text: getTranslated(context, newsCatToString(e ,true)) )),
                          Tab(text: getTranslated(context, 'Weather'))
                        ]
                    ),
                  ),
                ),
              ),
            ),
          ),


          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: pages.map((e) => e).toList(),
          ),
        ),
        )
      ),
    );
  }


}

