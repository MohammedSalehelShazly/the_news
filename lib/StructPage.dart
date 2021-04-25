import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_news/providerReT.dart';
import 'package:the_news/staticVariables.dart';
import './screens/searchNews.dart';
import './screens/weather_input_cntry.dart';
import './widgets/newDrawer.dart';
import './languages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/allNews.dart';
import 'package:provider/provider.dart';

class StructPage extends StatefulWidget {

  @override
  _StructPageState createState() => _StructPageState();
}

class _StructPageState extends State<StructPage> {

  SharedPreferences prefs ;
  bool isEnglish = true;

  language_get() async{
    prefs = await SharedPreferences.getInstance();
    print( 'issss ${prefs.getBool("isEnglish")}' );
      if(prefs.getBool('isEnglish')==null){
        isEnglish = true  ;
      }else isEnglish = prefs.getBool('isEnglish') ;
  }
  Language lang = Language();

  @override
  void initState(){
    language_get();
    super.initState();
  }
  bool appOpenedNow = true;

  List pages = [ AllNews('all')  ,AllNews('Health'), AllNews('Technology') ,AllNews('Business') ,AllNews('Sports') ,AllNews('Art') ,AllNews('Scince & space') ,AllNews('Saved') ,Weather_input_cntry() ];

  int currentPageIndex = 0;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context){
    final provListen = Provider.of<MyProviderReT>(context);
    if(appOpenedNow==true){
      language_get().then((vv)=>  Provider.of<MyProviderReT>(context ,listen: false).setIsEnglish(isEnglish)   );
      appOpenedNow = false ;
    }

    return SafeArea(
      child: Directionality(
        textDirection: provListen.isEnglish ? TextDirection.ltr : TextDirection.rtl,
        child: DefaultTabController(
          length: pages.length,
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(lang.newsTit(provListen.isEnglish, currentPageIndex) ,style: myTextStyle(context ,clr: Colors.black ,ratioSize: 20),),
              centerTitle: true,
              backgroundColor: Colors.white70,

              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search ,color: Colors.black,),
                  onPressed: (){
                    Navigator.of(context).push(CupertinoPageRoute(builder: (context)=> SearchNews()));
                  },
                )
              ],
              leading: ChangeLanguage(),

              bottom: TabBar(
                isScrollable: true,
                onTap: (index){
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                unselectedLabelColor: Colors.black54,
                labelColor: Colors.black,
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
        ),
      ),
    );
  }


}

