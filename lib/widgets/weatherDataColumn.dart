import 'package:flutter/material.dart';
import 'package:the_news/staticVariables.dart';

class WeatherDataColumn extends StatelessWidget {

  final String image ;
  final String title ;
  final String value ;
  final String unit ;
  final bool isEnglish ;
  final double sWidth ;
  Color imgColor ;
  Widget child;
  IconData clockIcon;
  String dayName;

  WeatherDataColumn({
    @required this.image,
    @required this.title,
    @required this.value,
    @required this.unit,
    @required this.isEnglish,
    @required this.sWidth,
    this.imgColor,
    this.child,
    this.clockIcon,
    this.dayName,
  });
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isEnglish ? TextDirection.ltr : TextDirection.ltr,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5 ,horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            clockIcon!=null ?
              Icon(clockIcon ,color: imgColor,size: sWidth*0.08)
            :
            image==null ? SizedBox()
              :
            Image.asset(image ,width: sWidth*0.1,color:imgColor,),

            child!=null ?
                child
            :
            Directionality(
              textDirection: isEnglish? TextDirection.ltr :TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    this.value ,
                    style: myTextStyle(context,).copyWith(fontWeight: FontWeight.w400),
                  ),
                  Text(
                    this.unit,
                    style: myTextStyle(context ,).copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),

            dayName!=null?
              Text(dayName ,style: myTextStyle(context ,).copyWith(fontWeight: FontWeight.w400),)
                :
            title==null ? SizedBox()
                :
            Text(
              this.title,
              style: myTextStyle(context ,).copyWith(fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class LocalTimeBox extends StatelessWidget {
  Widget child;
  LocalTimeBox(this.child);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: appColorPrimary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              shape: BoxShape.circle
            ),
            child: Icon(Icons.access_time),
          ),

          child ,

        ],
      ),
    );
  }
}
