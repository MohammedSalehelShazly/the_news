import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_news/staticVariables.dart';

import '../languages.dart';

class AppDialog extends StatelessWidget {
  final BuildContext ctx ;
  final String contentTxt;
  final bool isEnglish;
  final Function func;
  final String secondActTxt;

  const AppDialog({
    @required this.ctx,
    @required this.contentTxt,
    @required this.isEnglish,
    @required this.func,
    @required this.secondActTxt,

  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Padding(
        padding: EdgeInsets.all(10),
        child: Text(contentTxt ,style: myTextStyle(ctx ,clr:Colors.black87 ,ratioSize: 15),softWrap: true,),
        ),
      insetAnimationDuration: Duration(seconds: 1),
      actions: [
        CupertinoButton(
          child: Text(Language().dialogTit(isEnglish ,0) ,
              style: myTextStyle(ctx ,clr: Colors.black87 ,ratioSize: 16),
            ),
          onPressed: (){
            Navigator.pop(ctx);
          },
        ),
        CupertinoButton(
          child: Text(secondActTxt
              ,style: myTextStyle(ctx ,clr: Colors.red ,ratioSize: 16),),
          onPressed: () {
            func();
            Navigator.pop(ctx);
          },
        ),
      ],
    );
  }
}