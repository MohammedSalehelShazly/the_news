
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../models/articleList_models.dart';

import '../models/article_models.dart';
import '../models/weather_models.dart';

class NewsApi{
  static String newsKey = '74c370f0886841c7ac7b8b4f16864bcd';
  static Map allServices = {
  'all' : 'http://newsapi.org/v2/top-headlines?country=eg&apiKey=$newsKey', // eg
  'allFr' : 'http://newsapi.org/v2/top-headlines?country=fr&apiKey=$newsKey', //fr
  'Sports' : 'http://newsapi.org/v2/top-headlines?country=eg&category=sports&apiKey=$newsKey', //sport
  'Technology' : 'http://newsapi.org/v2/top-headlines?country=eg&category=technology&apiKey=$newsKey', //technology
  'Scince & space' : 'http://newsapi.org/v2/top-headlines?country=eg&category=science&apiKey=$newsKey', //science
  'Art' : 'http://newsapi.org/v2/top-headlines?country=eg&category=entertainment&apiKey=$newsKey', //entertainment = art
  'Health' : 'http://newsapi.org/v2/top-headlines?country=eg&category=health&apiKey=$newsKey', //health
  'Business' : 'http://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=$newsKey', //business
  };
  static Map<String ,String> allServicesUSA = {
    'all' : 'http://newsapi.org/v2/top-headlines?country=us&apiKey=$newsKey', // eg
    'allFr' : 'http://newsapi.org/v2/top-headlines?country=fr&apiKey=$newsKey', //fr
    'Sports' : 'http://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=$newsKey', //sport
    'Technology' : 'http://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=$newsKey', //technology
    'Scince & space' : 'http://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=$newsKey', //science
    'Art' : 'http://newsapi.org/v2/top-headlines?country=us&category=entertainment&apiKey=$newsKey', //entertainment = art
    'Health' : 'http://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=$newsKey', //health
    'Business' : 'http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$newsKey', //business
  };



  Future< List<Article> > fetchArticles(categories ,bool isEng) async{
    Map<String ,dynamic> jsonData;
    try{
      http.Response response = await http.get(isEng ? Uri.parse(allServicesUSA[categories]) : Uri.parse(allServices[categories]));
      if(response.statusCode==200){
        jsonData = jsonDecode(response.body);
        ArticlesList articlesList = ArticlesList.fromJson(jsonData);
        List<Article> listOfArticle = articlesList.articleList.map((e) => Article.fromJson(e)).toList();
        return listOfArticle;
      }
    }catch(ex){
      print(ex);
    }
  }
  Future launchURL(String siteUrl ,[bool wantToForceWebView=true]) async{
    if (await canLaunch(siteUrl)) {
      await launch(
        siteUrl,
        forceWebView: wantToForceWebView,
      );
    } else{
      throw 'Could not launch $siteUrl';
    }
  }
}








class WeatherApi{
  static String weatherKey = '25b3da6649d0002c5702c50b3470ca33';
  Future<WeatherModel> fetchDataWeather(String country) async{
    Map<String ,dynamic> jsonData;
    try{
      http.Response response = await http.get(Uri.parse('http://api.weatherstack.com/current?access_key=$weatherKey&query=$country'));
      if(response.statusCode==200){
        jsonData = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(jsonData);
        return weatherModel;
      }
    }catch(ex){
      print(ex);
    }
  }
}
