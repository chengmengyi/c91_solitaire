import 'package:solitaire_p1/p1_hep/p1_sql.dart';
import 'package:solitaire_p3/bean/cash_task_bean.dart';
import 'package:solitaire_p3/hep/cash/cash_enums.dart';

class CashTaskHep extends P1Sql{
  static final CashTaskHep _instance = CashTaskHep();
  static CashTaskHep get instance => _instance;

  createCashTask(int cashType,int amount,String account)async{
    var database = await initDB();
    var list = await database.query(TableName.cashTask,where: '"cashType" = ? AND "amount" = ?',whereArgs: [cashType,amount]);
    if(list.isNotEmpty){
      return;
    }
    var bean = CashTaskBean(cashType: cashType,amount: amount,cashTask: CashTask.task1,currentPro: 0,totalPro: 5,currentPro2: 0,totalPro2: 2,account: account);
    await database.insert(TableName.cashTask, bean.toJson());
  }

  updateCashTask(String cashTask,String cashTaskType)async{
    var database = await initDB();
    var list = await database.query(TableName.cashTask,where: '"cashTask" = ? ',whereArgs: [cashTask]);
    if(list.isEmpty){
      return;
    }

    for (var value in list) {
      var bean = CashTaskBean.fromJson(value);
      if(bean.cashTask==CashTask.task1){
        if(cashTaskType==CashTaskType.pass5Level){
          bean.currentPro=(bean.currentPro??0)+1;
        }
        if(cashTaskType==CashTaskType.pass2Card){
          bean.currentPro2=(bean.currentPro2??0)+1;
        }
        if((bean.currentPro??0)>=(bean.totalPro??0)&&(bean.currentPro2??0)>=(bean.totalPro2??0)){
          var nextTask = _getNextTask(cashTask);
          bean.cashTask=nextTask;
          bean.currentPro=0;
          bean.totalPro=_getTotalProByTask(nextTask);
        }
      }else{
        bean.currentPro=(bean.currentPro??0)+1;
        if((bean.currentPro??0)>=(bean.totalPro??0)){
          var nextTask = _getNextTask(cashTask);
          bean.cashTask=nextTask;
          bean.currentPro=0;
          bean.totalPro=_getTotalProByTask(nextTask);
        }
      }
      await database.update(TableName.cashTask, bean.toJson(),where: '"id" = ?',whereArgs: [value["id"]]);
    }
  }

  Future<CashTaskBean?> queryCashTaskByCashTypeAmount({required int cashType,required int amount})async{
    var database = await initDB();
    var list = await database.query(TableName.cashTask,where: '"cashType" = ? AND "amount" = ?',whereArgs: [cashType,amount]);
    if(list.isEmpty){
      return null;
    }
    return CashTaskBean.fromJson(list.first);
  }

  deleteCashTaskByByCashTypeAmount({required int cashType,required int amount})async{
    var database = await initDB();
    var list = await database.query(TableName.cashTask,where: '"cashType" = ? AND "amount" = ?',whereArgs: [cashType,amount]);
    if(list.isEmpty){
      return;
    }
    await database.delete(TableName.cashTask,where: '"id" = ?',whereArgs: [list.first["id"]]);
  }

  int _getTotalProByTask(String cashTask){
    switch(cashTask){
      case CashTask.task2: return 5;
      case CashTask.task3: return 5;
      default: return 5;
    }
  }

  String _getNextTask(String currentTask){
    switch(currentTask){
      case CashTask.task1: return CashTask.task2;
      case CashTask.task2: return CashTask.task3;
      case CashTask.task3: return CashTask.complete;
      default: return CashTask.complete;
    }
  }

  test()async{
    // await updateCashTask(CashTask.pass5Level);
    //
    // var database = await initDB();
    // var list = await database.query(TableName.cashTask);
    // print(list);
  }
}