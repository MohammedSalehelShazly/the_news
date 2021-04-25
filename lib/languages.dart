
class Language{

  Map <String,String> _newsTitleList = {
    'All News' : 'كل الأخبار' ,
    'Health' : 'الصحة' ,
    'Technology' : 'تكنولوجيا' ,
    'Business':'إقتصاد' ,
    'Sports':'رياضة' ,
    'Art':'فن' ,
    'Scince and space':'أرصاد وفلك' ,
    'Saved':'المحفوظات' ,
    'Weather':'الطقس',
  };
  newsTit(isEng ,int index){
    if(! isEng) return _newsTitleList.values.toList()[index];
    else return _newsTitleList.keys.toList()[index];
  }

  Map <String,String> _weatherTitleList = {
    'Enter Countery Name':'ادخل أسم البلد أو المدينة',
    'Clouds Cover' : 'تغطية السحب',
    'Humidity' : 'الرطوبة',
    'Pressure' : 'الضغط',
    'Uv-Index' : 'الأشعة فوق البنفسجيه',
    'Visibility' : 'الرؤيه',
    'Wind Speed' : 'سرعة الرياح',
    'Wind Degree' : 'درجة الرياح',
    'Current Time' : 'التوقيت المحلي',

    ' oktas' : ' اوكتاس', //9
    ' pascal' : ' باسكال',
    ' m' : ' ملم',
    ' km/s' : ' كم|ث',
    ' m/h' : ' م|س',


  };
  weatherTit(isEng ,int index){
    if(! isEng) return _weatherTitleList.values.toList()[index];
    else return _weatherTitleList.keys.toList()[index];
  }





  Map <String,String> _dialogList = {
    'Cancel' : 'إالغاء' ,
    'Unsaved' : 'إالغاء الحفظ' ,
    'Are You Sure To UnSaved This News' : 'هل أنت متأكد من إالغاء حفظ الخبر',

  };
  dialogTit(isEng ,int index){
    if(! isEng) return _dialogList.values.toList()[index];
    else return _dialogList.keys.toList()[index];
  }


  Map <String,String> _searchList = {
    'Search..' : 'أبحث..' ,
    'Sorry, we didn\'t find any results matching your search' : 'نأسف, لم نجد اى نتائج بحث مشابهه لما تبحث عنه' ,
  };
  searchTit(isEng ,int index){
    if(! isEng) return _searchList.values.toList()[index];
    else return _searchList.keys.toList()[index];
  }


  Map <String,String> _widgetsList = {
    'already saved' : 'تم الحفظ من قبل' ,
  };
  widgetsTit(isEng ,int index){
    if(! isEng) return _widgetsList.values.toList()[index];
    else return _widgetsList.keys.toList()[index];
  }




}