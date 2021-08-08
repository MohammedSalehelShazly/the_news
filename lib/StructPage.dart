import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'localization/language_constants.dart';
import 'screens/searchNewsScreen.dart';
import 'screens/settingsScreen.dart';
import 'services/providers/themeProv.dart';
import 'global/enums.dart';
import 'screens/allSavedNews.dart';
import 'services/newsServices.dart';

import 'services/providers/mainProvider.dart';
import './screens/weather_input_cntry.dart';
import 'global/staticVariables.dart';
import 'screens/allNews.dart';
import 'widgets/dialog.dart';

class StructPage extends StatelessWidget {
  SharedPreferences prefs ;
  bool isEnglish = true;

  /*static */ List<Widget> pages = [ AllNews(newsCat.all)  ,AllNews(newsCat.Health), AllNews(newsCat.Technology) ,AllNews(newsCat.Business) ,AllNews(newsCat.Sports) ,AllNews(newsCat.Art) ,AllNews(newsCat.Science_space) ,AllSavedNews() ,Weather_input_cntry() ];

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  NewsApi newsApiWrite;
  MainProvider mainProvider;
  MainProvider mainProviderWrite;
  ThemeProv themeProv;

  TextEditingController inputController = TextEditingController();

  bool first = true;

  @override
  Widget build(BuildContext context){
    if(first){
      newsApiWrite = Provider.of<NewsApi>(context, listen: false);
      mainProvider = Provider.of<MainProvider>(context);
      mainProviderWrite = Provider.of<MainProvider>(context, listen: false);
      themeProv = Provider.of<ThemeProv>(context);

      first = false;
    }

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
          appBar: AppBar(
            title: Text( getTranslated(context,
                mainProvider.currentPageIndex == 8 ? 'Weather'
                    : newsCatToString(
                    newsCat.values.elementAt(mainProvider.currentPageIndex) ,true)),),
            centerTitle: true,

            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search ,color: Colors.white.withOpacity(0.95),),
                onPressed: (){
                  Navigator.of(context).push(CupertinoPageRoute(builder: (context)=> SearchNewsScreen()));
                },
              )
            ],
            leading:  IconButton(
              icon: Icon(Icons.settings),
              tooltip: getTranslated(context, 'settings'),
              onPressed: (){
                Navigator.push(context, CupertinoPageRoute(
                  builder: (_)=> SettingsScreen()
                ));
              },
            ),

            bottom: TabBar(
              isScrollable: true,
              onTap: (index){
                  mainProviderWrite.changeCurrentPage(index);
              },
              // unselectedLabelColor: Colors.white54,
              // labelColor: Colors.white,
              indicator: BoxDecoration(),
              // tabs: newsCat.values.map((e)
              //     => Tab(text: newsCatToString(e ,true)),
              // ).toList(),
              tabs: [
                ...newsCat.values.map(
                      (e)=> Tab(text: getTranslated(context, newsCatToString(e ,true)) )),
                Tab(text: getTranslated(context, 'Weather'))

              ]


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

