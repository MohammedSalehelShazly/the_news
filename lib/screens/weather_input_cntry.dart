import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../screens/weatherScreen.dart';
import '../countries.dart';
import '../languages.dart';
import '../providerReT.dart';
import '../staticVariables.dart';

class Weather_input_cntry extends StatefulWidget {

  @override
  _Weather_input_cntryState createState() => _Weather_input_cntryState();
}

class _Weather_input_cntryState extends State<Weather_input_cntry> {


  var formKey = GlobalKey<FormState>();
  String country ;
  String country_ar ;

  String currentInput ;


  List<String> hasSearch =[];
  List<String> hasSearch_ar =[];
  findSearch(String _currentInput){
    for(int i=0 ;i<governorates_countries_ar.length ;i++){
      if(governorates_countries_ar[i].contains(_currentInput[0].toUpperCase() + _currentInput.substring(1))  ||  governorates_countries[i].contains(_currentInput[0].toUpperCase() + _currentInput.substring(1))){
        setState(() {
          hasSearch.add(governorates_countries[i]);
          hasSearch = hasSearch.toSet().toList();

          hasSearch_ar.add(governorates_countries_ar[i]);
          hasSearch_ar = hasSearch_ar.toSet().toList();
        });
      }
      else {
        setState(() {
          hasSearch.remove(governorates_countries[i]);
          hasSearch = hasSearch.toSet().toList();


          hasSearch_ar.remove(governorates_countries_ar[i]);
          hasSearch_ar = hasSearch_ar.toSet().toList();
        });
      }
    }
  }
  Language lang = Language();

  @override
  Widget build(BuildContext context) {
    final provListen = Provider.of<MyProviderReT>(context);
    return SafeArea(
      child: Directionality(
        textDirection: provListen.isEnglish?TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          body: Stack(
            children: <Widget>[

              Center(child: Opacity(opacity: 0.3 ,child: Image.asset('assets/images/search.png'))), ///do this CashedNetWorkImage but non background because make dark them

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: MediaQuery.of(context).size.height*0.08 ,width: MediaQuery.of(context).size.width),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      textDirection: provListen.isEnglish?TextDirection.ltr : TextDirection.rtl,
                      textInputAction: TextInputAction.search,
                      autofocus: true,
                      onChanged: (value){
                        setState(() {
                          currentInput = value ;
                          findSearch(value);
                        });
                      },
                      decoration: InputDecoration(
                          hintText: lang.weatherTit(provListen.isEnglish, 0),
                          hintStyle: myTextStyle(context ,clr: Colors.black54 ,family: 'Cairo'),
                          filled: true,
                          prefixIcon: Icon(Icons.search,color: Colors.black87,),
                          suffixIcon: IconButton(
                            onPressed: (){
                              WidgetsBinding.instance.addPostFrameCallback((_) => formKey.currentState.reset());
                            },
                            icon: Icon(Icons.cancel ,color: Colors.black26,),
                          )
                      ),

                    ),
                  ),
                ),
              ),

              Transform.translate(
                offset: Offset(0 ,MediaQuery.of(context).size.height*0.08),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: List.generate(hasSearch.length, (index) => Card(
                    color: Colors.white54,
                    child: ListTile(
                      leading: Icon(Icons.search ,),
                      title: Text(
                        hasSearch_ar[index] ,
                        style: TextStyle(fontSize: 17 ),
                      ),
                      subtitle: Text(
                        hasSearch[index] ,
                        style: TextStyle(fontSize: 17 ),
                      ),

                      onTap: (){
                        setState(() {
                          Navigator.push(context, CupertinoPageRoute(
                              builder: (context)=>WeatherScreen(
                                  hasSearch[index],
                                  hasSearch_ar[index]
                              ),
                          ));
                        });
                      },

                    ),
                  )
                  ),
                ),
              ),

            ],

          ),
        ),
      ),
    );

  }
}
