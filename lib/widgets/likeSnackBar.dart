
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LikeSnackBar extends StatelessWidget {

  BuildContext sContext;
  Widget child ;
  bool appear ;
  Widget sContent;
  Color sColor ;

  LikeSnackBar(this.sContext,this.appear,
      {
        @required this.child,
        this.sContent ,
        this.sColor  = Colors.grey ,
      });

  Duration duration = Duration(seconds: 2);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appear==true? Colors.black26 :null,
      child: Stack(
        children: [
          child,

          appear==true ? Center(
            child: Transform.translate(
              offset: Offset(0 ,MediaQuery.of(sContext).size.height*0.2),
              child: Container(
                padding: EdgeInsets.all(8),
                child: sContent,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: sColor,
                ),
              ),
            ),
          )
              :SizedBox(),

        ],
      ),
    );
  }
}

