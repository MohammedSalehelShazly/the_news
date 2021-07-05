import 'dart:convert';

import '../models/weather_models.dart';
import 'package:http/http.dart' as http;

class WeatherApi{
  static String weatherKey = '25b3da6649d0002c5702c50b3470ca33'; // from second mail
  static String weatherKeySec = '8ae4ec976e670b66078b4b421acd8a67';  // from mail ma7madsalle7@gmail.com
  
  Future<WeatherModel> fetchDataWeather(String country) async{
    
    Map<String ,dynamic> jsonData;
    try{ // http://api.weatherstack.com/current?access_key=25b3da6649d0002c5702c50b3470ca33&query=cairo
      http.Response response = await http.get('http://api.weatherstack.com/current?access_key=$weatherKey&query=$country');
      if(response.statusCode==200){
        jsonData = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(jsonData);
        return weatherModel;
      }
    }catch(ex){

      try{
        http.Response response = await http.get('http://api.weatherstack.com/current?access_key=$weatherKeySec&query=$country');
        if(response.statusCode==200){
          jsonData = jsonDecode(response.body);
          WeatherModel weatherModel = WeatherModel.fromJson(jsonData);
          return weatherModel;
        }
        }catch(exFrom2){print('222.........$exFrom2');}

      print('111.........$ex');
    }
  }
}
