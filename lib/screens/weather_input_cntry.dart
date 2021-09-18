import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:provider/provider.dart';
import '../global/responsive.dart';
import '../services/providers/settingsProv.dart';

import '../localization/language_constants.dart';
import '../services/weatherServices.dart';
import '../screens/weatherScreen.dart';
import '../data/countries.dart';
import '../services/providers/mainProvider.dart';
import '../global/staticVariables.dart';

class Weather_input_cntry extends StatefulWidget {

  @override
  _Weather_input_cntryState createState() => _Weather_input_cntryState();
}

class _Weather_input_cntryState extends State<Weather_input_cntry> {


  var formKey = GlobalKey<FormState>();
  String country ;

  WeatherService weatherServiceWrite;
  WeatherService weatherService;
  SettingsProv settingsProv;
  bool first = true;

  @override
  Widget build(BuildContext context) {
    if(first){
      weatherService =Provider.of<WeatherService>(context);
      weatherServiceWrite =Provider.of<WeatherService>(context ,listen: false);
      settingsProv = Provider.of<SettingsProv>(context);
      first = false;
    }
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[

            if(weatherService.searchResult.isEmpty)
              Opacity(
                opacity: 0.7,
                child: Center(
                  child: SvgPicture.asset(
                      'assets/images/searchImg.svg',
                      semanticsLabel: 'search'
                  ),
                ),
              ),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(height: responsive.sHeight(context)*0.08 ,width: MediaQuery.of(context).size.width),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    textInputAction: TextInputAction.search,
                    autofocus: true,
                    onChanged: (value){
                      weatherServiceWrite.searchCountry(context ,value ,settingsProv.appLang=='en');
                    },
                    decoration: InputDecoration(
                        hintText: getTranslated(context, 'Enter Countery Name'),
                        filled: true,
                        prefixIcon: Icon(Icons.search,color: Colors.black87,),
                        suffixIcon: IconButton(
                          onPressed: (){
                            WidgetsBinding.instance.addPostFrameCallback((_) => formKey.currentState.reset());
                            weatherServiceWrite.clearSearchResult();
                          },
                          icon: Icon(Icons.cancel ,color: Colors.black26,),
                        )
                    ),

                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: weatherService.searchResult.length,
                itemExtent: responsive.countryListTileHigh(context),
                itemBuilder: (context ,index) =>
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.search ,),
                        title: Text(
                            weatherService.searchResult[index]),
                        onTap: (){
                          weatherServiceWrite.fetchDataWeather(country);
                          Navigator.push(context, CupertinoPageRoute(
                            builder: (context)=>WeatherScreen(
                              weatherService.searchResult[index],
                            ),
                          ));
                          },
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
