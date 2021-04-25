import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_news/providerReT.dart';
import '../languages.dart';
import '../models/SavedArticles.dart';
import '../services/newsServices.dart';

import '../staticVariables.dart';
import 'dialog.dart';

class ContainerOneNews extends StatefulWidget {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;

  final double sHeight ;
  final double sWidth ;

  final bool isSaved;

  ContainerOneNews({
    @required this.author,
    @required this.title,
    @required this.description,
    @required this.url,
    @required this.urlToImage,
    @required this.publishedAt,
    @required this.sHeight,
    @required this.sWidth,
    this.isSaved = false,
  });

  @override
  _ContainerOneNewsState createState() => _ContainerOneNewsState();
}

class _ContainerOneNewsState extends State<ContainerOneNews> with AutomaticKeepAliveClientMixin{

  String timePublished(){
    DateTime time = DateTime.parse(widget.publishedAt);
    if(DateTime.now().difference(time).inHours ==0) return ' منذ ${DateTime.now().difference(time).inMinutes} دقائــق ' ;
    else{
      if(DateTime.now().difference(time).inHours <24) return  ' منذ ${DateTime.now().difference(time).inHours} ساعــات ';
      else if ((DateTime.now().difference(time).inHours >=24)) return  ' قبـل ${DateTime.now().difference(time).inDays} يوم ';
      else if ((DateTime.now().difference(time).inHours >=30)) return '${time.hour>=10?  time.hour : '0'+time.hour.toString()}:${time.minute>=10 ? time.minute: '0'+time.minute.toString()}   ${time.year}-${time.month>=10? time.month : '0'+time.month.toString()}-${time.day>10?time.day : '0'+time.day.toString()}' ;
      else return '';
    }
  }
  /// english
  String timePublishedEng(){
    DateTime time = DateTime.parse(widget.publishedAt);
    if(DateTime.now().difference(time).inHours ==0) return '${DateTime.now().difference(time).inMinutes} muintes age ' ;
    else{
      if(DateTime.now().difference(time).inHours <24) return  '${DateTime.now().difference(time).inHours} hours ago';
      else if ((DateTime.now().difference(time).inHours >=24)) return  '${DateTime.now().difference(time).inDays} days ago';
      else if ((DateTime.now().difference(time).inHours >=30)) return '${time.hour>=10?  time.hour : '0'+time.hour.toString()}:${time.minute>=10 ? time.minute: '0'+time.minute.toString()}   ${time.year}-${time.month>=10? time.month : '0'+time.month.toString()}-${time.day>10?time.day : '0'+time.day.toString()}' ;
      else return '';
    }
  }

  String urlToImg()=>
      widget.urlToImage==null && widget.author.contains('Google News')==false ? errorImg
          :widget.author.contains('Aljazeera') ? aljazeeraImg
          :widget.author.contains('Google News') ? googleNewsImg
          :widget.urlToImage ;

  bool isSaved = false ;

  @override
  void initState() {
    isSaved = widget.isSaved;
    super.initState();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final provListen = Provider.of<MyProviderReT>(context);

    return widget.isSaved==true&&isSaved==false ? SizedBox():Directionality(
      textDirection: provListen.isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: InkWell(
        onTap: (){
          NewsApi().launchURL(widget.url);
        },
        child: Container(
          key: scaffoldKey,
          margin: EdgeInsets.all(5),
          height: widget.sHeight,
          width: widget.sWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15) ),
            image: DecorationImage(
                image: NetworkImage(urlToImg()),
                fit: widget.sHeight == MediaQuery.of(context).size.width *0.65 ? BoxFit.fill : BoxFit.cover
            ),

          ),
          alignment: Alignment.bottomCenter,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.bottomRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title ,
                            style: myTextStyle(context ,ratioSize: 17 ,clr: Colors.orange[600]),
                            maxLines: widget.sHeight == MediaQuery.of(context).size.width *0.65 ? 3 : 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                              provListen.isEnglish ? timePublishedEng() : timePublished() ,
                                style: myTextStyle(context ,ratioSize: widget.sHeight == MediaQuery.of(context).size.width *0.65/2 ? 10 : 12),
                              ),
                            ],
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black12 ,Colors.black12 ,Colors.black26 ,Colors.black38 ],
                          )
                      ),
                    ),
                  ],
                ),
              ),

              Align(
                alignment: Alignment.topLeft,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white70,
                        child: Text(
                          widget.author[0] ,
                          style: myTextStyle(context ,clr: Colors.black),
                        ),
                      ),
                      Text(
                          widget.author,
                          style: myTextStyle(context).copyWith(shadows: [BoxShadow(blurRadius: 20,)])
                      ),
                    ],
                  ),
                ),
              ),

              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: isSaved ?Colors.blue :Colors.black87 ,
                  ),
                  onPressed: (){
                    setState(() {
                      if(isSaved){
                        if(widget.isSaved==true){
                          showDialog(
                              context: context ,
                              builder: (context)=>
                                  AppDialog(
                                    contentTxt: Language().dialogTit(provListen.isEnglish ,2),
                                    ctx: context,
                                    secondActTxt: Language().dialogTit(provListen.isEnglish ,1),
                                    isEnglish: true,
                                    func:(){
                                      setState(() {
                                        isSaved = false;
                                        SavedDB().deleteOne(widget.title);
                                      });
                                    },
                                  )
                          );
                        }
                        else{
                          isSaved = false;
                          SavedDB().deleteOne(widget.title);
                        }
                      }
                      else{
                        SavedDB().searchOnSaved(widget.title).then((alreadySaved){
                          if(alreadySaved==false){
                            isSaved = true;
                            SavedDB().insertRow({
                              'author' : widget.author,
                              'title' : widget.title,
                              'description' : widget.description,
                              'url' : widget.url,
                              'urlToImage' : urlToImg(),
                              'publishedAt' : widget.publishedAt,
                            });
                          }
                          else{
                            Provider.of<MyProviderReT>(context ,listen: false).setAlreadySavedAppear(true);
                            Future.delayed(Duration(seconds: 2),(){
                              Provider.of<MyProviderReT>(context ,listen: false).setAlreadySavedAppear(false);
                            });

                            //AllNews().scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Already Saved'),));

                          }
                        });

                      }
                    });
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  showSnackBar(BuildContext _context){
  }

  @override
  bool get wantKeepAlive => true;
}
