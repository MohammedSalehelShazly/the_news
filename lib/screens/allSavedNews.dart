import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../global/responsive.dart';
import '../localization/language_constants.dart';
import '../services/providers/themeProv.dart';
import '../services/providers/mainProvider.dart';
import '../services/savedServices.dart';
import '../global/staticVariables.dart';
import '../widgets/container_oneNews.dart';
import '../widgets/likeSnackBar.dart';
import '../widgets/noItemSaved.dart';
import 'package:toast/toast.dart';

class AllSavedNews extends StatefulWidget {
  @override
  _AllSavedNewsState createState() => _AllSavedNewsState();
}

class _AllSavedNewsState extends State<AllSavedNews> {

  static var savedDataSQlite;
  static var savedDataFB;
  
  ThemeProv themeProv;
  MainProvider mainProvider;

  bool first = true;
  bool firstTime = true;

  @override
  Widget build(BuildContext context) {
    if(first){
      themeProv = Provider.of<ThemeProv>(context);
      mainProvider = Provider.of<MainProvider>(context);
      first = false;
    }

    return Scaffold(
        //key: widget.scaffoldKey,
        backgroundColor: Colors.white,
        body: AppToast(
          context ,
          Provider.of<MainProvider>(context).alreadySavedAppear,
          sContent: Text(
            getTranslated(context, 'already saved'),),

          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FutureBuilder(
                future: SavedServices(mainProvider.user+'.json').getFromFB(),
                builder: (context ,snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data.length==0) return NoItemSaved(ctx:context ,isEng: mainProvider.isEnglish,sWidth: responsive.sWidth(context));

                    else return RefreshIndicator(
                        onRefresh:() async{
                          setState(()=> null );
                        },

                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemExtent: responsive.sWidth(context)*0.55,
                          itemBuilder: (context ,index){
                            if(firstTime==true){
                              SavedServices(mainProvider.user+'.json').getFromFB().then((value) => setState(()=> savedDataFB = value) );
                              print('savedDataFB $savedDataFB');
                              firstTime=false;
                            }


                              print('id =${snapshot.data[index].id}');

                              if(snapshot.data.length-1 >= index){
                                return ContainerOneNews(
                                  themeProv.mainClr(),
                                  all: savedDataFB,
                                  id: snapshot.data[index].id ,
                                  sWidth: responsive.sWidth(context),
                                  sHeight: responsive.sWidth(context)*0.55,
                                  title: snapshot.data[index].title,
                                  url: snapshot.data[index].url,
                                  author:snapshot.data[index].author==null ?'No':snapshot.data[index].author,
                                  publishedAt: snapshot.data[index].publishedAt,
                                  urlToImage: snapshot.data[index].urlToImage,
                                  isSaved: true,
                                );
                              }
                              else return SizedBox();
                          },
                        )
                    );
                  }
                  else{
                    internetConnected().then((_internetConnected){
                      if(!_internetConnected){
                        Toast.show(getTranslated(context, 'Check the internet connection'),
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM ,);
                      }
                    });

                    return Center(child: CupertinoActivityIndicator());
                    //return Center(child: RaisedButton(onPressed: ()=>NewsApi().launchURL('http://newsapi.org/v2/top-headlines?country=us&apiKey=48b4cf61823345fbac6bf3d92fd5989d'),),);


                  }
                },
              )
          ),
        )
    );
  }
}
