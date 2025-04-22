import 'package:sqflite/sqflite.dart';

class TableName{
  static const String cashTask="cashTask";
}


abstract class P1Sql{
  Future<Database> initDB()async{
    var db = await openDatabase(
        "solitaire.db",
        version: 1,
        onCreate: (db,version)async{
          db.execute('CREATE TABLE ${TableName.cashTask} (id INTEGER PRIMARY KEY AUTOINCREMENT, cashType INTEGER, amount INTEGER, account TEXT, cashTask TEXT, currentPro INTEGER, totalPro INTEGER)');
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