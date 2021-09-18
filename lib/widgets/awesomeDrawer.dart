import 'package:flutter/material.dart';
import '../global/responsive.dart';

/// note..
// Don't forget =>   you can control on border with padding only

class AwesomeDrawer extends StatelessWidget {

  Widget child;
  bool endDrawer; /// its mean drawer is from right
  double borderWidth;
  Color borderClr;
  Color bgClr;
  Radius radius;

  AwesomeDrawer({
    @required this.child,
    @required this.endDrawer,
    this.borderWidth =3,
    this.borderClr,
    this.bgClr,
    this.radius = const Radius.circular(50)
  });

  Radius _zeroRadius = Radius.zero;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: responsive.sHeight(context)*0.5,
        width: responsive.sWidth(context)*0.7,
        child: Container(
            padding:
            endDrawer
                ? EdgeInsets.fromLTRB(borderWidth,borderWidth, 0 ,borderWidth)
                : EdgeInsets.fromLTRB(0 ,borderWidth,borderWidth,borderWidth),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                right: endDrawer? _zeroRadius :radius,
                left: endDrawer? radius :_zeroRadius,
              ),
              color: borderClr ??Theme.of(context).textTheme.subtitle2.color,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  right: endDrawer? _zeroRadius :radius,
                  left: endDrawer? radius :_zeroRadius,
                ),
                color: bgClr ?? Theme.of(context).scaffoldBackgroundColor.withOpacity(.8),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: responsive.sHeight(context),width: responsive.sWidth(context),
                  ),

                  this.child

                ],
              ),
            )),
      ),
    );
  }
}
