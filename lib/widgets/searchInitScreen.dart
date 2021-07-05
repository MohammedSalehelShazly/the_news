import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../languages.dart';
import '../providerReT.dart';
import '../staticVariables.dart';

class SearchInitScreen extends StatelessWidget {
  final double topPadding;
  final double sWidth;
  final BuildContext ctx ;

  SearchInitScreen(this.ctx ,{@required this.topPadding ,@required this.sWidth});
  @override
  Widget build(BuildContext context) {
    final provListen = Provider.of<MyProviderReT>(context);
    return Container(
      width: sWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: topPadding*1.2,),
          Text(
            Language().searchTit(provListen.isEnglish ,2),
            style: myTextStyle(ctx ,clr: Colors.black ,ratioSize: 18).copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: topPadding*0.3,),
          CircleAvatar(
            backgroundColor: appColorPrimary,
            radius: MediaQuery.textScaleFactorOf(ctx)*45,
            child: Icon(Icons.search ,color: Colors.white,size: MediaQuery.textScaleFactorOf(ctx)*73),
          ),

        ],
      ),
    );
  }
}
