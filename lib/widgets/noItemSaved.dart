import 'package:flutter/material.dart';
import 'package:the_news/global/responsive.dart';
import '../localization/language_constants.dart';
import '../global/staticVariables.dart';

class NoItemSaved extends StatelessWidget{

  final bool isEng;
  final BuildContext ctx;
  final double sWidth;
 NoItemSaved({
   @required this.isEng,
   @required this.ctx,
   @required this.sWidth,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: sWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: sWidth *0.8,
            height: sWidth *0.6,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/empty_cart.png"), fit: BoxFit.contain)
            )
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(getTranslated(context, 'No News Saved'),
               style: TextStyle(fontSize: responsive.textScale(context) *25),),
            ),
        ],
        ),
   );
  }
  
}