import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'enums.dart';
import '../models/article_models.dart';


// errorBox(context , {isEnterNet=false}){
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//       Icon(Icons.error_outline ,color: Colors.red,size: MediaQuery.textScaleFactorOf(context)*40,),
//       Text(isEnterNet==false ? 'Sorry, We cannot access servers' : 'check enternet and try again',
//         style: myTextStyle(context ,ratioSize: 20).copyWith(fontWeight: FontWeight.normal ,
//           shadows: [BoxShadow(blurRadius: 5 ,spreadRadius: 20,color: Colors.white)],
//         ),)
//     ],
//   );
// }

const String  aljazeeraImg = 'https://www.ifj.org/fileadmin/news_import/Al_Jazeera_newspaper.jpg';
const String  googleNewsImg = 'https://scontent-hbe1-1.xx.fbcdn.net/v/t1.15752-9/228446267_562171285154731_6015640014149527500_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=ae9488&_nc_ohc=pzl4ZRVOZPUAX9HJkmf&_nc_ht=scontent-hbe1-1.xx&oh=f35d1997effa8b7e61517603116351bf&oe=61290D4A';
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
    // if (connectivityResult == ConnectivityResult.mobile) return true;
    // else if (connectivityResult == ConnectivityResult.wifi) return true;
    // else return false;
    return connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi ;

}



newsCatToString(newsCat cat ,bool appearsTitle){
  switch(cat){
    case newsCat.all:
      return appearsTitle ?'Highlights' :'all';  break;
    case newsCat.Health:
      return 'Health';  break;
    case newsCat.Technology:
      return 'Technology';  break;
    case newsCat.Business:
      return 'Business';  break;
    case newsCat.Sports:
      return 'Sports';  break;
    case newsCat.Art:
      return 'Art';  break;
    case newsCat.Science_space:
      return appearsTitle ? 'Science and Space' :'Science_space';  break;
    case newsCat.Saved:
      return 'Saved';  break;
  }
}














