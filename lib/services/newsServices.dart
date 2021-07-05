import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../models/articleList_models.dart';

import '../models/article_models.dart';

class NewsApi{
  String newsKey = '74c370f0886841c7ac7b8b4f16864bcd'; // from second mail 
  String newsKeySec = '48b4cf61823345fbac6bf3d92fd5989d'; // from mail ma7madsalle7@gmail.com
  
  // http://newsapi.org/v2/top-headlines?country=us&apiKey=48b4cf61823345fbac6bf3d92fd5989d 
  Map allServices(key ,country)=> {
  'all' : 'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$key', // all
  'Sports' : 'https://newsapi.org/v2/top-headlines?country=$country&category=sports&apiKey=$key', //sport
  'Technology' : 'https://newsapi.org/v2/top-headlines?country=$country&category=technology&apiKey=$key', //technology
  'Scince & space' : 'https://newsapi.org/v2/top-headlines?country=$country&category=science&apiKey=$key', //science
  'Art' : 'https://newsapi.org/v2/top-headlines?country=$country&category=entertainment&apiKey=$key', //entertainment = art
  'Health' : 'https://newsapi.org/v2/top-headlines?country=$country&category=health&apiKey=$key', //health
  'Business' : 'https://newsapi.org/v2/top-headlines?country=$country&category=business&apiKey=$key', //business
  };



  Future< List<Article> > fetchArticles(categories ,bool isEng) async{
    Map<String ,dynamic> jsonData;
    try{
      http.Response response = await http.get(allServices(newsKey ,isEng?'us':'eg')[categories]);
      //check if my kay is used limited => use another key
      if(jsonDecode(response.body)['code']=='rateLimited'){
          print('used Second');
          response = await http.get(allServices(newsKeySec ,isEng?'us':'eg')[categories]);
      }
      if(response.statusCode==200){
        jsonData = jsonDecode(response.body);
        ArticlesList articlesList = ArticlesList.fromJson(jsonData);
        List<Article> listOfArticle = articlesList.articleList.map((e) => Article.fromJson(e)).toList();
        return listOfArticle;
      }else print('statusCode = ${response.statusCode}');
    }catch(ex){
      print('ex is... $ex');
    }
  }



  Future launchURL(String siteUrl ,[wantToForceWebView=true]) async{
    if (await canLaunch(siteUrl)) {
      await launch(
        siteUrl,
        forceWebView: wantToForceWebView,
        enableJavaScript: wantToForceWebView,
      );
    } else{
      throw 'Could not launch $siteUrl';
    }
  }
}
