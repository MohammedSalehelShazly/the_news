import 'package:flutter/material.dart';
import '../global/responsive.dart';
import '../localization/language_constants.dart';
import 'file:///C:/Users/user/AndroidStudioProjects/the_news/lib/helper/helper.dart';

import '../global/staticVariables.dart';
import 'package:provider/provider.dart';
import '../services/providers/mainProvider.dart';

class NoSearchItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provListen = Provider.of<MainProvider>(context);
    return Container(
      width: responsive.sWidth(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.search ,color: Colors.black87,size: responsive.textScale(context)*100,),
          Text(
            getTranslated(context, "Sorry, we didn't find any results matching your search"),
            style: TextStyle(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),

          Padding(
            padding: EdgeInsets.only(top: responsive.sWidth(context)*0.2),
            child: InkWell(
              onTap:()=> launchURL('http://google.com'),
              child:
              Padding(
                padding: const EdgeInsets.all(10),
                child: RichText(
                  textDirection: TextDirection.ltr,
                  text: TextSpan(
                    style: TextStyle(letterSpacing: 1 ,shadows: [BoxShadow(blurRadius: 1 , spreadRadius: 10)]),
                    children: [
                      TextSpan(text: 'G' ,style: TextStyle(color: Colors.blue, fontFamily: 'Raleway')),
                      TextSpan(text: 'o' ,style: TextStyle(color: Colors.red, fontFamily: 'Raleway')),
                      TextSpan(text: 'o' ,style: TextStyle(color: Colors.yellow, fontFamily: 'Raleway')),
                      TextSpan(text: 'g' ,style: TextStyle(color: Colors.blue, fontFamily: 'Raleway')),
                      TextSpan(text: 'l' ,style: TextStyle(color: Colors.green, fontFamily: 'Raleway')),
                      TextSpan(text: 'e' ,style: TextStyle(color: Colors.red, fontFamily: 'Raleway')),
                      TextSpan(text: '  ?' ,style:TextStyle(color: Colors.black87, fontFamily: 'Raleway')),
                    ]
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
