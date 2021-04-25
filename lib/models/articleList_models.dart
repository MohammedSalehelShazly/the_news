

class ArticlesList{
  final List<dynamic> articleList;

  ArticlesList({this.articleList});

  factory ArticlesList.fromJson(Map<String,dynamic> jsonData){
    return ArticlesList(
      articleList: jsonData['articles']
      );
  }

}