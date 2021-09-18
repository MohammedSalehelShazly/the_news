import 'package:flutter/material.dart';

import '../global/responsive.dart';

class WeatherDataColumn extends StatelessWidget {

  final String image ;
  final String title ;
  final String value ;
  final String unit ;
  Color imgColor ;
  Widget child;

  WeatherDataColumn({
    @required this.image,
    @required this.title,
    @required this.value,
    @required this.unit,
    this.imgColor,
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5 ,horizontal: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.35),
        borderRadius: BorderRadius.circular(15)
      ),
      child:
      this.child ??

      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          if(image != null)
            Image.asset(image ,width: responsive.sWidth(context)*0.1,color:imgColor,),

          FittedBox(
            child: Row(
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
          ),

          FittedBox(
            child: Text(
              this.title ??'' ,
              style: TextStyle(
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          )

        ],
      ),
    );
  }
}
