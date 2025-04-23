import 'package:solitaire_p1/p1_hep/p1_sql.dart';
import 'package:solitaire_p3/bean/cash_task_bean.dart';
import 'package:solitaire_p3/hep/cash/cash_enums.dart';

class CashTaskHep extends P1Sql{
  static final CashTaskHep _instance = CashTaskHep();
  static CashTaskHep get instance => _instance;

  createCashTask(int cashType,int amount,String account)async{
    var database = await initDB();
    var list = await database.query(TableName.cashTask,where: '"cashType" = ? AND "amount" = ?',whereArgs: [cashType,account]);
    if(list.isNotEmpty){
      return;
    }
    var bean = CashTaskBean(cashType: cashType,amount: amount,cashTask: CashTask.pass5Level,currentPro: 0,totalPro: 5,account: account);
    await database.insert(TableName.cashTask, bean.toJson());
  }

  updateCashTask(String cashTask)async{
    var database = await initDB();
    var list = await database.query(TableName.cashTask,where: '"cashTask" = ? ',whereArgs: [cashTask]);
    if(list.isEmpty){
      return;
    }
    for (var value in list) {
      var bean = CashTaskBean.fromJson(value);
      bean.currentPro=(bean.currentPro??0)+1;
      if((bean.currentPro??0)>=(bean.totalPro??0)){
        var nextTask = _getNextTask(cashTask);
        bean.cashTask=nextTask;
        bean.currentPro=0;
        bean.totalPro=_getTotalProByTask(nextTask);
      }
      await database.update(TableName.cashTask, bean.toJson(),where: '"id" = ?',whereArgs: [value["id"]]);
    }
  }

  int _getTotalProByTask(String cashTask){
    switch(cashTask){
      case CashTask.pass5Level: return 5;
      case CashTask.pass2Card: return 2;
      case CashTask.use5Wanneng: return 5;
      case CashTask.get5Longjuanfeng: return 5;
      default: return 5;
    }
  }

  String _getNextTask(String currentTask){
    switch(currentTask){
      case CashTask.pass5Level: return CashTask.pass2Card;
      case CashTask.pass2Card: return CashTask.use5Wanneng;
      case CashTask.use5Wanneng: return CashTask.get5Longjuanfeng;
      case CashTask.get5Longjuanfeng: return CashTask.complete;
      default: return CashTask.pass5Level;
    }
  }

  test()async{
    await updateCashTask(CashTask.pass5Level);

    var database = await initDB();
    var list = await database.query(TableName.cashTask);
    print(list);
  }
}