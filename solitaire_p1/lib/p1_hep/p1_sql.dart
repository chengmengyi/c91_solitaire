import 'package:sqflite/sqflite.dart';

class TableName{
  static const String cashTask="cashTask";
  static const String tba="tba";
  static const String rankTask="rankTask";
}


abstract class P1Sql{
  Future<Database> initDB()async{
    var db = await openDatabase(
        "solitaire.db",
        version: 2,
        onCreate: (db,version)async{
          db.execute('CREATE TABLE ${TableName.cashTask} (id INTEGER PRIMARY KEY AUTOINCREMENT, cashType INTEGER, amount INTEGER, account TEXT, cashTask TEXT, cashTaskIndex INTEGER, currentPro INTEGER, totalPro INTEGER)');
          db.execute('CREATE TABLE ${TableName.tba} (id INTEGER PRIMARY KEY AUTOINCREMENT, dataMap TEXT)');
          _createVersion2DB(db);
        },
        onUpgrade: (db,oldVersion,newVersion){
          if(newVersion==2){
            _createVersion2DB(db);
          }
        }
    );
    return db;
  }

  _createVersion2DB(Database db){
    db.execute('CREATE TABLE ${TableName.rankTask} (id INTEGER PRIMARY KEY AUTOINCREMENT, cashType INTEGER, amount INTEGER, account TEXT, currentPro INTEGER, totalPro INTEGER)');
  }
}