import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/SavedArticles.dart';
import '../widgets/searchInitScreen.dart';
import '../staticVariables.dart';
import '../widgets/likeSnackBar.dart';
import '../models/article_models.dart';
import '../providerReT.dart';
import '../widgets/container_oneNews.dart';
import '../widgets/noSearchItems.dart';
import '../languages.dart';
import '../services/newsServices.dart';


class SearchNews extends StatefulWidget {

  @override
  _SearchNewsState createState() => _SearchNewsState();
}

class _SearchNewsState extends State<SearchNews> {
  static Future<List<Article>> all(bool isEng)=> NewsApi().fetchArticles('all' ,isEng);

  static Future<List<Article>> sports(bool isEng)=> NewsApi().fetchArticles('Sports' ,isEng);

  static Future<List<Article>> technology(bool isEng)=> NewsApi().fetchArticles('Technology' ,isEng);

  static Future<List<Article>> scince_space(bool isEng)=> NewsApi().fetchArticles('Scince & space' ,isEng);

  static Future<List<Article>> art(bool isEng)=> NewsApi().fetchArticles('Art' ,isEng);

  static Future<List<Article>> health(bool isEng)=> NewsApi().fetchArticles('Health' ,isEng);

  static Future<List<Article>> business(bool isEng)=> NewsApi().fetchArticles('Business' ,isEng);

  Future<List<Article>> addAllNews(bool isEng){
    return all(isEng).then((allVal){
      return sports(isEng).then((sportsVal){
        return technology(isEng).then((technologyVal){
          return scince_space(isEng).then((scince_spaceVal){
            return art(isEng).then((artVal){
              return health(isEng).then((healthVal){
                return business(isEng).then((businessVal){
                  allVal.addAll(sportsVal);
                  allVal.addAll(technologyVal);
                  allVal.addAll(scince_spaceVal);
                  allVal.addAll(artVal);
                  allVal.addAll(healthVal);
                  allVal.addAll(businessVal);
                  return allVal.toSet().toList();
                });
              });
            });
          });
        });
      });
    });
  }

  TextEditingController inputController = TextEditingController();

  sWidth(BuildContext context ,[ratio=1])=>MediaQuery.of(context).size.width*ratio;

  sHeight(BuildContext context ,[ratio=1])=>MediaQuery.of(context).size.height*ratio;

  List<Article> hasSearch = [];

   Future<List<Article> > findSearch(bool isEng ,ctrl) async{
    return await addAllNews(isEng).then((listAllNews){
      hasSearch.clear();
      
      if(ctrl.toString().trim() != ''){
        for(int i=0 ;i<listAllNews.length ;i++){
          if(listAllNews[i].title.toString().toLowerCase().contains(ctrl.toLowerCase())){
            hasSearch.add(listAllNews[i]);
          }
          else {
            hasSearch.remove(listAllNews[i]);
          }
        }
        if(hasSearch.length<2) return hasSearch ; 
        else return listOfMapToSet(hasSearch);
      }
      else return hasSearch;
    });
  }

  double searchFiledHeight()=> sHeight(context ,0.09);
    
  static var savedDataSQlite;
  bool firstTime=true;

  @override
  Widget build(BuildContext context) {
    final provListen = Provider.of<MyProviderReT>(context);


    return Directionality(
      textDirection: provListen.isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
            body: Stack(
              children: [
                LikeSnackBar(
                  context ,
                  Provider.of<MyProviderReT>(context).alreadySavedAppear,
                  sContent: Text(
                    Language().widgetsTit(provListen.isEnglish ,0),
                    style: TextStyle(color: Colors.white),),
                  sColor: Colors.blueGrey[600],


                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: FutureBuilder(
                        future: findSearch(provListen.isEnglish ,inputController.text),
                        builder: (context, AsyncSnapshot<List<Article> > snapshot){
                          if(snapshot.hasData){
                            if(firstTime==true){
                              SavedDB().getAll().then((value) => setState(()=> savedDataSQlite=value) );
                              print('savedDataSQlite $savedDataSQlite');
                              firstTime=false;
                            }
                          }
                          
                          
                          return snapshot.hasData && snapshot.data.length!=0 ? Padding(
                            padding: EdgeInsets.only(top: searchFiledHeight()),
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context ,index){
                                  return ContainerOneNews(
                                    all: savedDataSQlite,
                                    sWidth: sWidth(context),
                                    sHeight: sWidth(context, 0.55),
                                    title: snapshot.data[index].title,
                                    url: snapshot.data[index].url,
                                    author: snapshot.data[index].author.name,
                                    publishedAt: snapshot.data[index].publishedAt,
                                    urlToImage: snapshot.data[index].urlToImage,
                                  );
                                }
                            ),
                          )
                              :
                          snapshot.hasData && snapshot.data.length==0 && inputController.text=='' || snapshot.data==null && inputController.text=='' ?  SearchInitScreen(context ,topPadding: searchFiledHeight() ,sWidth: sWidth(context),)
                              :
                          snapshot.hasData && snapshot.data.length==0 && inputController.text!='' || snapshot.data==null && inputController.text!='' ? NoSearchItems(context ,sWidth: sWidth(context),)
                              :

                          Center(child: CupertinoActivityIndicator());

                        }
                    ),
                  ),
                ),


                Container(
                  padding: EdgeInsets.all(3),
                  alignment: Alignment.bottomCenter,
                  height: searchFiledHeight(),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios ,color: appColorPrimary,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),

                      Expanded(
                        child: TextFormField(
                          textInputAction: TextInputAction.search,
                          autofocus: true,
                          controller: inputController,
                          cursorColor: appColorPrimary,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            filled: true,
                            fillColor: appColorPrimary.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                              prefixIcon: Icon(Icons.search),
                              hintText: Language().searchTit(provListen.isEnglish ,0)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
