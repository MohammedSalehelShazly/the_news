import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global/appClrs.dart';
import '../global/responsive.dart';
import '../helper/launchHelper.dart';
import '../global/staticVariables.dart';

class OneNewsItem extends StatelessWidget {
  final Color mainClr;
  final String author;
  final String title;
  final String url;
  final String urlToImage;
  final String publishedAt;

  final double sHeight ;
  final double sWidth ;


  OneNewsItem(this.mainClr ,{
    @required this.author,
    @required this.title,
    @required this.url,
    @required this.urlToImage,
    @required this.publishedAt,
    @required this.sHeight,
    @required this.sWidth,
  });
  
  

  String timePublished(){
    DateTime time = DateTime.parse(publishedAt);
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
    DateTime time = DateTime.parse(publishedAt);
    if(DateTime.now().difference(time).inHours ==0) return '${DateTime.now().difference(time).inMinutes} minutes age ' ;
    else{
      if(DateTime.now().difference(time).inHours <24) return  '${DateTime.now().difference(time).inHours} hours ago';
      else if ((DateTime.now().difference(time).inHours >=24)) return  '${DateTime.now().difference(time).inDays} days ago';
      else if ((DateTime.now().difference(time).inHours >=30)) return '${time.hour>=10?  time.hour : '0'+time.hour.toString()}:${time.minute>=10 ? time.minute: '0'+time.minute.toString()}   ${time.year}-${time.month>=10? time.month : '0'+time.month.toString()}-${time.day>10?time.day : '0'+time.day.toString()}' ;
      else return '';
    }
  }

  String urlToImg(){
    String _urlToImage =

    author.contains('Aljazeera')
        ? aljazeeraImg
        : author.contains('Google')
        ? googleNewsImg
        : (urlToImage!=null && urlToImage.endsWith("*") ) || urlToImage==null
        ? errorImg
        : urlToImage ;

    return _urlToImage;
      }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        LaunchHelper().launchURL(url);
      },
      borderRadius: BorderRadius.vertical(top: Radius.circular(15) ),
      child: Container(
        margin: const EdgeInsets.all(5),
        height: sHeight,
        width: sWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15) ),
          image: DecorationImage(
              image: NetworkImage(urlToImg()),
              fit: sHeight == MediaQuery.of(context).size.width *0.65 ? BoxFit.fill : BoxFit.cover
          ),

        ),
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white70,
                    child: Text(
                      author[0]?? ' ' ,
                    ),
                  ),
                  Text(
                    responsive.isPortrait(context) && sHeight == responsive.sWidth(context) * 0.65 && author.length > 12
                        ? author.substring(0 ,12)+'..'
                        :
                    author,
                    style: const TextStyle(shadows: [BoxShadow(blurRadius: 8,spreadRadius: 10)]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),


            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(
                        sHeight == responsive.sWidth(context) * 0.65 / 2
                            ?0 :8),
                    alignment: textIsEnglish(title) ? Alignment.bottomLeft : Alignment.bottomRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title ,
                          style: TextStyle(
                            color: appClrs.secondColor,
                            fontSize: sHeight == responsive.sWidth(context) * 0.65 / 2
                                ? 12 :null,
                            height: 1.5
                          ),
                          maxLines: sHeight == responsive.sWidth(context)*0.65
                              ? 3 : 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                            textIsEnglish(title) ? timePublishedEng() : timePublished() ,
                              style: TextStyle(fontSize:
                              responsive.textScale(context) *
                                  sHeight == responsive.sWidth(context)*0.65/2 ? 10 : 12 ),
                            ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black38 ,Colors.black38 ,Colors.black38 ,Colors.black45 ],
                        )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
