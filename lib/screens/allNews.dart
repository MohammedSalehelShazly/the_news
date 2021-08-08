import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:provider/provider.dart';
import '../global/responsive.dart';
import '../localization/language_constants.dart';
import '../services/providers/settingsProv.dart';
import '../services/providers/themeProv.dart';
import '../global/enums.dart';
import '../global/staticVariables.dart';
import 'package:toast/toast.dart';

import '../widgets/likeSnackBar.dart';
import '../widgets/container_oneNews.dart';
import '../services/providers/mainProvider.dart';
import '../services/newsServices.dart';




class AllNews extends StatelessWidget {

  newsCat categories;
  AllNews([this.categories]);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool first = true;
  ThemeProv themeProv;
  MainProvider mainProvider;
  MainProvider mainProviderWrite;
  NewsApi newsApi;
  NewsApi newsApiWrite;
  SettingsProv settingsProv;

  static var savedDataFB;

  @override
  Widget build(BuildContext context) {
    
    if(first){
      themeProv = Provider.of<ThemeProv>(context);
      mainProvider = Provider.of<MainProvider>(context);
      mainProviderWrite = Provider.of<MainProvider>(context ,listen: false);
      newsApi = Provider.of<NewsApi>(context);
      newsApiWrite = Provider.of<NewsApi>(context ,listen: false);
      settingsProv = Provider.of<SettingsProv>(context);

      first = true;
    }


    if (newsApiWrite.fetchesArticles[categories] == null) {
      newsApiWrite.fetchArticles(categories, settingsProv.appLang);

      Future.delayed(Duration(seconds: 2), () {
        if (newsApiWrite.fetchesArticles[categories] == null)
          internetConnected().then((_internetConnected) {
            if (!_internetConnected) {
              print('_internetConnected $_internetConnected');
              Toast.show(
                getTranslated(context, 'Check the internet connection'),
                context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM,);
            }
          });
      });
    }

    final thisNews = newsApi.fetchesArticles[categories];

    return Scaffold(
        key: scaffoldKey,
        body: AppToast(
          context,
          mainProvider.alreadySavedAppear,
          sContent: Text(
            getTranslated(context, 'already saved'),
            style: TextStyle(color: Colors.white),),
          sColor: Colors.blueGrey[600],

          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child:

              thisNews != null ?
              RefreshIndicator(
                  onRefresh: () async {
                    newsApiWrite.clearArticleNews(categories);
                    newsApiWrite.fetchArticles(categories, settingsProv.appLang);
                  },
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: thisNews.length,
                    itemExtent: responsive.sWidth(context)*0.55,
                    itemBuilder: (context, index) {
                      //Timer.periodic(Duration(milliseconds: 400), (timer) {http.get('http://newsapi.org/v2/top-headlines?country=us&apiKey=48b4cf61823345fbac6bf3d92fd5989d'); print(timer.tick); });

                      if (index == 0 && thisNews.length >= 3) {
                        return Container(
                            height: responsive.sWidth(context) * 0.65,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ContainerOneNews(
                                    themeProv.mainClr(),
                                    all: savedDataFB,
                                    sWidth: responsive.sWidth(context) * 0.5,
                                    sHeight: responsive.sWidth(context) * 0.65,
                                    title: thisNews[0].title,
                                    url: thisNews[0].url,
                                    author: thisNews[0].author.name,
                                    publishedAt: thisNews[0].publishedAt,
                                    urlToImage: thisNews[0].urlToImage,
                                    isSaved: false,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: ContainerOneNews(
                                        themeProv.mainClr(),
                                        all: savedDataFB,
                                        sWidth: responsive.sWidth(context) * 0.5,
                                        sHeight: responsive.sWidth(context) * 0.65 / 2,
                                        title: thisNews[1].title,
                                        url: thisNews[1].url,
                                        author: thisNews[1].author.name,
                                        publishedAt: thisNews[1].publishedAt,
                                        urlToImage: thisNews[1].urlToImage,
                                        isSaved: false,
                                      ),
                                    ),

                                    Expanded(
                                      child: ContainerOneNews(
                                        themeProv.mainClr(),
                                        all: savedDataFB,
                                        sWidth: responsive.sWidth(context) * 0.5,
                                        sHeight: responsive.sWidth(context) * 0.65 / 2,
                                        title: thisNews[2].title,
                                        url: thisNews[2].url,
                                        author: thisNews[2].author.name,
                                        publishedAt: thisNews[2].publishedAt,
                                        urlToImage: thisNews[2].urlToImage,
                                        isSaved: false,
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            )
                        );
                      }

                      else {
                        if (thisNews.length < 3) index = index;
                        if (thisNews.length > 3) index = index + 2;

                        if (thisNews.length - 1 >= index) {
                          return ContainerOneNews(
                            themeProv.mainClr(),
                            all: savedDataFB,
                            id: null,
                            sWidth: responsive.sWidth(context),
                            sHeight: responsive.sWidth(context) * 0.55,
                            title: thisNews[index].title,
                            url: thisNews[index].url,
                            author: thisNews[index].author.name,
                            publishedAt: thisNews[index].publishedAt,
                            urlToImage: thisNews[index].urlToImage,
                            isSaved: false,
                          );
                        }
                        else
                          return SizedBox();
                      }
                    },
                  )
              )


                  : Center(child: CupertinoActivityIndicator())


          ),
        )
    );
  }

}




