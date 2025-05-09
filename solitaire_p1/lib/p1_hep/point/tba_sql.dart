import 'dart:convert';

import 'package:solitaire_p1/p1_hep/p1_sql.dart';

class TbaSql extends P1Sql{
  static final TbaSql _instance = TbaSql();
  static TbaSql get instance => _instance;


  insertTbaMap(Map<String,dynamic> map)async{
    var db = await initDB();
    db.insert(TableName.tba, {"dataMap":jsonEncode(map)});
  }

  Future<List<Map<String, Object?>>> queryTbaMap()async{
    var db = await initDB();
    return await db.query(TableName.tba);
  }

  removeTbaMap()async{
    var db = await initDB();
    db.delete(TableName.tba);
  }
}