

import 'package:url_launcher/url_launcher.dart';

class LaunchHelper{
  Future launchURL(String siteUrl ,[wantToForceWebView=true]) async{
    try{
      await launch(
        siteUrl,
        forceWebView: wantToForceWebView,
        enableJavaScript: wantToForceWebView,
      );

    }on Exception catch(e){
      print('siteUrl $siteUrl');
      throw 'Exception... $e';
    }
  }
}
