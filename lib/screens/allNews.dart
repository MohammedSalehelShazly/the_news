import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_news/languages.dart';
import 'package:the_news/models/SavedArticles.dart';
import 'package:the_news/widgets/container_oneNews.dart';
import 'package:the_news/widgets/likeSnackBar.dart';
import '../providerReT.dart';
import '../services/newsServices.dart';
import 'package:provider/provider.dart';



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
                future: widget.categories=='Saved' ?SavedDB().getAll() :  NewsApi().fetchArticles(widget.categories ,provListen.isEnglish),
                builder: (context ,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context ,index){
                         if(widget.categories!='Saved' && index == 0 && snapshot.data.length >=3){
                            return Container(
                                height: sWidth(0.65),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: ContainerOneNews(
                                        sWidth: sWidth(0.5),
                                        sHeight: sWidth(0.65),
                                        title: snapshot.data[0].title,
                                        url: snapshot.data[0].url,
                                        author: snapshot.data[0].author.name,
                                        description: snapshot.data[0].description,
                                        publishedAt: snapshot.data[0].publishedAt,
                                        urlToImage: snapshot.data[0].urlToImage,
                                        isSaved: widget.categories =='Saved',
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                          Expanded(
                                            child: ContainerOneNews(
                                              sWidth: sWidth(0.5),
                                              sHeight: sWidth(0.65/2),
                                              title: snapshot.data[1].title,
                                              url: snapshot.data[1].url,
                                              author: snapshot.data[1].author.name,
                                              description: snapshot.data[1].description,
                                              publishedAt: snapshot.data[1].publishedAt,
                                              urlToImage: snapshot.data[1].urlToImage,
                                              isSaved: widget.categories =='Saved',
                                            ),
                                          ),

                                        Expanded(
                                          child: ContainerOneNews(
                                            sWidth: sWidth(0.5),
                                            sHeight: sWidth(0.65/2),
                                            title: snapshot.data[2].title,
                                            url: snapshot.data[2].url,
                                            author: snapshot.data[2].author.name,
                                            description: snapshot.data[2].description,
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

                          if(snapshot.data.length-1 >= index)
                          return ContainerOneNews(
                            sWidth: sWidth(),
                            sHeight: sWidth(0.55),
                            title: widget.categories =='Saved' ? snapshot.data[index]['title'] : snapshot.data[index].title,
                            url: widget.categories =='Saved' ? snapshot.data[index]['url'] : snapshot.data[index].url,
                            author: widget.categories =='Saved' ? snapshot.data[index]['author'] : snapshot.data[index].author.name,
                            description: widget.categories =='Saved' ? 'description' : snapshot.data[index].description,
                            publishedAt: widget.categories =='Saved' ? snapshot.data[index]['publishedAt'] : snapshot.data[index].publishedAt,
                            urlToImage: widget.categories =='Saved' ? snapshot.data[index]['urlToImage'] : snapshot.data[index].urlToImage,
                            isSaved: widget.categories =='Saved',
                          );
                          else return SizedBox();
                        }
                      },
                    );
                  }
                  else{
                    return Center(child: CupertinoActivityIndicator());
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

/*
  Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(20, (index) => largeContainer(sWidth(0.5) ,sWidth(0.65)),),
        ),
      ),
    ),
*/

/*test()async{
  NewsApi newsApi = NewsApi();
  var articles = await newsApi.fetchArticles();
  List images ;
  return articles[0].urlToImage ;
}*/

}
