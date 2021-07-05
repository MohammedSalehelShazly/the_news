
class Language{

  Map <String,String> _newsTitleList = {
    'Highlights' : 'المحتوى الرائج' ,
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
    'Cancel' : 'إلغاء' ,
    'Unsaved' : 'إلغاء الحفظ' ,
    'Are You Sure To UnSaved This News' : 'هل أنت متأكد من إلغاء حفظ الخبر',
    'Are you sure to exite application' : 'هل أنت متأكد من الخروج من التطبيق',
    'Exite' : 'خروج'

  };
  dialogTit(isEng ,int index){
    if(! isEng) return _dialogList.values.toList()[index];
    else return _dialogList.keys.toList()[index];
  }


  Map <String,String> _searchList = {
    'Search..' : 'أبحث..' ,
    'Sorry, we didn\'t find any results matching your search' : 'نأسف, لم نجد اى نتائج بحث مشابهه لما تبحث عنه' ,
    'Enter a few words to search in news' : 'أكتب بعض الكلمات للبحث في الأخبار',
  };
  searchTit(isEng ,int index){
    if(! isEng) return _searchList.values.toList()[index];
    else return _searchList.keys.toList()[index];
  }


  Map <String,String> _widgetsList = {
    'already saved' : 'تم الحفظ من قبل',
    'No News Saved' : 'لا يوجد أخبار محفوظه',
    'Language' : 'اللغة',
    'Logout' : 'تسجيل الخروج',
    'Check the internet connection' : 'تحقق من اتصال الإنترنت',
    //4
  };
  widgetsTit(isEng ,int index){
    if(! isEng) return _widgetsList.values.toList()[index];
    else return _widgetsList.keys.toList()[index];
  }

  Map <String,String> _loginFomrsList = {
    'The News' :'الـخبر',
    'UserName' : 'أسم المستخدم',
    'Password' : 'كلمة السر',
    'LOG IN' : 'تسجيل',
    'password must gratter than 8 charachters' : 'كلمة السر يجب ان تكون اكبر من 8 حروف او ارقام',
    'UserName mustn\'t be empty' :'أسم مستخدم لا يجب ان يكون فارغا ',
    'password mustn\'t be empty':'كلمة السر  لا يجب ان تكون فارغه',
    'If you logout you can\'t browse news \nAre you sure to logout' : 'إذا قمت بتسجيل الخروج فلن تتمكن من تصفح الأخبار'+ '\n'+ 'هل متأكد من تسجيل الخروج',
    'logout' :'تسجيل خروج',
    //8

    'Learn about the latest news in Egypt, the Middle East and around the world. The news application also provides you with the ability to see the news and move between them very easily' + '\n' + 'Remember the username and password so that you can access your account information later and from other devices' 
            : 'تعرف على أخر أخبار مصر والشرق الأوسط وحول العالم كما يوفر لك تطبيق الخبر مشاهدة الأخبار والتنقل بينها بسهولة شديدة للغاية' + '\n' + 'تذكر أسم المستخدم و كلمة السر لكى تستطيع الوصول لمعلومات حسابك لاحقا ومن أجهزه اخرى',
     
     //'' : '',

  };
  loginFomrs(isEng ,int index){
    if(! isEng) return _loginFomrsList.values.toList()[index];
    else return _loginFomrsList.keys.toList()[index];
  }


}