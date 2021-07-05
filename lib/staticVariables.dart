import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/article_models.dart';

Color appColorPrimary = Color(0xFF295980);
Color appColorAccent = appColorPrimary.withOpacity(0.3);
Map<int, Color> clr = {
    50:Color.fromRGBO(41,89,128, 1),
    100:Color.fromRGBO(41,89,128, 1),
    200:Color.fromRGBO(41,89,128, 1),
    300:Color.fromRGBO(41,89,128, 1),
    400:Color.fromRGBO(41,89,128, 1),
    500:Color.fromRGBO(41,89,128, 1),
    600:Color.fromRGBO(41,89,128, 1),
    700:Color.fromRGBO(41,89,128, 1),
    800:Color.fromRGBO(41,89,128, 1),
    900:Color.fromRGBO(41,89,128, 1),
};
MaterialColor appColorPrimaryMaterialClr = MaterialColor(0xFF295980, clr);


TextStyle myTextStyle(myContext ,{Color clr = Colors.white , int ratioSize=14 , bool wantShadow=false , family = 'cairo'})=> TextStyle(
    fontSize: MediaQuery.textScaleFactorOf(myContext)*ratioSize ,
    color: clr,
    fontFamily: family,
    shadows: wantShadow? [Shadow(blurRadius: 10 , color: clr==Colors.black ? Colors.yellow[700] : Colors.black)] : null,
    fontWeight: FontWeight.bold
);

errorBox(context , {isEnterNet=false}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(Icons.error_outline ,color: Colors.red,size: MediaQuery.textScaleFactorOf(context)*40,),
      Text(isEnterNet==false ? 'Sorry, We cannot access servers' : 'check enternet and try again',
        style: myTextStyle(context ,ratioSize: 20).copyWith(fontWeight: FontWeight.normal ,
          shadows: [BoxShadow(blurRadius: 5 ,spreadRadius: 20,color: Colors.white)],
        ),)
    ],
  );
}

const String  aljazeeraImg = 'https://www.ifj.org/fileadmin/news_import/Al_Jazeera_newspaper.jpg';
const String  googleNewsImg = 'https://1.bp.blogspot.com/-_2vlLuCWuus/XS0oOMCgk1I/AAAAAAAAQwM/EL-qB9NkZ04Iu5VWMOxHf4vnxTN7LlIyQCLcBGAs/s1600/google-news.jpg';
const String  errorImg = 'https://scontent.xx.fbcdn.net/v/t1.15752-0/p206x206/142479359_477519313236996_8348429448288179536_n.png?_nc_cat=110&ccb=2&_nc_sid=58c789&_nc_ohc=X4pLhzmroSkAX-QkO4B&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&_nc_tp=30&oh=07e609ce79c68f71c8a9cb13e6f75dae&oe=60362510';

textIsEnglish(String txt)=>
    ( txt.codeUnitAt(0) >=65 && txt.codeUnitAt(0) <=122
      || txt.codeUnitAt(1) >=65 && txt.codeUnitAt(1) <=122
      || txt.codeUnitAt(2) >=65 && txt.codeUnitAt(2) <=122 
    );

List<Article> listOfMapToSet(List theList){
  assert(theList!=null);
  assert(theList.length>=2);
  for(int cnt=0 ;cnt<3 ;cnt++){
    for(int i=0 ;i<theList.length ;i++){
      for(int j=1 ;j<theList.length ;j++){
        if(i!=j){
          if(theList[i].title == theList[j].title){
            theList.remove(theList[j]);
          }
        }
      }
    }
  }
  return theList;
}

Future<bool> internetConnected()async {
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) return true;
    else if (connectivityResult == ConnectivityResult.wifi) return true;
    else return false;
}
