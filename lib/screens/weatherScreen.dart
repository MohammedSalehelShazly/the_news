import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../languages.dart';
import '../models/weather_models.dart';
import '../providerReT.dart';
import '../services/newsServices.dart';
import '../services/weatherServices.dart';
import '../staticVariables.dart';
import '../widgets/weatherDataColumn.dart';

class WeatherScreen extends StatelessWidget {

  String country = 'Cairo';
  String country_ar = 'القاهرة';
  WeatherScreen(this.country,
      this.country_ar);


  sWidth(BuildContext cxt ,[ratio=1])=>MediaQuery.of(cxt).size.width*ratio;
  sHeight(BuildContext cxt ,[ratio=1])=>MediaQuery.of(cxt).size.height*ratio;
  
  @override
  Widget build(BuildContext context) {
    final provListen = Provider.of<MyProviderReT>(context);
    return SafeArea(
      child: Directionality(
        textDirection: provListen.isEnglish ? TextDirection.ltr : TextDirection.ltr,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/weather_BG.jpg'),
                    fit: BoxFit.cover
                  )
                ),
              ),


              FutureBuilder( 
                future: WeatherApi().fetchDataWeather(country),
                builder: (context ,AsyncSnapshot<WeatherModel> snapshot){
                  if(snapshot.hasData){
                    localTime24H = snapshot.data.location.localtime;
                    localTime = convertTo12Hour( localTime24H );
                    // Timer.periodic(Duration(milliseconds: 200), (timer) {http.get('http://api.weatherstack.com/current?access_key=74c370f0886841c7ac7b8b4f16864bcd&query=cairo');});
                  }
                  return snapshot.hasData ?
                      Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              ///snapshot.data.location.name,
                              provListen.isEnglish ? country : country_ar ,
                              style: myTextStyle(context ,ratioSize: provListen.isEnglish ?country.length>18?30:40  :country_ar.length>18?30:40 ,),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.data.current.temperature.toString(),
                                style: myTextStyle(context ,ratioSize: 45 ,).copyWith(fontWeight: FontWeight.normal),
                              ),
                              Text(
                                '°',
                                style: myTextStyle(context ,ratioSize: 35 ,),
                              ),
                              Text(
                                ' / ${weather_descriptionsTrans(provListen.isEnglish ,snapshot.data.current.weather_descriptions)}',
                                style: myTextStyle(context ,).copyWith(fontWeight: FontWeight.normal),
                              )
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LocalTimeBox(timeFormatting(context, localTime, localTime24H, provListen.isEnglish)),
                            ],
                          ),

                          Expanded(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: GridView(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(10),
                                physics: MediaQuery.of(context).orientation==Orientation.portrait ? NeverScrollableScrollPhysics() : BouncingScrollPhysics() ,
                                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 5/8,
                                  maxCrossAxisExtent: sWidth(context ,0.25)
                                ),
                                children: [
                                  InkWell(
                                    onTap:()=> NewsApi().launchURL( locationMethod(snapshot.data.location.lat ,snapshot.data.location.lon) ,false),
                                    child: WeatherDataColumn(
                                      isEnglish: provListen.isEnglish,
                                      sWidth: sWidth(context),
                                      imgColor: Colors.white,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.airplanemode_active ,color: Colors.white,),
                                          Icon(Icons.location_on ,color: Colors.red,),
                                        ],
                                      ),
                                      clockIcon: null,
                                      dayName: null,
                                    ),
                                  ),

                                  WeatherDataColumn(
                                    image: 'assets/images/ic_cloudsCover.png',
                                    title: Language().weatherTit(provListen.isEnglish, 1),
                                    value: snapshot.data.current.cloudcover.toString(),
                                    unit: Language().weatherTit(provListen.isEnglish, 9),
                                    isEnglish: provListen.isEnglish,
                                    sWidth: sWidth(context),
                                    imgColor: Colors.white,
                                  ),
                                  WeatherDataColumn(
                                    image: 'assets/images/ic_humidity.png',
                                    title: Language().weatherTit(provListen.isEnglish, 2),
                                    value: snapshot.data.current.humidity.toString(),
                                    unit: '%',
                                    isEnglish: provListen.isEnglish,
                                    sWidth: sWidth(context),
                                  ),
                                  WeatherDataColumn(
                                    image: 'assets/images/ic_pressure.png',
                                    title: Language().weatherTit(provListen.isEnglish, 3),
                                    value: snapshot.data.current.pressure.toString(),
                                    unit: Language().weatherTit(provListen.isEnglish, 10),
                                    isEnglish: provListen.isEnglish,
                                    sWidth: sWidth(context),
                                  ),
                                  WeatherDataColumn(
                                    image: 'assets/images/ic_uv-index.png',
                                    title: Language().weatherTit(provListen.isEnglish, 4),
                                    value: snapshot.data.current.uv_index.toString(),
                                    unit: '',
                                    isEnglish: provListen.isEnglish,
                                    sWidth: sWidth(context),
                                  ),
                                  WeatherDataColumn(
                                    image: 'assets/images/ic_visibility.png',
                                    title: Language().weatherTit(provListen.isEnglish, 5),
                                    value: snapshot.data.current.visibility.toString(),
                                    unit: Language().weatherTit(provListen.isEnglish, 11),
                                    isEnglish: provListen.isEnglish,
                                    sWidth: sWidth(context),
                                  ),
                                  WeatherDataColumn(
                                    image: 'assets/images/ic_wind_speed.png',
                                    title: Language().weatherTit(provListen.isEnglish, 6),
                                    value: snapshot.data.current.wind_speed.toString(),
                                    unit: Language().weatherTit(provListen.isEnglish, 12),
                                    isEnglish: provListen.isEnglish,
                                    sWidth: sWidth(context),
                                  ),WeatherDataColumn(
                                    image: 'assets/images/ic_windDegree.png',
                                    title: Language().weatherTit(provListen.isEnglish, 7),
                                    value: snapshot.data.current.wind_degree.toString(),
                                    unit: Language().weatherTit(provListen.isEnglish, 13),
                                    isEnglish: provListen.isEnglish,
                                    sWidth: sWidth(context),
                                  ),

                                ],
                              ),
                            ),
                          ),

                        ],
                      )
                      : Center(child: CupertinoActivityIndicator(),);
                       // : Center(child: RaisedButton(onPressed: ()=>NewsApi().launchURL('http://api.weatherstack.com/current?access_key=8ae4ec976e670b66078b4b421acd8a67&query=cairo'),),);

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  DateTime localTime;
  String localTime24H;

  convertTo12Hour(String timeStr){
    DateTime time = DateTime.parse(timeStr);
    return time.hour>12 ? time.subtract(Duration(hours:12) )
        :  time ;
  }

  timeFormatting(BuildContext ctx ,DateTime _localTime ,String _localTime24 ,bool isEng){
    return RichText(
      textDirection: isEng ? TextDirection.ltr :TextDirection.rtl,
      text: TextSpan(
          style: myTextStyle(ctx,).copyWith(fontWeight: FontWeight.w400),
          children: [
            TextSpan(
                text: '${nameOfDay(_localTime.weekday ,isEng)}  '
            ),


            isEng ? TextSpan(text: ''):
            TextSpan(
                text: '${_localTime.minute<10 ? '0'+_localTime.minute.toString() : _localTime.minute.toString()} : '
            ),
            TextSpan(
                text: '${_localTime.hour<10 ? '0'+_localTime.hour.toString() : _localTime.hour.toString()}'
            ),

            !isEng ? TextSpan(text: ''):
            TextSpan(text: ' : '),

            !isEng ? TextSpan(text: ''):
            TextSpan(
                text: '${_localTime.minute<10 ? '0'+_localTime.minute.toString() : _localTime.minute.toString()}'
            ),

            TextSpan(
                text:
                isEng ? '  ${DateTime.parse(_localTime24).hour>=12 ? 'pm' : 'am'}'
                    :
                '  ${DateTime.parse(_localTime24).hour>=12 ? 'م' : 'ص'}'

            ),
          ]
      ),
    );
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


  String weather_descriptionsTrans(isEng ,String weather_descriptions){
    if(isEng) return weather_descriptions;

    else{
      switch(weather_descriptions){
        case 'Sunny' : return 'مشمس'; break;
        case 'Smoke' : return 'دخان'; break;
        case 'Partly cloudy' : return 'غائم جزئيا'; break;
        case 'Mist' : return 'ضباب'; break;
        case 'Overcast' : return 'غائم'; break;
        case 'Light Rain, Rain' : return 'أمطار خفيفة ، مطر'; break;
        case 'Clear' : return 'واضح'; break;
        case 'Light Snow, Mist' : return 'ثلج خفيف ، ضباب'; break;
        case 'Thunderstorm' : return 'عاصفة رعدية'; break;
        case 'Fog In Vicinity' : return 'ضباب في الجوار'; break;
        case 'Light Rain With Thunderstorm' : return 'أمطار خفيفة مصحوبة بعاصفة رعدية'; break;
        case 'Patchy rain possible' : return 'أمطار متفرقة ممكنة'; break;
        default : return weather_descriptions;
      }
    }
  }
  String locationMethod(lat,lon) => 'https://www.google.com/maps/place/${double.parse(lat).toInt().toString()}%C2%B000\'22.1%22N+${double.parse(lon).toInt().toString()}%C2%B033\'59.6%22E/@$lat,$lon,17z/data=!3m1!4b1!4m5!3m4!1s0x0:0x0!8m2!3d$lat!4d$lon';


}
