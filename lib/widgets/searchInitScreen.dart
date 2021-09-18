import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../global/responsive.dart';
import '../localization/language_constants.dart';
import '../services/providers/themeProv.dart';

class SearchInitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: responsive.sWidth(context),
      height: responsive.sHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: responsive.responsiveHigh(context, 0.05),),

          Text(
            getTranslated(context, 'Enter a few words to search in news'),
            style: TextStyle(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: responsive.responsiveHigh(context, 0.01),),

          Consumer<ThemeProv>(
            builder:(_,prov, __)=> CircleAvatar(
              backgroundColor: prov.mainClr(),
              radius: responsive.textScale(context)*45,
              child: Icon(Icons.search ,color: Colors.white,size: responsive.textScale(context)*73),
            ),
          ),

        ],
      ),
    );
  }
}
