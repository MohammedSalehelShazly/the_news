import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../staticVariables.dart';
import '../widgets/likeSnackBar.dart';
import '../models/article_models.dart';
import '../providerReT.dart';
import '../widgets/container_oneNews.dart';
import '../widgets/noSearchItems.dart';
import '../languages.dart';
import '../services/newsServices.dart';


class SearchNews extends StatelessWidget {

  Future<List<Article>> all(bool isEng)=> NewsApi().fetchArticles('all' ,isEng);
  Future<List<Article>> sports(bool isEng)=> NewsApi().fetchArticles('Sports' ,isEng);
  Future<List<Article>> technology(bool isEng)=> NewsApi().fetchArticles('Technology' ,isEng);
  Future<List<Article>> scince_space(bool isEng)=> NewsApi().fetchArticles('Scince & space' ,isEng);
  Future<List<Article>> art(bool isEng)=> NewsApi().fetchArticles('Art' ,isEng);
  Future<List<Article>> health(bool isEng)=> NewsApi().fetchArticles('Health' ,isEng);
  Future<List<Article>> business(bool isEng)=> NewsApi().fetchArticles('Business' ,isEng);

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

  List hasSearch = [];
  findSearch(bool isEng){
    return addAllNews(isEng).then((listAllNews){

      for(int i=0 ;i<listAllNews.length ;i++){
        if(listAllNews[i].title.toString().toLowerCase().contains(inputController.text.toLowerCase())){
          hasSearch.add(listAllNews[i]);
          hasSearch = hasSearch.toSet().toList();
        }
        else {
          hasSearch.remove(listAllNews[i]);
          hasSearch = hasSearch.toSet().toList();
        }
      }

      return hasSearch.toSet().toList() ;

    });
  }

  test(){
    List<Map> x  = [
      {
        'name':'Mohammed',
        'year':'2021',
        'class':'C1',
      },
      {
        'name':'Mohammed',
        'year':'2021',
        'class':'C1',
      },
      {
        'name':'Mohammed',
        'year':'2021',
        'class':'C1',
      },
    ];

    return x.toSet().toList().length;   // 2  ??
  }

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
                        future: findSearch(provListen.isEnglish),
                        builder: (context, AsyncSnapshot<dynamic> snapshot){

                          return snapshot.hasData ? Padding(
                            padding: EdgeInsets.only(top: sHeight(context ,0.09)),
                            child: snapshot.data.length == 0 ?  NoSearchItems(context ,sWidth: sWidth(context),)
                                :
                            ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context ,index){
                                  return ContainerOneNews(
                                    sWidth: sWidth(context),
                                    sHeight: sWidth(context, 0.55),
                                    title: snapshot.data[index].title,
                                    url: snapshot.data[index].url,
                                    author: snapshot.data[index].author.name,
                                    description: snapshot.data[index].description,
                                    publishedAt: snapshot.data[index].publishedAt,
                                    urlToImage: snapshot.data[index].urlToImage,
                                  );
                                }
                            ),
                          )
                              :  Center(child: CupertinoActivityIndicator());

                        }
                    ),
                  ),
                ),


                Container(
                  padding: EdgeInsets.all(3),
                  alignment: Alignment.bottomCenter,
                  height: sHeight(context ,0.09),
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
