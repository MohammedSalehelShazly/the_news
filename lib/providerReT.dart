
import 'dart:math';

import 'package:flutter/cupertino.dart';

class MyProviderReT with ChangeNotifier{
  int currentPageIndex = 0;

  changeCurrentPage(_currentPageIndex){
    currentPageIndex = _currentPageIndex ;
    notifyListeners();
  }

  bool alreadySavedAppear = false;
  setAlreadySavedAppear(bool newAlreadySavedAppear){
    alreadySavedAppear = newAlreadySavedAppear;
    notifyListeners();
  }


  bool isEnglish = true;
  setIsEnglish(bool newIsEnglish){
    isEnglish = newIsEnglish;
    notifyListeners();
  }

  
  String user ='No';
  setUser(String newUser){
    user = newUser;
    notifyListeners();
  }
  
  bool visiblePass = true;
  setVisiblePass(bool newVisiblePass){
    visiblePass = newVisiblePass;
    notifyListeners();
  }

}