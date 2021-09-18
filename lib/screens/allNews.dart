import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../global/responsive.dart';
import '../localization/language_constants.dart';
import '../services/providers/settingsProv.dart';
import '../services/providers/themeProv.dart';
import '../global/enums.dart';
import '../global/staticVariables.dart';
import '../widgets/oneNewsItem.dart';
import '../services/newsServices.dart';

import 'package:toast/toast.dart';
import 'package:provider/provider.dart';


class AllNews extends StatelessWidget {

  newsCat categories;
  AllNews([this.categories]);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool first = true;
  ThemeProv themeProv;
  NewsApi newsApi;
  NewsApi newsApiWrite;
  SettingsProv settingsProv;

  static var savedDataFB;

  @override
  Widget build(BuildContext context) {
    
    if(first){
      themeProv = Provider.of<ThemeProv>(context);
      newsApi = Provider.of<NewsApi>(context);
      newsApiWrite = Provider.of<NewsApi>(context ,listen: false);
      settingsProv = Provider.of<SettingsProv>(context);

      newsApi.fetchesArticles[categories] = newsApi.fetchesArticles[categories];

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


    return Scaffold(
        key: scaffoldKey,
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child:

            /// its equal allNews of this category
            newsApi.fetchesArticles[categories] != null ?
            RefreshIndicator(
                onRefresh: () async {
                  newsApiWrite.clearArticleNews(categories);
                  newsApiWrite.fetchArticles(categories, settingsProv.appLang);
                },
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: newsApi.fetchesArticles[categories].length-2,
                  itemExtent: responsive.sWidth(context)*0.55,
                  itemBuilder: (context, index) {
                    //Timer.periodic(Duration(milliseconds: 400), (timer) {http.get('http://newsapi.org/v2/top-headlines?country=us&apiKey=48b4cf61823345fbac6bf3d92fd5989d'); print(timer.tick); });

                    if (index == 0 && newsApi.fetchesArticles[categories].length >= 3) {
                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: OneNewsItem(
                              themeProv.mainClr(),
                              sWidth: responsive.sWidth(context) * 0.5,
                              sHeight: responsive.sWidth(context) * 0.65,
                              title: newsApi.fetchesArticles[categories][0].title,
                              url: newsApi.fetchesArticles[categories][0].url,
                              author: newsApi.fetchesArticles[categories][0].author.name,
                              publishedAt: newsApi.fetchesArticles[categories][0].publishedAt,
                              urlToImage: newsApi.fetchesArticles[categories][0].urlToImage,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Expanded(
                                child: OneNewsItem(
                                  themeProv.mainClr(),
                                  sWidth: responsive.sWidth(context) * 0.5,
                                  sHeight: responsive.sWidth(context) * 0.65 / 2,
                                  title: newsApi.fetchesArticles[categories][1].title,
                                  url: newsApi.fetchesArticles[categories][1].url,
                                  author: newsApi.fetchesArticles[categories][1].author.name,
                                  publishedAt: newsApi.fetchesArticles[categories][1].publishedAt,
                                  urlToImage: newsApi.fetchesArticles[categories][1].urlToImage,
                                ),
                              ),

                              Expanded(
                                child: OneNewsItem(
                                  themeProv.mainClr(),
                                  sWidth: responsive.sWidth(context) * 0.5,
                                  sHeight: responsive.sWidth(context) * 0.65 / 2,
                                  title: newsApi.fetchesArticles[categories][2].title,
                                  url: newsApi.fetchesArticles[categories][2].url,
                                  author: newsApi.fetchesArticles[categories][2].author.name,
                                  publishedAt: newsApi.fetchesArticles[categories][2].publishedAt,
                                  urlToImage: newsApi.fetchesArticles[categories][2].urlToImage,
                                ),
                              ),

                            ],
                          ),
                        ],
                      );
                    }

                    else {
                      if (newsApi.fetchesArticles[categories].length < 3) index = index;
                      if (newsApi.fetchesArticles[categories].length > 3) index = index + 2;

                      return OneNewsItem(
                        themeProv.mainClr(),
                        sWidth: responsive.sWidth(context),
                        sHeight: responsive.sWidth(context) * 0.55,
                        title: newsApi.fetchesArticles[categories][index].title,
                        url: newsApi.fetchesArticles[categories][index].url,
                        author: newsApi.fetchesArticles[categories][index].author.name,
                        publishedAt: newsApi.fetchesArticles[categories][index].publishedAt,
                        urlToImage: newsApi.fetchesArticles[categories][index].urlToImage,
                      );

                    }
                  },
                )
            )
                : Center(child: CupertinoActivityIndicator())
        )
    );
  }

}




