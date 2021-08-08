import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../data/countries.dart';
import '../global/removeExtinctionsAtWord.dart';
import '../localization/language_constants.dart';

import '../models/weather_models.dart';
import 'package:http/http.dart' as http;

class WeatherService with ChangeNotifier{

  WeatherModel weatherModel;
  setWeatherModel(WeatherModel _weatherModel){
    weatherModel = _weatherModel;
    notifyListeners();
  }

  static String weatherKey = '25b3da6649d0002c5702c50b3470ca33'; // from second mail
  static String weatherKeySec = '8ae4ec976e670b66078b4b421acd8a67';  // from mail ma7madsalle7@gmail.com
  
  Future<void> fetchDataWeather(String country) async{
    
    Map<String ,dynamic> jsonData;
    try{ // http://api.weatherstack.com/current?access_key=25b3da6649d0002c5702c50b3470ca33&query=cairo
      http.Response response = await http.get('http://api.weatherstack.com/current?access_key=$weatherKey&query=$country');
      if(response.statusCode==200){
        jsonData = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(jsonData);
        setWeatherModel(weatherModel);
      }
    }catch(ex){

      try{
        http.Response response = await http.get('http://api.weatherstack.com/current?access_key=$weatherKeySec&query=$country');
        if(response.statusCode==200){
          jsonData = jsonDecode(response.body);
          WeatherModel weatherModel = WeatherModel.fromJson(jsonData);
          setWeatherModel(weatherModel);
        }
        }catch(exFrom2){print('222.........$exFrom2');}

      print('111.........$ex');
    }
  }


  List<String> searchResult = [];
  clearSearchResult(){
    searchResult = [];
    notifyListeners();
  }
  RemoveExtinctionsAtWord removeExtinctionsAtWord = RemoveExtinctionsAtWord();

  searchCountry(BuildContext context ,String _currentInput ,bool isEng){
    clearSearchResult();
    String element;
    for(int i=0 ;i<governorates_countries.length ;i++){
      element = isEng ?governorates_countries[i] :getTranslated(context, governorates_countries[i] );
      if(removeExtinctionsAtWord.normalise(element.toLowerCase()).contains( removeExtinctionsAtWord.normalise(_currentInput.toLowerCase())) ){
        searchResult.add(element);
        notifyListeners();
      }
    }
  }


}



var fackData = {
  "request": {
    "type": "City",
    "query": "Cairo, Egypt",
    "language": "en",
    "unit": "m"
  },
  "location": {
    "name": "Cairo",
    "country": "Egypt",
    "region": "Al Qahirah",
    "lat": "30.050",
    "lon": "31.250",
    "timezone_id": "Africa/Cairo",
    "localtime": "2021-08-01 17:04",
    "localtime_epoch": 1627837440,
    "utc_offset": "2.0"
  },
  "current": {
    "observation_time": "03:04 PM",
    "temperature": 38,
    "weather_code": 113,
    "weather_icons": [
      "https://assets.weatherstack.com/images/wsymbols01_png_64/wsymbol_0001_sunny.png"
    ],
    "weather_descriptions": [
      "Sunny"
    ],
    "wind_speed": 13,
    "wind_degree": 330,
    "wind_dir": "NNW",
    "pressure": 1004,
    "precip": 0,
    "humidity": 29,
    "cloudcover": 0,
    "feelslike": 37,
    "uv_index": 10,
    "visibility": 10,
    "is_day": "yes"
  }
};