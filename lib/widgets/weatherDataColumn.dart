import 'package:flutter/material.dart';
import '../global/staticVariables.dart';
import 'package:provider/provider.dart';
import '../global/responsive.dart';
import '../services/providers/themeProv.dart';

class WeatherDataColumn extends StatelessWidget {

  final String image ;
  final String title ;
  final String value ;
  final String unit ;
  Color imgColor ;
  Widget child;
  IconData clockIcon;
  String dayName;

  WeatherDataColumn({
    @required this.image,
    @required this.title,
    @required this.value,
    @required this.unit,
    this.imgColor,
    this.child,
    this.clockIcon,
    this.dayName,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5 ,horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.35),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          clockIcon!=null ?
            Icon(clockIcon ,color: imgColor,size: responsive.sWidth(context)*0.08)
          :
          image==null ? SizedBox()
            :
          Image.asset(image ,width: responsive.sWidth(context)*0.1,color:imgColor,),

          child!=null ?
              child
          :
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                this.value ,
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              Text(
                this.unit,
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ],
          ),

          dayName!=null?
            Text(dayName ,style: TextStyle(fontWeight: FontWeight.w400),)
              :
          title==null ? SizedBox()
              :
          Text(
            this.title,
            style: TextStyle(fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
