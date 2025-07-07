import 'package:flutter/foundation.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_sql.dart';
import 'package:solitaire_p3/bean/cash_task_bean.dart';
import 'package:solitaire_p3/bean/rank_task_bean.dart';
import 'package:solitaire_p3/hep/cash/cash_enums.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';

class CashTaskHep extends P1Sql{
  static final CashTaskHep _instance = CashTaskHep();
  static CashTaskHep get instance => _instance;

  Future<RankTaskBean> createRankTask(int cashType,int amount,String account)async{
    var database = await initDB();
    var list = await database.query(TableName.rankTask,where: '"cashType" = ? AND "amount" = ?',whereArgs: [cashType,amount]);
    if(list.isNotEmpty){
      return RankTaskBean.fromJson(list.first);
    }
    var bean = RankTaskBean(
      cashType: cashType,
      amount: amount,
      currentPro: P3ValueHep.instance.getCurrentQueueNumber()?.intAll??99,
      totalPro: P3ValueHep.instance.getAllQueueNumber()?.intAll??388,
      account: account,
    );
    await database.insert(TableName.rankTask, bean.toJson());
    return bean;
  }

  Future<RankTaskBean?>  queryRankTaskNotComplete(int cashType,int amount)async{
    var database = await initDB();
    var list = await database.query(TableName.rankTask,where: '"cashType" = ? AND "amount" = ?',whereArgs: [cashType,amount]);
    if(list.isEmpty){
      return null;
    }
    var rankTaskBean = RankTaskBean.fromJson(list.first);
    if((rankTaskBean.currentPro??0)<=1){
      return null;
    }
    return rankTaskBean;
  }

  Future<RankTaskBean?> updateRankTask(RankTaskBean? rankTaskBean)async{
    var database = await initDB();
    var list = await database.query(TableName.rankTask,where: '"cashType" = ? AND "amount" = ?',whereArgs: [rankTaskBean?.cashType,rankTaskBean?.amount]);
    if(list.isEmpty){
      return null;
    }
    var value = RankTaskBean.fromJson(list.first);
    value.currentPro=(value.currentPro??0)-P3ValueHep.instance.getCurrentReduce();
    value.totalPro=(value.totalPro??0)-P3ValueHep.instance.getAllReduce();
    if((value.currentPro??0)<=0){
      value.currentPro=1;
    }
    if((value.totalPro??0)<=0){
      value.totalPro=1;
    }
    await database.update(TableName.rankTask, value.toJson(),where: '"id" = ?',whereArgs: [list.first["id"]]);
    if((value.currentPro??0)<=1){
      await CashTaskHep.instance.createCashTask(rankTaskBean?.cashType??CashType.cashApp, rankTaskBean?.amount??0, rankTaskBean?.account??"");
      P1EventBean(code: P3EventCode.updateCashList).send();
    }
    return value;
  }

  createCashTask(int cashType,int amount,String account)async{
    var database = await initDB();
    var list = await database.query(TableName.cashTask,where: '"cashType" = ? AND "amount" = ?',whereArgs: [cashType,amount]);
    if(list.isNotEmpty){
      return;
    }
    var bean = CashTaskBean(cashType: cashType,amount: amount,cashTask: CashTask.level,cashTaskIndex: 0,currentPro: 0,totalPro: kDebugMode?2:10,account: account);
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
        var nextIndex = (bean.cashTaskIndex??0)+1;
        bean.cashTaskIndex=nextIndex;
        //全部完成了
        if(nextIndex>5){
          bean.cashTask=CashTask.complete;
        }else{
          var nextTask = _getNextTask(nextIndex);
          bean.cashTask=nextTask;
          bean.currentPro=0;
          bean.totalPro=_getTotalProByTask(nextIndex);
        }
      }
      await database.update(TableName.cashTask, bean.toJson(),where: '"id" = ?',whereArgs: [value["id"]]);
    }
    P1EventBean(code: P3EventCode.updateCashList).send();
  }

  Future<CashTaskBean?> queryCashTaskByCashTypeAmount({required int cashType,required int amount})async{
    var database = await initDB();
    var list = await database.query(TableName.cashTask,where: '"cashType" = ? AND "amount" = ?',whereArgs: [cashType,amount]);
    if(list.isEmpty){
      return null;
    }
    return CashTaskBean.fromJson(list.first);
  }

  Future<CashTaskBean?> queryCashTaskNoCompleted()async{
    var database = await initDB();
    var list = await database.query(TableName.cashTask,where: '"cashTask" != ?',whereArgs: [CashTask.complete]);
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

  int _getTotalProByTask(int cashIndex){
    if(kDebugMode){
      switch(cashIndex){
        case 0:
        case 1:
        case 2:
        case 3:
        case 5:
          return 2;
        case 4:
          return 2;
        default:
          return 2;
      }
    }
    switch(cashIndex){
      case 0:
      case 1:
      case 2:
      case 3:
      case 5:
        return 10;
      case 4:
        return 20;
      default:
        return 20;
    }
  }

  String _getNextTask(int taskIndex){
    switch(taskIndex){
      case 0:
      case 4:
        return CashTask.level;
      case 1:
      case 5:
        return CashTask.wannengka;
      case 2:
        return CashTask.longjuanfeng;
      case 3:
        return CashTask.luckyCard;
      default:
        return CashTask.complete;
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