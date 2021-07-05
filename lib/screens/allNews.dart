import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:the_news/staticVariables.dart';
import 'package:toast/toast.dart';

import '../services/savedServices.dart';
import '../languages.dart';
import '../widgets/likeSnackBar.dart';
import '../widgets/container_oneNews.dart';
import '../providerReT.dart';
import '../services/newsServices.dart';
import '../widgets/noItemSaved.dart';




class AllNews extends StatefulWidget {
  String categories ;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  AllNews([this.categories]);

  @override
  _AllNewsState createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> with AutomaticKeepAliveClientMixin{
  sWidth([ratio=1])=>MediaQuery.of(context).size.width*ratio;
  sHeight([ratio=1])=>MediaQuery.of(context).size.height*ratio;

  static var savedDataSQlite;
  static var savedDataFB;
  bool firstTime = true;

  @override
  Widget build(BuildContext context) {
    final provListen = Provider.of<MyProviderReT>(context);

    return Directionality(
      textDirection: provListen.isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
          key: widget.scaffoldKey,
          backgroundColor: Colors.white,
          body: LikeSnackBar(
            context ,
            Provider.of<MyProviderReT>(context).alreadySavedAppear,
            sContent: Text(
              Language().widgetsTit(provListen.isEnglish ,0),
              style: TextStyle(color: Colors.white),),
            sColor: Colors.blueGrey[600],

            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FutureBuilder(
                future: widget.categories=='Saved' ?SavedServices(provListen.user+'.json').getFromFB() :  NewsApi().fetchArticles(widget.categories ,provListen.isEnglish),
                builder: (context ,snapshot){
                  if(snapshot.hasData){
                    if(widget.categories=='Saved' && snapshot.data.length==0) return NoItemSaved(ctx:context ,isEng: provListen.isEnglish,sWidth: sWidth());
                    
                    else return RefreshIndicator(
                      onRefresh:() async{
                        setState(()=> null );
                      },

                      child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context ,index){

                        //Timer.periodic(Duration(milliseconds: 400), (timer) {http.get('http://newsapi.org/v2/top-headlines?country=us&apiKey=48b4cf61823345fbac6bf3d92fd5989d'); print(timer.tick); });

                        if(firstTime==true){
                          SavedServices(provListen.user+'.json').getFromFB().then((value) => setState(()=> savedDataFB = value) );
                          print('savedDataFB $savedDataFB');
                          firstTime=false;
                        }
                         if(widget.categories!='Saved' && index == 0 && snapshot.data.length >=3){
                            return Container(
                                height: sWidth(0.65),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: ContainerOneNews(
                                        all: savedDataFB,
                                        sWidth: sWidth(0.5),
                                        sHeight: sWidth(0.65),
                                        title: snapshot.data[0].title,
                                        url: snapshot.data[0].url,
                                        author: snapshot.data[0].author.name,
                                        publishedAt: snapshot.data[0].publishedAt,
                                        urlToImage: snapshot.data[0].urlToImage,
                                        isSaved: widget.categories =='Saved',
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                          Expanded(
                                            child: ContainerOneNews(
                                              all: savedDataFB,
                                              sWidth: sWidth(0.5),
                                              sHeight: sWidth(0.65/2),
                                              title: snapshot.data[1].title,
                                              url: snapshot.data[1].url,
                                              author: snapshot.data[1].author.name,
                                              publishedAt: snapshot.data[1].publishedAt,
                                              urlToImage: snapshot.data[1].urlToImage,
                                              isSaved: widget.categories =='Saved',
                                            ),
                                          ),

                                        Expanded(
                                          child: ContainerOneNews(
                                            all: savedDataFB,
                                            sWidth: sWidth(0.5),
                                            sHeight: sWidth(0.65/2),
                                            title: snapshot.data[2].title,
                                            url: snapshot.data[2].url,
                                            author: snapshot.data[2].author.name,
                                            publishedAt: snapshot.data[2].publishedAt,
                                            urlToImage: snapshot.data[2].urlToImage,
                                            isSaved: widget.categories =='Saved',
                                          ),
                                        ),

                                      ],
                                    ),
                                  ],
                                )
                            );
                          }

                        else{
                          if (widget.categories =='Saved') index = index;
                          if (snapshot.data.length <3) index = index ;
                          if (widget.categories!='Saved' && snapshot.data.length >3 ) index = index+2 ;

                          if(widget.categories=='Saved') print('id =${snapshot.data[index].id}');
                          if(snapshot.data.length-1 >= index){
                            return ContainerOneNews(
                              all: savedDataFB,
                              id: widget.categories=='Saved' ?snapshot.data[index].id :null,
                              sWidth: sWidth(),
                              sHeight: sWidth(0.55),
                              title: snapshot.data[index].title,
                              url: snapshot.data[index].url,
                              author: widget.categories=='Saved' ? snapshot.data[index].author==null ?'No':snapshot.data[index].author    : snapshot.data[index].author.name,
                              publishedAt: snapshot.data[index].publishedAt,
                              urlToImage: snapshot.data[index].urlToImage,
                              isSaved: widget.categories =='Saved',
                            );
                          }
                          else return SizedBox();
                        }
                      },
                    )
                    );
                   }
                  else{
                    internetConnected().then((_internetConnected){
                      if(!_internetConnected){
                        Toast.show(Language().widgetsTit(provListen.isEnglish ,4), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM ,);
                      }
                    });

                    return Center(child: CupertinoActivityIndicator());
                      //return Center(child: RaisedButton(onPressed: ()=>NewsApi().launchURL('http://newsapi.org/v2/top-headlines?country=us&apiKey=48b4cf61823345fbac6bf3d92fd5989d'),),);


                  }
                },
              )
            ),
          )
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.categories=='Saved'?false :true;
}
