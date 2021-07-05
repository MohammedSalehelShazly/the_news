import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_news/languages.dart';
import 'package:the_news/widgets/changeLanguage.dart';
import 'package:the_news/widgets/dialog.dart';
import 'package:the_news/widgets/theNewsLogo.dart';

import '../StructPage.dart';
import '../providerReT.dart';
import '../staticVariables.dart';




  class LoginScreen extends StatelessWidget {

    var formKeyName = GlobalKey<FormState>();
    var formKeyPassword = GlobalKey<FormState>();
    TextEditingController nameRegisterCtrl = TextEditingController();
    TextEditingController passwordCtrl = TextEditingController();
    double columnChildredPadding(ctx)=> MediaQuery.of(ctx).size.height/20;
    
    SharedPreferences prefs;
    Future<void>user_set(String _user ,String _password) async {
      prefs = await SharedPreferences.getInstance();
      prefs.setString('user', _user+_password);
    }

    String user ='No';
    user_get() async{
      prefs = await SharedPreferences.getInstance();
      user = prefs.getString('user') ?? 'No' ;
    }

    @override
    Widget build(BuildContext context) {
    final provListen = Provider.of<MyProviderReT>(context);
    final prov = Provider.of<MyProviderReT>(context);

    return SafeArea(
      child: Directionality(
        textDirection: provListen.isEnglish ? TextDirection.ltr : TextDirection.rtl,
        child: WillPopScope(
          onWillPop: (){
            return showDialog(
              context: context,
              builder: (context)=> AppDialog(
              ctx: context,
              contentTxt: Language().dialogTit(provListen.isEnglish, 3),
              isEnglish: provListen.isEnglish,
              secondActTxt: Language().dialogTit(provListen.isEnglish, 4),
              func: (){
                SystemNavigator.pop();
              },
            )
           );
          },
          child: Scaffold(
        appBar: AppBar(
          title: Text(Language().loginFomrs(provListen.isEnglish, 0) ,style: myTextStyle(context ,ratioSize: 25),),
          centerTitle: true,
          leading: ChangeLanguage(true),
        ),
        body:Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(columnChildredPadding(context) ,columnChildredPadding(context) ,columnChildredPadding(context) ,0),
          child: Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                TheNewsLogo(ctx: context ,keyVal: ValueKey(2) ,heroTag: 'logo',),
                
                Container(
                  color: Colors.white.withOpacity(0.85),
                  height: MediaQuery.of(context).size.width *0.7, // the same dimantions of logo image
                  width: MediaQuery.of(context).size.width *0.7,
                  alignment: Alignment.center,
                  child: Text(
                    Language().loginFomrs(provListen.isEnglish, 9),
                    style: myTextStyle(context ,ratioSize:18 ,clr: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )
        ),

        Padding(
          padding: EdgeInsets.only(top: columnChildredPadding(context)),
          child: Form(
          key: formKeyName,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: columnChildredPadding(context)),
            child: SingleChildScrollView(
              child: TextFormField(
                controller: nameRegisterCtrl,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0 , horizontal: 5),
                hintText: Language().loginFomrs(provListen.isEnglish, 1),
                errorStyle: myTextStyle(context ,clr: Colors.red),
                filled: true,
                fillColor: appColorPrimary.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              validator: (name){
                if(name.trim().isEmpty){
                  return Language().loginFomrs(provListen.isEnglish, 5);
                }return null;
              },
            ),
          ),
        ),
      ),
    ),

        Padding(
          padding: EdgeInsets.only(top: columnChildredPadding(context)),
          child: Form(
          key: formKeyPassword,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: columnChildredPadding(context)),
            child: SingleChildScrollView(
              child: TextFormField(
                controller: passwordCtrl,
              obscureText: provListen.visiblePass,
              validator: (_password){
                if(_password.trim().isEmpty){
                  return Language().loginFomrs(provListen.isEnglish, 6);
                }
                else if(_password.length <8) return Language().loginFomrs(provListen.isEnglish, 4);
                else return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 0 ,horizontal: 5),
                errorStyle: myTextStyle(context ,clr: Colors.red),
                hintText: Language().loginFomrs(provListen.isEnglish, 2),
                suffixIcon: IconButton(
                  icon: provListen.visiblePass==true? Icon(Icons.visibility_off , color: appColorPrimary,) : Icon(Icons.visibility ,  color: appColorPrimary,),
                  onPressed: (){
                    provListen.visiblePass==true ? prov.setVisiblePass(false) : prov.setVisiblePass(true);
                  },
                ),
                filled: true,
                fillColor: appColorPrimary.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
            ),
            ),
          ),
        ),
        ),

        Padding(
          padding: EdgeInsets.only(top: columnChildredPadding(context)*1.5),
          child: CupertinoButton(
          onPressed: () async{
            if(formKeyName.currentState.validate() && formKeyPassword.currentState.validate()){
              
              await user_set(nameRegisterCtrl.text ,passwordCtrl.text);
              
              user_get().then((_)=>  Provider.of<MyProviderReT>(context ,listen: false).setUser(user)  );

              Navigator.pushReplacement(context, CupertinoPageRoute(
                  builder: (context)=>StructPage()));

            }
          },
          color: appColorPrimary,
          child: Text(Language().loginFomrs(provListen.isEnglish, 3),
                 style: myTextStyle(context ,clr: Colors.white ,ratioSize: 17),),
          borderRadius: BorderRadius.circular(20),
        ),
        ) ,       
        
        // Text('OR'),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //   CircleAvatar(
        //     backgroundImage: AssetImage('images/Facebook_logo.png'),
        //     backgroundColor: Colors.blue[700],
        //     radius: MediaQuery.of(context).size.width/15,
        //   ),
        //     SizedBox(width: MediaQuery.of(context).size.width/25,),
        //     CircleAvatar(
        //       backgroundImage: AssetImage('images/google_plus.jpg'),
        //       radius: MediaQuery.of(context).size.width/15,
        //     )
        //   ],
        // ),
      ],
    ),
      ),

        ),
       ),
      )
    ),
  );
}

  }