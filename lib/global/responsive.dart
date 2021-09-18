import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Responsive responsive = Responsive();

class Responsive{

    MediaQueryData mediaQuery(BuildContext context)=> MediaQuery.of(context);
    double textScale(BuildContext context)=> MediaQuery.textScaleFactorOf(context);
    double sHeight(BuildContext context)=> mediaQuery(context).size.height;
    double sWidth(BuildContext context)=> mediaQuery(context).size.width;


    bool isPortrait(BuildContext context)
        => (
            sHeight(context) > sWidth(context)
            || mediaQuery(context).orientation == Orientation.portrait
        );


    double responsiveHigh (BuildContext context ,double ratio){
        return isPortrait(context) ? sHeight(context) *ratio
            : sWidth(context) *ratio;
    }

    double responsiveWidth (BuildContext context ,double ratio){
        return isPortrait(context) ? sWidth(context) *ratio
            : sHeight(context) *ratio;
    }

    double mainScreenBtnWidth(BuildContext context)
            => sWidth(context) *0.43;


    double appbarTopHigh(AppBar appBar ,BuildContext context)
            => appBar.preferredSize.height + mediaQuery(context).padding.top;

    double countryListTileHigh(BuildContext context){
        return isPortrait(context) ? sHeight(context) /11
            : sWidth(context) /13;
    }

    double topPadding(BuildContext context)=>
        mediaQuery(context).padding.top;


}
