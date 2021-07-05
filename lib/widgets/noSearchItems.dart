import 'package:flutter/material.dart';
import 'package:the_news/services/newsServices.dart';

import '../languages.dart';
import '../staticVariables.dart';
import 'package:provider/provider.dart';
import '../providerReT.dart';

class NoSearchItems extends StatelessWidget {
  final double sWidth;
  final BuildContext ctx ;
  NoSearchItems(this.ctx,{@required this.sWidth});
  @override
  Widget build(BuildContext context) {
    final provListen = Provider.of<MyProviderReT>(context);
    return Container(
      width: sWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.search ,color: Colors.black87,size: MediaQuery.textScaleFactorOf(ctx)*100,),
          Text(
            Language().searchTit(provListen.isEnglish ,1),
            style: myTextStyle(ctx ,clr: Colors.black ,ratioSize: 20).copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),

          Padding(
            padding: EdgeInsets.only(top: sWidth*0.2),
            child: InkWell(
              onTap:()=> NewsApi().launchURL('http://google.com'),
              child:
              Padding(
                padding: const EdgeInsets.all(10),
                child: RichText(
                  textDirection: TextDirection.ltr,
                  text: TextSpan(
                    style: TextStyle(letterSpacing: 1 ,shadows: [BoxShadow(blurRadius: 1 , spreadRadius: 10)]),
                    children: [
                      TextSpan(text: 'G' ,style: myTextStyle(ctx ,clr: Colors.blue ,ratioSize: 22 ,family: 'Raleway')),
                      TextSpan(text: 'o' ,style: myTextStyle(ctx ,clr: Colors.red ,ratioSize: 22 ,family: 'Raleway')),
                      TextSpan(text: 'o' ,style: myTextStyle(ctx ,clr: Colors.yellow ,ratioSize: 22 ,family: 'Raleway')),
                      TextSpan(text: 'g' ,style: myTextStyle(ctx ,clr: Colors.blue ,ratioSize: 22 ,family: 'Raleway')),
                      TextSpan(text: 'l' ,style: myTextStyle(ctx ,clr: Colors.green ,ratioSize: 22 ,family: 'Raleway')),
                      TextSpan(text: 'e' ,style: myTextStyle(ctx ,clr: Colors.red ,ratioSize: 22 ,family: 'Raleway')),
                      TextSpan(text: '  ?' ,style: myTextStyle(ctx ,clr: Colors.black87 ,ratioSize: 22 ,family: 'Raleway')),
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
