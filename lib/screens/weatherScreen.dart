
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../services/providers/settingsProv.dart';
import '../global/responsive.dart';
import '../global/timeFormatter.dart';
import '../localization/language_constants.dart';
import '../widgets/timeBox.dart';
import '../helper/launchHelper.dart';

import '../models/weather_models.dart';
import '../services/providers/mainProvider.dart';
import '../services/weatherServices.dart';
import '../global/staticVariables.dart';
import '../widgets/weatherDataColumn.dart';

class WeatherScreen extends StatelessWidget {

  String country = 'Cairo';
  WeatherScreen(this.country);

  SettingsProv settingsProv;
  WeatherService weatherService;
  bool first = true;
  
  @override
  Widget build(BuildContext context) {
    if(first){
      first = false;
      settingsProv = Provider.of<SettingsProv>(context);
      weatherService =Provider.of<WeatherService>(context);
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: responsive.responsiveHigh(context, 1),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/weather_BG.jpg'),
                  fit: BoxFit.cover
                )
              ),
            ),



            weatherService.weatherModel==null ?
            Center(child: CupertinoActivityIndicator(),)
                :
            SingleChildScrollView(
              child: Container(
                height: responsive.responsiveHigh(context ,1)-responsive.topPadding(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      alignment: Alignment.center,
                      child: Text(
                        ///weatherService.weatherModel.location.name,
                        country,//getTranslated(context, country),
                        style: TextStyle(
                            fontSize: settingsProv.appLang=='en' ?  responsive.textScale(context)* getTranslated(context, country).length>18? 30:40 :40 ,
                            color: Colors.white),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          weatherService.weatherModel.current.temperature.toString(),
                          style: TextStyle(fontSize: responsive.textScale(context)*40),
                        ),
                        Text(
                          '°',
                          style: TextStyle(fontSize: responsive.textScale(context)*40),
                        ),
                        Text(
                          ' / ${getTranslated(context, weatherService.weatherModel.current.weather_descriptions) ??
                              weatherService.weatherModel.current.weather_descriptions}',
                        )
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TimeBox(
                            TimeFormatter(
                                localTime24 : DateTime.parse(weatherService.weatherModel.location.localtime), // localTime
                                isEng: settingsProv.appLang=='en'
                            )),
                      ],
                    ),

                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        constraints: BoxConstraints.expand(height: responsive.responsiveHigh(context ,.5)),
                        child: GridView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(10),
                          physics:  NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: 5/8,
                              maxCrossAxisExtent: responsive.responsiveWidth(context ,.25)
                          ),
                          children: [
                            InkWell(
                                onTap:()=> LaunchHelper().launchURL( locationMethod(weatherService.weatherModel.location.lat ,weatherService.weatherModel.location.lon) ,false),
                                child: WeatherDataColumn(
                                  value: null, title: null, image: null, unit: null,
                                  imgColor: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.airplanemode_active ,color: Colors.white,),
                                      Icon(Icons.location_on ,color: Colors.red,),
                                    ],
                                  ),
                                ),
                              ),

                            WeatherDataColumn(
                              image: 'assets/images/ic_cloudsCover.png',
                              title: getTranslated(context, 'Clouds Cover'),
                              value: weatherService.weatherModel.current.cloudcover.toString(),
                              unit: getTranslated(context, 'oktas'),
                              imgColor: Colors.white,
                            ),
                            WeatherDataColumn(
                              image: 'assets/images/ic_humidity.png',
                              title: getTranslated(context, 'Humidity'),
                              value: weatherService.weatherModel.current.humidity.toString(),
                              unit: '%',
                            ),
                            WeatherDataColumn(
                              image: 'assets/images/ic_pressure.png',
                              title: getTranslated(context, 'Pressure'),
                              value: weatherService.weatherModel.current.pressure.toString(),
                              unit: getTranslated(context, 'pascal'),
                            ),
                            WeatherDataColumn(
                              image: 'assets/images/ic_uv-index.png',
                              title: getTranslated(context, 'Uv-Index'),
                              value: weatherService.weatherModel.current.uv_index.toString(),
                              unit: '',
                            ),
                            WeatherDataColumn(
                              image: 'assets/images/ic_visibility.png',
                              title: getTranslated(context, 'Visibility'),
                              value: weatherService.weatherModel.current.visibility.toString(),
                              unit: getTranslated(context, 'm'),
                            ),
                            WeatherDataColumn(
                              image: 'assets/images/ic_wind_speed.png',
                              title: getTranslated(context, 'Wind Speed'),
                              value: weatherService.weatherModel.current.wind_speed.toString(),
                              unit: getTranslated(context, 'km/s'),
                            ),
                            WeatherDataColumn(
                              image: 'assets/images/ic_windDegree.png',
                              title: getTranslated(context, 'Wind Degree'),
                              value: weatherService.weatherModel.current.wind_degree.toString(),
                              unit: getTranslated(context, 'm/h'),
                            ),

                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }


}
