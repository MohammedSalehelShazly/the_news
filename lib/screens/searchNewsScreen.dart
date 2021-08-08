
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../global/responsive.dart';
import '../localization/language_constants.dart';
import '../services/providers/settingsProv.dart';
import '../services/providers/themeProv.dart';
import '../widgets/container_oneNews.dart';
import '../widgets/noSearchItems.dart';
import '../widgets/searchInitScreen.dart';
import '../global/enums.dart';
import '../services/providers/mainProvider.dart';
import '../services/newsServices.dart';


class SearchNewsScreen extends StatelessWidget {

  NewsApi newsApi;
  NewsApi newsApiWrite;
  MainProvider mainProvider;
  ThemeProv themeProv;
  SettingsProv settingsProv;

  TextEditingController inputController = TextEditingController();
  bool first = true;

  @override
  Widget build(BuildContext context) {
    if(first){
      newsApi = Provider.of<NewsApi>(context);
      newsApiWrite = Provider.of<NewsApi>(context, listen: false);
      mainProvider = Provider.of<MainProvider>(context);
      themeProv = Provider.of<ThemeProv>(context);
      settingsProv = Provider.of<SettingsProv>(context);

      first = false;
    }
    print(newsApi.searchResultList.length);

    return SafeArea(
        child: WillPopScope(
          onWillPop: ()async{
            newsApiWrite.clearSearchResult();
            newsApiWrite.setSearchCase(searchCase.notSearch);
            return true;
          },
          child: Scaffold(
            body: RefreshIndicator(
              onRefresh: () async{
                await newsApiWrite.search(inputController.text ,settingsProv.appLang ,true);
              },
              child: CustomScrollView(
                slivers: [

                  SliverAppBar(
                    pinned: false,
                    floating: true,
                    title: TextFormField(
                      textInputAction: TextInputAction.search,
                      autofocus: true,
                      controller: inputController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          prefixIcon: Icon(Icons.search),
                          hintText: getTranslated(context, 'Search..')
                      ),
                     onFieldSubmitted: (val){
                         newsApiWrite.search(val ,settingsProv.appLang ,false);
                     },
                    ),
                  ),



                  newsApiWrite.currentSearchCase == searchCase.notSearch
                      ? SliverFillRemaining(child: SearchInitScreen())
                      :
                  newsApiWrite.currentSearchCase == searchCase.search
                      ? SliverFillRemaining(child: Center(child: CupertinoActivityIndicator(),),)
                      :
                  newsApiWrite.currentSearchCase == searchCase.searchIsDone && newsApiWrite.searchResultList.isEmpty
                      ?
                  SliverFillRemaining(child: NoSearchItems())
                      :

                  //  this case is===>  searchIsDone && searchResultList.isNotEmpty
                  SliverList(delegate: SliverChildListDelegate(
                      newsApi.searchResultList.map((e) => ContainerOneNews(
                        themeProv.mainClr(),
                        all: null,
                        sWidth: responsive.sWidth(context),
                        sHeight: responsive.sWidth(context) *0.55,
                        title: e.title,
                        url: e.url,
                        author: e.author.name,
                        publishedAt: e.publishedAt,
                        urlToImage: e.urlToImage,
                      )).toList()
                  ))
                ],
              ),
            ),

          ),
        ));
  }
}