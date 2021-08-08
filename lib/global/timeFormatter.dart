import 'package:flutter/material.dart';

class TimeFormatter extends StatelessWidget {

  final DateTime localTime24 ;
  final bool isEng;

  TimeFormatter({
    @required this.localTime24,
    @required this.isEng
  });


   String addZero(int num)=>
       '${num<10 ? '0'+'$num' : '$num'}';

   String timeMidday(time24 ,bool isEng) =>
       isEng ?  time24.hour>=12 ? ' pm' : ' am'
           :
       time24.hour>=12 ? ' م' : ' ص';

    DateTime to12Hour(DateTime time){
      return time.hour>12 ? time.subtract(Duration(hours:12) )
          :  time ;
    }

    String nameOfDay(int day ,bool isEng){
      if(isEng){
        switch(day){
          case 1 : return 'Monday'; break;
          case 2 : return 'Tuesday'; break;
          case 3 : return 'Wednesday'; break;
          case 4 : return 'Thursday'; break;
          case 5 : return 'Friday'; break;
          case 6 : return 'Saturday'; break;
          case 7 : return 'Sunday'; break;
          default : return' ';
        }
      }else{
        switch(day){
          case 1 : return 'الأثنين'; break;
          case 2 : return 'الثلاثاء'; break;
          case 3 : return 'الأربعاء'; break;
          case 4 : return 'الخميس'; break;
          case 5 : return 'الجمعه'; break;
          case 6 : return 'السبت'; break;
          case 7 : return 'الأحد'; break;
          default : return' ';
        }
      }
    }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: nameOfDay(localTime24.day, isEng) +' '),

          if(isEng)
            TextSpan(text: addZero(to12Hour(localTime24).hour) + ' : '),
          TextSpan(text: addZero(to12Hour(localTime24).minute) + ' '),

          if(!isEng)
            TextSpan(text: ' : '),
          if(!isEng)
            TextSpan(text: addZero(to12Hour(localTime24).hour) + ''),

          TextSpan(text: timeMidday(localTime24 ,isEng) +' '),
        ]
      ),
    );

  }
}