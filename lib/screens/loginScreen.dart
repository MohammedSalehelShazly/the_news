import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../global/appClrs.dart';
import '../global/responsive.dart';
import '../localization/language_constants.dart';
import '../services/providers/themeProv.dart';
import '../widgets/changeLanguage.dart';
import '../widgets/dialog.dart';
import '../widgets/theNewsLogo.dart';

import '../StructPage.dart';
import '../services/providers/mainProvider.dart';
import '../global/staticVariables.dart';

class LoginScreen extends StatelessWidget {
  var formKeyName = GlobalKey<FormState>();
  var formKeyPassword = GlobalKey<FormState>();
  TextEditingController nameRegisterCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  double columnChildredPadding(ctx) => MediaQuery.of(ctx).size.height / 20;

  SharedPreferences prefs;

  Future<void> user_set(String _user, String _password) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('user', _user + _password);
  }

  String user = 'No';

  user_get() async {
    prefs = await SharedPreferences.getInstance();
    user = prefs.getString('user') ?? 'No';
  }

  bool first = true;

  MainProvider mainProvider;
  MainProvider mainProviderWrite;
  ThemeProv themeProv;

  AppBar loginAppBar(BuildContext context)=>
      AppBar(
        title: Text(
          getTranslated(context, 'The News'),
          style: TextStyle(fontSize: responsive.textScale(context) *25),
        ),
        centerTitle: true,
        leading: ChangeLanguage(Icon(Icons.language)),
      );

  @override
  Widget build(BuildContext context) {
    if (first) {
      mainProvider = Provider.of<MainProvider>(context);
      mainProviderWrite = Provider.of<MainProvider>(context, listen: false);
      themeProv = Provider.of<ThemeProv>(context);
    }

    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          return showDialog(
              context: context,
              builder: (context) => AppDialog(
                    ctx: context,
                    contentTxt: getTranslated(
                        context, 'Are you sure to exit application'),
                    secondActTxt: getTranslated(context, 'Exit'),
                    func: () {
                      SystemNavigator.pop();
                    },
                  ));
        },
        child: Scaffold(
          appBar: loginAppBar(context),
          body: SingleChildScrollView(
            child: Container(
              height: responsive.responsiveHigh(context, 1)-responsive.appbarTopHigh(loginAppBar(context) ,context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  SizedBox(height: 30,),
                  Expanded(
                    child: Container(
                      width: responsive.responsiveWidth(context ,0.8),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          TheNewsLogo(
                            ctx: context,
                            keyVal: ValueKey(2),
                            heroTag: 'logo',
                          ),
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                getTranslated(context, 'app presents_1') +
                                    '\n' +
                                    getTranslated(
                                        context, 'app presents_1'),
                                style: TextStyle(fontWeight: FontWeight.bold ,fontSize: responsive.textScale(context)*14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 30,),
                  Form(
                    key: formKeyName,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: columnChildredPadding(context)),
                      child: SingleChildScrollView(
                        child: TextFormField(
                          controller: nameRegisterCtrl,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5),
                            hintText: getTranslated(context, 'UserName'),
                            filled: true,
                            //fillColor: appColorPrimary.withOpacity(0.1),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          validator: (name) {
                            if (name.trim().isEmpty) {
                              return getTranslated(
                                  context, "UserName mustn't be empty");
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: columnChildredPadding(context)),
                    child: Form(
                      key: formKeyPassword,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: columnChildredPadding(context)),
                        child: SingleChildScrollView(
                          child: TextFormField(
                            controller: passwordCtrl,
                            obscureText: mainProvider.visiblePass,
                            validator: (_password) {
                              if (_password.trim().isEmpty) {
                                return getTranslated(
                                    context, "password mustn't be empty");
                              } else if (_password.length < 8)
                                return getTranslated(context,
                                    'password must gratter than 8 charachters');
                              else
                                return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 5),
                              errorStyle: TextStyle(color: Colors.red),
                              hintText: getTranslated(context, 'Password'),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  mainProvider.visiblePass == true
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: themeProv.mainClr(),
                                ),
                                onPressed: () {
                                  mainProvider.visiblePass == true
                                      ? mainProviderWrite.setVisiblePass(false)
                                      : mainProviderWrite.setVisiblePass(true);
                                },
                              ),
                              filled: true,
                              //fillColor: appColorPrimary.withOpacity(0.1),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: columnChildredPadding(context) * 1.5),
                    child: CupertinoButton(
                      onPressed: () async {
                        if (formKeyName.currentState.validate() &&
                            formKeyPassword.currentState.validate()) {
                          await user_set(
                              nameRegisterCtrl.text, passwordCtrl.text);

                          user_get().then((_) =>
                              Provider.of<MainProvider>(context, listen: false)
                                  .setUser(user));

                          Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => StructPage()));
                        }
                      },
                      color: themeProv.mainClr(),
                      child: Text(
                        getTranslated(context, 'LOG IN'),
                        style: TextStyle(fontFamily: appClrs.mainFontFamily),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Text(getTranslated(context, 'OR')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/Facebook_logo.png'),
                        backgroundColor: themeProv.mainClr(),
                        radius: responsive.responsiveWidth(context, 0.07),
                      ),
                      SizedBox(
                        width: responsive.responsiveWidth(context, 0.1),
                      ),
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/logo_Gmail.png'),
                        radius: responsive.responsiveWidth(context, 0.07),
                        backgroundColor: themeProv.mainClr(),
                      )
                    ],
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
