
import 'package:flutter/cupertino.dart';

class WeatherModel{
  final Request request ;
  final Location location ;
  final Current current ;

  WeatherModel({
    @required this.request,
    @required this.location,
    @required this.current
  });

  factory WeatherModel.fromJson(Map<String ,dynamic> jsonData)=>
    WeatherModel(
      request: Request.fromJson(jsonData['request']),
      location: Location.fromJson(jsonData['location']),
      current: Current.fromJson(jsonData['current']),
  );
}


class Request{
  final String query ;

  Request({
    @required this.query,
  });

  factory Request.fromJson(Map<String ,dynamic> jsonData)=>
      Request(
        query: jsonData['query'],
      );
}

class Location{
  final String name ;
  final String lat ;
  final String lon ;
  final String localtime ;


  Location({
    @required this.name,
    @required this.lat,
    @required this.lon,
    @required this.localtime,

  });

  factory Location.fromJson(Map<String ,dynamic> jsonData)=>
      Location(
        name: jsonData['name'],
        lat: jsonData['lat'],
        lon: jsonData['lon'],
        localtime: jsonData['localtime'],

      );
}

class Current{
  final int temperature ;
  final String weather_icons ;
  final String weather_descriptions ;
  final int wind_speed;
  final int wind_degree;
  final int pressure;
  final int humidity;
  final int cloudcover;
  final int feelslike;
  final int uv_index;
  final int visibility;

  Current({
    @required this.temperature,
    @required this.weather_icons,
    @required this.weather_descriptions,
    @required this.wind_speed,
    @required this.wind_degree,
    @required this.pressure,
    @required this.humidity,
    @required this.cloudcover,
    @required this.feelslike,
    @required this.uv_index,
    @required this.visibility
  });

  factory Current.fromJson(Map<String ,dynamic> jsonData)=>
      Current(
        temperature: jsonData['temperature'],
        weather_icons: jsonData['weather_icons'][0],
        weather_descriptions: jsonData['weather_descriptions'][0],
        wind_speed: jsonData['wind_speed'],
        wind_degree: jsonData['wind_degree'],
        pressure: jsonData['pressure'],
        humidity: jsonData['humidity'],
        cloudcover: jsonData['cloudcover'],
        feelslike: jsonData['feelslike'],
        uv_index: jsonData['uv_index'],
        visibility: jsonData['visibility'],
      );
}

/*
{
"request": {
  "query": "Cairo, Egypt",
},
"location": {
  "name": "Cairo",
  "lat": "30.050",
  "lon": "31.250",
  "localtime": "2021-01-27 20:29",
},
"current": {
  "temperature": 17,
  "weather_icons": [ "https://assets.weatherstack.com/images/wsymbols01_png_64/wsymbol_0001_sunny.png" ],
  "weather_descriptions": ["Sunny"],
  "wind_speed": 22,
  "wind_degree": 310,
  //"pressure": 1015,
  "humidity": 63,
  //"cloudcover": 0,
  //"feelslike": 17,
  //"uv_index": 6,
  //"visibility": 10,
 }
}
* */