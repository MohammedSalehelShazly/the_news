/*
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../global/staticVariables.dart';

class SavedServices{
  String user;
  SavedServices(this.user);
  String url() => 'https://the-news-867e8-default-rtdb.firebaseio.com/$user';


 Future getFromFB([bool returnId= false]) async{
    Map<String ,dynamic> jsonData;
    List<SavedArticle> listDataSaved =[];
    List<String> listIdSaved =[];
    try{
      http.Response response = await http.get(url());
      if(response.statusCode==200){
        jsonData = jsonDecode(response.body);
        
        if(jsonData!=null){ // When no news saved yet
          jsonData.forEach((key, value) {
              listDataSaved.add( SavedArticle.fromJson(value ,key));
              listIdSaved.add(key); 
          });
        }
        return returnId ? listIdSaved : listDataSaved;
        
      }
    }catch(ex){
      print('ex FB is $ex');
    }
  }

  Future<bool> searchOnSaved(String title ,List<SavedArticle> all) async{
    bool isFound = false;

    if(all !=null){
      isFound = all.map((e)=> title == e.title).toList()
        .contains(true);
    }else isFound=false; // => first time .. empty saved

    print('isFound $isFound');
    return isFound;

  }



 
Future deleteOneFromFB(String id) async{
  String urlToDel = "${url()}/$id.json";
    try{
        http.Response response = await http.delete(urlToDel);
        print(urlToDel);
        return response;
      }
      catch(ex){
        print('ex delete $ex');
      }

  }
}
class SavedArticle{

  final String id;
  final String author;
  final String title;
  final String url;
  final String urlToImage;
  final String publishedAt;

  SavedArticle({this.id ,this.author, this.title, this.url, this.urlToImage, this.publishedAt});

  factory SavedArticle.fromJson(Map<String ,dynamic> jsonData ,var key){
    return SavedArticle(
      id : key,
      author : jsonData['author'],
      title : jsonData['title'],
      url : jsonData['url'],
      urlToImage : jsonData['urlToImage'] == null ? errorImg : jsonData['urlToImage'],
      publishedAt : jsonData['publishedAt'],
    );
  }
}



*/
/*
[
  -MSmKJIHbJyR_GabgPq5: {
    author: CBS News,
    description: "While I'm not familiar with your work, I'm very proud of my work on movies such as 'Home Alone 2' ...," Mr. Trump wrote.,
    publishedAt: 2021-02-05T12:05:00Z,
    title: Trump resigns from Screen Actors Guild as union considers disciplinary action - CBS News,
    url: https://www.cbsnews.com/news/trump-resigns-sag-letter/,
    urlToImage: https://cbsnews2.cbsistatic.com/hub/i/r/2021/02/04/6eabe50a-aeea-4c3d-b383-19c2c082bb77/thumbnail/1200x630/1036d14e89266ec74ce79b60f8637a05/gettyimages-1230689469.jpg
    },

    -MSmOp7Hh3Yap4DAvHrJ: {author: CBS News, description: "While I'm not familiar with your work, I'm very proud of my work on movies such as 'Home Alone 2' ...," Mr. Trump wrote., publishedAt: 2021-02-05T12:05:00Z, title: Trump resigns from Screen Actors Guild as union considers disciplinary action - CBS News, url: https://www.cbsnews.com/news/trump-resigns-sag-letter/, urlToImage: https://cbsnews2.cbsistatic.com/hub/i/r/2021/02/04/6eabe50a-aeea-4c3d-b383-19c2c082bb77/t
.....
]
*/
