
import 'enums.dart';
import '../models/article_models.dart';

import 'package:connectivity/connectivity.dart';

const String  aljazeeraImg = 'https://www.ifj.org/fileadmin/news_import/Al_Jazeera_newspaper.jpg';
const String  googleNewsImg = 'https://1.bp.blogspot.com/-_2vlLuCWuus/XS0oOMCgk1I/AAAAAAAAQwM/EL-qB9NkZ04Iu5VWMOxHf4vnxTN7LlIyQCLcBGAs/s1600/google-news.jpg';
const String  errorImg = 'https://www.generationsforpeace.org/wp-content/uploads/2018/07/empty-300x240.jpg';

String locationMethod(String lat,String lon) => 'https://www.google.com/maps/place/${double.parse(lat).toInt().toString()}%C2%B000\'22.1%22N+${double.parse(lon).toInt().toString()}%C2%B033\'59.6%22E/@$lat,$lon,17z/data=!3m1!4b1!4m5!3m4!1s0x0:0x0!8m2!3d$lat!4d$lon';

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
  }
}
