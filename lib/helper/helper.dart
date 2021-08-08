

import 'package:url_launcher/url_launcher.dart';

Future launchURL(String siteUrl ,[wantToForceWebView=true]) async{
  if (await canLaunch(siteUrl)) {
    await launch(
      siteUrl,
      forceWebView: wantToForceWebView,
      enableJavaScript: wantToForceWebView,
    );
  } else{
    throw 'Could not launch $siteUrl';
  }
}