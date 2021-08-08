import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../global/appClrs.dart';
import '../global/responsive.dart';
import '../localization/language_constants.dart';

class AppDialog extends StatelessWidget {
  final BuildContext ctx ;
  final String contentTxt;
  final Function func;
  final String secondActTxt;

  const AppDialog({
    @required this.ctx,
    @required this.contentTxt,
    @required this.func,
    @required this.secondActTxt,

  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Padding(
        padding: EdgeInsets.all(10),
        child: Text(contentTxt ,
          softWrap: true,
          style: TextStyle(
              fontFamily: appClrs.mainFontFamily ,
              fontWeight: FontWeight.w500,
              fontSize: responsive.textScale(context)*18),
        ),
        ),
      //insetAnimationDuration: Duration(seconds: 1),
      actions: [
        CupertinoButton(
          child: Text(
            getTranslated(context, 'Cancel'),
            style: TextStyle(fontFamily: appClrs.mainFontFamily),),
          onPressed: (){
            Navigator.pop(ctx);
          },
        ),
        CupertinoButton(
          child: Text(
            secondActTxt,
            style: TextStyle(color: Colors.red ,fontFamily: appClrs.mainFontFamily),),
          onPressed: () {
            func();
            Navigator.pop(ctx);
          },
        ),
      ],
    );
  }
}