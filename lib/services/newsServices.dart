import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../global/removeExtinctionsAtWord.dart';
import '../global/enums.dart';
import '../global/staticVariables.dart';
import '../models/articleList_models.dart';

import '../models/article_models.dart';

class NewsApi with ChangeNotifier{
  String newsKey = '74c370f0886841c7ac7b8b4f16864bcd'; // from elsha..@gmail.com
  String newsKeySec = '48b4cf61823345fbac6bf3d92fd5989d'; // from mail ma7sa...@gmail.com
  
  // http://newsapi.org/v2/top-headlines?country=us&apiKey=74c370f0886841c7ac7b8b4f16864bcd

  String allServices(String key ,String country ,newsCat cat ){
    String catStr = newsCatToString(cat ,false);

    if(cat == newsCat.all)
      return 'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$key';
    else{
      if(cat == newsCat.Art)
        catStr ='Entertainment';

      else if(cat == newsCat.Science_space)
        catStr = 'Science';

      return 'https://newsapi.org/v2/top-headlines?country=$country&category=$catStr&apiKey=$key';
    }
  }


  Map< newsCat , List<Article> > fetchesArticles = {
    newsCat.all : null,
    newsCat.Health : null,
    newsCat.Sports : null,
    newsCat.Science_space : null,
    newsCat.Art : null,
    newsCat.Business : null,
    newsCat.Technology : null,
    newsCat.Saved : null,
  };

  setArticleNews(List<Article> _articleNews ,newsCat cat){
    fetchesArticles.update(cat, (value) => _articleNews);
    notifyListeners();
  }

  clearArticleNews(newsCat cat){
    fetchesArticles.update(cat, (value) => null);
    notifyListeners();
  }


  Future< List<Article> > fetchArticles(newsCat categories ,String appLang) async{
    Map<String ,dynamic> jsonData;
    try{
      http.Response response = await http.get(allServices(newsKey ,appLang=='en'?'gb':'eg' ,categories));
      // check if my kay is used limited => use another key
      if(jsonDecode(response.body)['code']=='rateLimited'){
          print('used Second');
          response = await http.get(allServices(newsKeySec ,appLang=='en'?'us':'eg' ,categories));
      }
      if(response.statusCode==200){
        jsonData = jsonDecode(response.body);
        ArticlesList articlesList = ArticlesList.fromJson(jsonData);
        List<Article> listOfArticle = articlesList.articleList.map((e) => Article.fromJson(e)).toList();


        setArticleNews(listOfArticle, categories);

      }else print('statusCode = ${response.statusCode}');
    }catch(ex){
      print('ex is... $ex');
    }
  }

  Future<void> feachAllArticle(String appLang ,bool refresh) async{

    List<newsCat> allNewsCat = newsCat.values.toList();

    for(int i=0 ; i<newsCat.values.length ;i++){
      if( allNewsCat[i] != newsCat.Saved){

        if(fetchesArticles[ allNewsCat[i] ] == null){
          await fetchArticles(allNewsCat[i] ,appLang);
          print('fetchArticles ${allNewsCat[i]}');
        }
        if(refresh){
          clearArticleNews(allNewsCat[i]);
          await fetchArticles(allNewsCat[i] ,appLang);
          print('fetchArticles refresh ${allNewsCat[i]}');
        }

      }
    }
    print('feachAllArticle');
  }

  List<Article> searchResultList =[];
  RemoveExtinctionsAtWord _removeExtinctionsAtWord = RemoveExtinctionsAtWord();
  clearSearchResult(){
    searchResultList.clear();
    notifyListeners();
  }

  search(String searcgedWord ,String appLang ,bool refresh) async{

    clearSearchResult();
    setSearchCase(searchCase.search);

    await feachAllArticle(appLang ,refresh).then((value){

        fetchesArticles.forEach((key, value) {
          if(key != newsCat.Saved){
            for(int i=0 ;i<value.length ;i++){
              if(_removeExtinctionsAtWord.normalise(value[i].title.toLowerCase())
                  .contains(_removeExtinctionsAtWord.normalise(searcgedWord.toLowerCase()))
              || _removeExtinctionsAtWord.normalise(value[i].author.name.toLowerCase())
                      .contains(_removeExtinctionsAtWord.normalise(searcgedWord.toLowerCase()))
              || _removeExtinctionsAtWord.normalise(value[i].publishedAt.toLowerCase())
                      .contains(_removeExtinctionsAtWord.normalise(searcgedWord.toLowerCase()))
              || _removeExtinctionsAtWord.normalise(value[i].description.toLowerCase())
                      .contains(_removeExtinctionsAtWord.normalise(searcgedWord.toLowerCase()))
              ){
                searchResultList.add(value[i]);
                notifyListeners();
                print('contains');
              }
              searchResultList = listToSet(searchResultList);
              notifyListeners();
            }
          }

          //if(fetchesArticles.values.toList().indexOf(value) == fetchesArticles.values.toList().length-1)
          //  return 1;
        });
        print('search is done');
        setSearchCase(searchCase.searchIsDone);
    });
  }
  searchCase currentSearchCase = searchCase.notSearch;
  setSearchCase(searchCase _currentSearchCase){
    currentSearchCase = _currentSearchCase;
    notifyListeners();
  }

  listToSet(List<Article> list){
    if(list.length >=2){
      for(int i=0 ;i<list.length ;i++){
        if( i+1<list.length && list[i].title == list[i+1].title){
          list.removeAt(i+1);
        }

        for(int j=i+1 ;j<list.length ;j++){
          if(list[i].title == list[j].title){
            list.removeAt(j);
          }
        }
      }
      return list;
    }
    else return list;
  }




}



































var fackData = {
  "status": "ok",
  "totalResults": 38,
  "articles": [
    {
      "source": {
        "id": null,
        "name": "New York Times"
      },
      "author": "Glenn Thrush",
      "title": "Covid-19 and Vaccine News: Live Updates - The New York Times",
      "description": "The freeze on residential evictions is set to expire on Saturday, but it is not clear whether there are enough votes in the Senate to keep it another month.",
      "url": "https://www.nytimes.com/live/2021/07/29/world/covid-delta-variant-vaccine",
      "urlToImage": "https://static01.nyt.com/images/2021/07/29/world/29virus-briefing-promo4/29virus-briefing-promo4-facebookJumbo.jpg",
      "publishedAt": "2021-07-29T18:33:18Z",
      "content": "LiveUpdated July 29, 2021, 2:41 p.m. ET\r\nJuly 29, 2021, 2:41 p.m. ET\r\nThe freeze on residential evictions is set to expire on Saturday, but it is not clear whether there are enough votes in the Senat… [+45312 chars]"
    },
    {
      "source": {
        "id": "cnn",
        "name": "CNN"
      },
      "author": "Holly Yan, CNN",
      "title": "US gymnast Suni Lee wins Olympic all-around after injuries, tragedies and a horrific accident - CNN",
      "description": "Suni Lee's historic performance -- highlighted by the most difficult, astonishing uneven bars routine in the world -- capped an immensely difficult journey.",
      "url": "https://www.cnn.com/2021/07/29/sport/gymnast-suni-lee-profile/index.html",
      "urlToImage": "https://cdn.cnn.com/cnnnext/dam/assets/210729100544-26-sunisa-lee-olympics-2020-unf-super-tease.jpg",
      "publishedAt": "2021-07-29T18:01:00Z",
      "content": null
    },
    {
      "source": {
        "id": "cnn",
        "name": "CNN"
      },
      "author": "Sonia Moghe, CNN",
      "title": "Former Cardinal Theodore McCarrick criminally charged for alleged sex abuse of a minor nearly 50 years ago - CNN",
      "description": "Former Cardinal Theodore McCarrick, who was defrocked by The Vatican in 2019 over sex abuse allegations, is now facing criminal charges in Massachusetts for alleged sex abuse of a minor nearly 50 years ago, according to a court filing.",
      "url": "https://www.cnn.com/2021/07/29/us/theodore-mccarrick-sexual-abuse/index.html",
      "urlToImage": "https://cdn.cnn.com/cnnnext/dam/assets/210729132312-theodore-mccarrick-file-super-tease.jpg",
      "publishedAt": "2021-07-29T17:53:00Z",
      "content": "(CNN)Former Cardinal Theodore McCarrick, who was defrocked by The Vatican in 2019 over sex abuse allegations, is now facing criminal charges in Massachusetts for alleged sex abuse of a minor nearly 5… [+4138 chars]"
    },
    {
      "source": {
        "id": null,
        "name": "Gizmodo.com"
      },
      "author": "Shoshana Wodinsky",
      "title": "Google Is Booting 'Sugar Daddy' Apps From the Play Store - Gizmodo",
      "description": "Come September 1, dozens of apps geared toward 'compensated sexual relationships' will be banned from the Google Play Store.",
      "url": "https://gizmodo.com/google-is-booting-sugar-daddy-apps-from-the-play-store-1847385581",
      "urlToImage": "https://i.kinja-img.com/gawker-media/image/upload/c_fill,f_auto,fl_progressive,g_center,h_675,pg_1,q_80,w_1200/a83d98497926b297adb752578bf8190e.jpg",
      "publishedAt": "2021-07-29T17:50:00Z",
      "content": "You probably wouldnt expect to find references to sugar daddies in Googles policy updates, but this week thats exactly what happened. Android Police was first to note that Google quietly updated its … [+2125 chars]"
    },
    {
      "source": {
        "id": "the-wall-street-journal",
        "name": "The Wall Street Journal"
      },
      "author": "Joe Flint, Erich Schwartzel",
      "title": "Scarlett Johansson Sues Disney Over ‘Black Widow’ Streaming Release - The Wall Street Journal",
      "description": "Star alleges simultaneous release of the latest Marvel movie in theaters and on Disney+ service was a breach of contract",
      "url": "https://www.wsj.com/articles/scarlett-johansson-sues-disney-over-black-widow-streaming-release-11627579278",
      "urlToImage": "https://images.wsj.net/im-377226/social",
      "publishedAt": "2021-07-29T17:21:00Z",
      "content": "Black Widow has a new enemy: the Walt Disney Co. \r\nScarlett Johansson, star of the latest Marvel movie Black Widow, filed a lawsuit Thursday in Los Angeles Superior Court against Disney, alleging her… [+593 chars]"
    },
    {
      "source": {
        "id": null,
        "name": "Www.https"
      },
      "author": "New York Post",
      "title": "Jamie Lee Curtis reveals her 25-year-old child is transgender - Fox News",
      "description": "The “Freaky Friday” star told AARP Magazine that she and husband Christopher Guest “have watched in wonder and pride as our son became our daughter Ruby.”",
      "url": "https://www.https://pagesix.com/2021/07/29/jamie-lee-curtis-reveals-her-child-is-transgender/",
      "urlToImage": "https://static.foxnews.com/foxnews.com/content/uploads/2021/06/jamie-lee-curtis-ap-2021.jpg",
      "publishedAt": "2021-07-29T17:14:44Z",
      "content": "Jamie Lee Curtis revealed that her younger child is transgender.\r\nThe \"Freaky Friday\" star told AARP Magazine that she and husband Christopher Guest \"have watched in wonder and pride as our son becam… [+1783 chars]"
    },
    {
      "source": {
        "id": null,
        "name": "New York Post"
      },
      "author": "Brian Costello",
      "title": "Jets, Zach Wilson finally end \$35.1 million contract standoff - New York Post ",
      "description": "Zach Wilson is done holding out.",
      "url": "https://nypost.com/2021/07/29/jets-zach-wilson-finally-end-35-1-million-contract-standoff/",
      "urlToImage": "https://nypost.com/wp-content/uploads/sites/2/2021/07/zach_wilson.jpg?quality=90&strip=all&w=1200",
      "publishedAt": "2021-07-29T17:14:00Z",
      "content": "The Jets and Zach Wilson finally got it done Thursday.\r\nThe rookie quarterback, taken No. 2 overall by the team, agreed to sign his contract, which will pay him \$35.1 million over four years, includi… [+637 chars]"
    },
    {
      "source": {
        "id": null,
        "name": "Sports Illustrated"
      },
      "author": "Jeremy Woo",
      "title": "NBA Mock Draft 7.0: Latest Projections and Rumors - Sports Illustrated",
      "description": "While there’s a sense of which players will come off the board first, the prospect of trades in the lottery has continued to swirl.",
      "url": "https://www.si.com/nba/2021/07/29/nba-mock-draft-2021-rumors-cade-cunningham-jalen-green-evan-mobley",
      "urlToImage": "https://www.si.com/.image/t_share/MTgwNjM3MTk1Nzg1MjE3Mzg0/nba-draft-big-board-30.jpg",
      "publishedAt": "2021-07-29T16:29:12Z",
      "content": "The 2021 NBA draft is upon us and beginning to crystalize, with teams making final preparations for Thursday’s event. And while there’s a sense of which players will come off the board first, the pro… [+31497 chars]"
    },
    {
      "source": {
        "id": null,
        "name": "CNBC"
      },
      "author": "Maggie Fitzgerald",
      "title": "Robinhood drops 5% in stock trading app's Nasdaq debut - CNBC",
      "description": "Trading for the first time under the ticker HOOD, the online brokerage hit the public markets it seeks to democratize for amateur investors.",
      "url": "https://www.cnbc.com/2021/07/29/robinhood-hood-ipo-stock-starts-trading-on-the-nasdaq.html",
      "urlToImage": "https://image.cnbcfm.com/api/v1/image/106918987-16275791572021-07-29t162622z_1786553888_rc2cuo9whxgh_rtrmadp_0_robinhood-ipo.jpeg?v=1627579181",
      "publishedAt": "2021-07-29T16:25:20Z",
      "content": "Shares of Robinhood fell about 5% during its Nasdaq debut, after pricing near the low end of its IPO range.\r\nThe online brokerage started trading at \$38 per share, the low end of its range, valuing t… [+5625 chars]"
    },
    {
      "source": {
        "id": "cnn",
        "name": "CNN"
      },
      "author": "Alexis Benveniste, CNN Business",
      "title": "Danny Meyer: If you want to be unvaccinated, 'you can dine somewhere else' - CNN",
      "description": "Danny Meyer, restaurateur and CEO of Union Square Hospitality Group, is requiring his employees and all customers at his restaurants to prove that they've been vaccinated against Covid-19.",
      "url": "https://www.cnn.com/2021/07/29/business/danny-meyer-vaccines/index.html",
      "urlToImage": "https://cdn.cnn.com/cnnnext/dam/assets/210729105224-danny-meyer-union-square-hospitality-group-file-restricted-super-tease.jpg",
      "publishedAt": "2021-07-29T15:44:00Z",
      "content": "New York (CNN)Danny Meyer, restaurateur and CEO of Union Square Hospitality Group, is requiring his employees and all customers at his restaurants to prove that they've been vaccinated against Covid-… [+2039 chars]"
    },
    {
      "source": {
        "id": null,
        "name": "syracuse.com"
      },
      "author": "Geoff Herbert | gherbert@syracuse.com",
      "title": "These 11 counties in New York state should return to masks indoors, CDC says - syracuse.com",
      "description": "The list includes two counties in Upstate New York.",
      "url": "https://www.syracuse.com/coronavirus/2021/07/these-11-counties-in-new-york-state-should-return-to-masks-indoors-cdc-says.html",
      "urlToImage": "https://www.syracuse.com/resizer/AL8Ieekk3zLLSK-2Rrffwl_Zuvo=/1280x0/smart/cloudfront-us-east-1.images.arcpublishing.com/advancelocal/7XVMAVAHLJBTNDEBIVJ2DOWTWA.jpg",
      "publishedAt": "2021-07-29T15:43:06Z",
      "content": "Eleven counties in New York state should now return to wearing masks indoors, according to new guidance from the U.S. Centers for Disease Control and Prevention.\r\nThe CDC said Tuesday that people sho… [+3875 chars]"
    },
    {
      "source": {
        "id": "politico",
        "name": "Politico"
      },
      "author": "Olivia Beavers",
      "title": "GOP lawmaker challenges McCarthy over 'bulls---' mask mandate enforcement - POLITICO",
      "description": "There's mounting fury on the right about efforts to enforce the new House requirement as Covid's Delta variant spreads.",
      "url": "https://www.politico.com/news/2021/07/29/chip-roy-kevin-mccarthy-mask-mandate-501536",
      "urlToImage": "https://static.politico.com/27/3f/b189558a4134b650d131d769c469/ap21007128944293-1.jpg",
      "publishedAt": "2021-07-29T15:40:09Z",
      "content": "A Capitol Police guidance flier circulated Thursday morning by Rep. Kat Cammack (R-Fla.) states: \"If a visitor or staff member fails to wear a mask after a request is made to do so, the visitor or st… [+1123 chars]"
    },
    {
      "source": {
        "id": null,
        "name": "MarketWatch"
      },
      "author": "Lukas I. Alpert",
      "title": "Nikola electric-truck prototypes were powered by hidden wall sockets, towed into position and rolled down hills, prosecutors say - MarketWatch",
      "description": "Prosecutors said the prototypes didn’t function and were Frankenstein monsters cobbled together from parts from other vehicles",
      "url": "https://www.marketwatch.com/story/nikola-electric-truck-prototypes-were-powered-by-hidden-wall-sockets-towed-into-position-and-rolled-down-hills-prosecutors-say-11627572394",
      "urlToImage": "https://images.mktw.net/im-257344/social",
      "publishedAt": "2021-07-29T15:26:00Z",
      "content": "The founder of the much-hyped electric truck manufacturer Nikola Corp. \r\n NKLA,\r\n -10.43%\r\nhas been charged with lying to investors about the supposed technological breakthroughs the company had achi… [+4469 chars]"
    },
    {
      "source": {
        "id": null,
        "name": "East Idaho News"
      },
      "author": null,
      "title": "Out-of-state woman faces charges in Yellowstone for getting too close to grizzly and cubs - eastidahonews.com",
      "description": "BILLINGS, Montana (AP) — An Illinois woman faces criminal charges after she was captured on video being bluff charged by a grizzly bear while she was taking photos in Yellowstone National Park. The woman was among a small group of tourists who spotted the fem…",
      "url": "https://www.eastidahonews.com/2021/07/out-of-state-woman-faces-charges-in-yellowstone-for-getting-too-close-to-grizzly-and-cubs/",
      "urlToImage": "https://s3-assets.eastidahonews.com/wp-content/uploads/2021/07/29090231/Bear_Charged.jpg",
      "publishedAt": "2021-07-29T15:04:00Z",
      "content": null
    },
    {
      "source": {
        "id": null,
        "name": "Www.https"
      },
      "author": "New York Post",
      "title": "Oblivious lottery winner carried \$39M winning ticket in purse for weeks - Fox News",
      "description": "A German woman unknowingly walked around for weeks with a lottery ticket worth nearly \$40 million in her purse.",
      "url": "https://www.https://nypost.com/2021/07/28/lottery-winner-carried-39m-winning-ticket-in-purse-for-weeks/",
      "urlToImage": "https://static.foxnews.com/foxnews.com/content/uploads/2021/03/Lottery-istock.jpg",
      "publishedAt": "2021-07-29T14:57:19Z",
      "content": "A German woman unknowingly walked around for weeks with a lottery ticket worth nearly \$40 million in her purse.\r\nThe 45-year-old was oblivious she was toting the golden ticket since June 9, before ca… [+1359 chars]"
    },
    {
      "source": {
        "id": "engadget",
        "name": "Engadget"
      },
      "author": "https://www.engadget.com/about/editors/kris-holt",
      "title": "Huawei’s P50 lineup is powered by HarmonyOS 2 but lacks 5G - Engadget",
      "description": "Some models use Qualcomm’s Snapdragon 888 chipset..",
      "url": "https://www.engadget.com/huawei-p50-pro-smartphones-harmony-os-2-snapdragon-888-144502211.html",
      "urlToImage": "https://s.yimg.com/os/creatr-uploaded-images/2021-07/b238a2d0-f078-11eb-a7be-dd8a48e1b7fb",
      "publishedAt": "2021-07-29T14:48:45Z",
      "content": "Huawei\r\n has revealed\r\n the P50 and P50 Pro, its first flagship phones that use HarmonyOS 2 from the outset. The company started rolling out the operating system to its existing devices in early June… [+1951 chars]"
    },
    {
      "source": {
        "id": null,
        "name": "Boston.com"
      },
      "author": null,
      "title": "Massachusetts announces first winners of state’s VaxMillions giveaway - Boston.com",
      "description": "Darrell Washington, of Weymouth, and Daniela Maldonado, of Chelsea, are the first winners of the Massachusetts vaccine lottery.",
      "url": "https://www.boston.com/news/coronavirus/2021/07/29/massachusetts-vaccine-lottery-first-winners/",
      "urlToImage": "https://bdc2020.o0bc.com/wp-content/uploads/2021/07/s3___bgmp-arc_arc-feeds_generic-photos_to-arc_ryanvaxwinner3met-6102d7332ce63-scaled.jpg",
      "publishedAt": "2021-07-29T14:47:00Z",
      "content": "Skip to Main Content\r\nCoronavirus\r\nDaniela Maldonado of Chelsea and Darrell Washington of Weymouth. David L. Ryan / The Boston Globe\r\nAfter getting their COVID-19 vaccine shots earlier this spring, t… [+4628 chars]"
    },
    {
      "source": {
        "id": "the-verge",
        "name": "The Verge"
      },
      "author": "Andrew Webster",
      "title": "Jodie Whittaker’s run on Doctor Who will end in 2022 - The Verge",
      "description": "The BBC announced that star Jodie Whittaker and showrunner Chris Chibnall will be leaving Doctor Who in 2022.",
      "url": "https://www.theverge.com/2021/7/29/22599878/doctor-who-jodie-whittaker-chris-chibnall-leaving-2022",
      "urlToImage": "https://cdn.vox-cdn.com/thumbor/imRS8uY3xC_wV6CXOFRxTrhFCw8=/0x15:728x396/fit-in/1200x630/cdn.vox-cdn.com/uploads/chorus_asset/file/22748146/2g90j0k80001000.jpg",
      "publishedAt": "2021-07-29T14:44:30Z",
      "content": "She still has plenty of appearances before then\r\nImage: BBC\r\nThe Thirteenth Doctor is set to step away. Today, the BBC announced that Jodie Whittaker, who took over as the first female lead in Doctor… [+1310 chars]"
    },
    {
      "source": {
        "id": null,
        "name": "ESPN"
      },
      "author": "Rob Demovsky",
      "title": "Green Bay Packers GM says Randall Cobb trade was 'very important thing' for Aaron Rodgers - ESPN",
      "description": "Packers GM Brian Gutekunst said Aaron Rodgers' input was one of the main reasons for the team's acquisition of Randall Cobb, saying \"this was a very important thing for Aaron.\"",
      "url": "https://www.espn.com/nfl/story/_/id/31911767/green-bay-packers-gm-says-randall-cobb-trade-was-very-important-thing-aaron-rodgers",
      "urlToImage": "https://a.espncdn.com/combiner/i?img=%2Fphoto%2F2017%2F0108%2Fr169418_1296x729_16%2D9.jpg",
      "publishedAt": "2021-07-29T14:32:43Z",
      "content": "GREEN BAY, Wis. -- Brian Gutekunst left little to interpretation: The Green Bay Packers' general manager brought receiver Randall Cobb back to Green Bay because Aaron Rodgers wanted him.\r\n\"I think th… [+2328 chars]"
    },
    {
      "source": {
        "id": null,
        "name": "The Guardian"
      },
      "author": "Guardian staff reporter",
      "title": "Alaska earthquake prompts tsunami warnings as people take shelter - The Guardian",
      "description": "National Tsunami Warning Center canceled the warnings when the biggest wave, just over a half foot, recorded in Old Harbor",
      "url": "https://amp.theguardian.com/us-news/2021/jul/29/alaska-earthquake-tsunami-warnings",
      "urlToImage": null,
      "publishedAt": "2021-07-29T14:24:00Z",
      "content": "AlaskaNational Tsunami Warning Center canceled the warnings when the biggest wave, just over a half foot, recorded in Old Harbor\r\nThu 29 Jul 2021 14.26 BST\r\nA powerful earthquake which struck just of… [+2512 chars]"
    }
  ]
};
