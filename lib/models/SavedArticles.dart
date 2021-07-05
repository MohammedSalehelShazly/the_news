import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SavedDB{

  initDB() async{
    var docDir = await getDatabasesPath();
    var path = join(docDir ,'SavedNews.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE SavedTable (title TEXT PRIMARY KEY, author Text ,url TEXT ,urlToImage TEXT ,publishedAt TEXT)',);
        });

    return database;
  }

  insertRow(Map<String ,dynamic> oneNews) async{
    Database init = await initDB();
    
    init.transaction((txn) async{
      try{
        await txn.rawInsert("INSERT INTO SavedTable (title ,author ,url ,urlToImage ,publishedAt) VALUES ('${oneNews['title'].toString().replaceAll("'", " ")}' ,'${oneNews['author']}' ,'${oneNews['url']}' ,'${oneNews['urlToImage']}' ,'${oneNews['publishedAt']}')");
      }catch(ex){
        print('ex SQlite=> $ex');
      }
      
      var selectAll = await txn.rawQuery('SELECT * FROM SavedTable');
      return selectAll;
    
    });
  }


  Future< List<Map<String,dynamic>> > getAll() async{
    Database init = await initDB() ;
    List<Map<String,dynamic>> all = await init.rawQuery('SELECT * FROM SavedTable');
    return all;
  }

  Future<bool> searchOnSaved(String title ,List<Map<String,dynamic>> all) async{
    bool isFound = false;

    isFound = all.map((e)=> title.toString().replaceAll("'", " ") == e['title']).toList()
        .contains(true);

    print('isFound $isFound');
    return isFound;

  }

  deleteOne(String title) async{
    Database db = await initDB();
    return db.rawUpdate("DELETE FROM SavedTable WHERE title = '${title.toString().replaceAll("'", " ")}'");
  }




}
