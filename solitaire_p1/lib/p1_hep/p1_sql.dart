import 'package:sqflite/sqflite.dart';

class TableName{
  static const String cashTask="cashTask";
  static const String tba="tba";
}


abstract class P1Sql{
  Future<Database> initDB()async{
    var db = await openDatabase(
        "solitaire.db",
        version: 1,
        onCreate: (db,version)async{
          db.execute('CREATE TABLE ${TableName.cashTask} (id INTEGER PRIMARY KEY AUTOINCREMENT, cashType INTEGER, amount INTEGER, account TEXT, cashTask TEXT, cashTaskIndex INTEGER, currentPro INTEGER, totalPro INTEGER)');
          db.execute('CREATE TABLE ${TableName.tba} (id INTEGER PRIMARY KEY AUTOINCREMENT, dataMap TEXT)');
        },
        // onUpgrade: (db,oldVersion,newVersion){
        //   if(newVersion==2){
        //     _createVersion2DB(db);
        //   }else if(newVersion==3){
        //     _createVersion3DB(db);
        //   }
        // }
    );
    return db;
  }
}