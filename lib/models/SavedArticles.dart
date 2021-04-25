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
      await txn.rawInsert("INSERT INTO SavedTable (title ,author ,url ,urlToImage ,publishedAt) VALUES ('${oneNews['title']}' ,'${oneNews['author']}' ,'${oneNews['url']}' ,'${oneNews['urlToImage']}' ,'${oneNews['publishedAt']}')");
      var selectAll = await txn.rawQuery('SELECT * FROM SavedTable');
      return selectAll;
    });
  }


  Future< List<Map<String,dynamic>> > getAll() async{
    Database init = await initDB() ;
    List<Map<String,dynamic>> all = await init.rawQuery('SELECT * FROM SavedTable');
    return all;
  }

  // {
  //  'title' : 'sdsdsdsd' ,
  // },
  // {
  //  'title' : 'sssssssssssdsdsdsd' ,
  // },

  Future<bool> searchOnSaved(String title) async{
    List<Map<String,dynamic>> all = await getAll();
    bool isFound = false;

    isFound = all.map((e)=> title == e['title']).toList()
        .contains(true);

    print('isFound $isFound');
    return isFound;

  }



  deleteOne(String title) async{
    Database db = await initDB();
    return db.rawUpdate("DELETE FROM SavedTable WHERE title = '$title'");
  }




}



/*


/// static Database _db ;
/// get db if null => return _db =init()
///       else return _db;

initialDB() async {
  var docDir = await getDatabasesPath();
  String path = join(docDir, 'test.db');
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT , age TEXT)',);
      });
  return database;
}

insertRow(Map <String,dynamic> atrbuiets) async {
  Database db = await initialDB();
  await db.transaction((txn) async {
    await txn.rawInsert(
        'INSERT INTO Test(name ,age) VALUES("${atrbuiets['name']}" , "${atrbuiets['age']}")');
  });

  var y = await db.rawQuery('SELECT * FROM Test');
  return y;
}

getOne(int selectedId) async{
  Database db = await initialDB() ;
  //return db.query('Test' ,where: 'id = "$selectedId"');
  return db.rawQuery('SELECT * FROM Test WHERE id = "$selectedId"');
}

getAll() async{
  Database db = await initialDB() ;
  //return db.query('Test' ,where: 'id = "$selectedId"');
  return db.rawQuery('SELECT COUNT(name) FROM Test ORDER BY name DESC GROUP BY name ');
}

deleteAll() async{
  Database db = await initialDB();
  return db.rawUpdate('DELETE FROM Test WHERE name = "Mohammed"');
}

update(updatedName ,Map <String,dynamic> atrbuiets) async{
  Database db = await initialDB();
  //return db.update('Test', atrbuiets ,where: 'name = $updatedName');

  return db.rawUpdate('UPDATE Test SET name = "${atrbuiets['name']}" WHERE name = "$updatedName" ');

}
*/

