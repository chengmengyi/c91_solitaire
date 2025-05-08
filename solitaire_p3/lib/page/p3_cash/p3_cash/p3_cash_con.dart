import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/bean/amount_bean.dart';
import 'package:solitaire_p3/dialog/p3_cash_task1_dialog/p3_cash_task1_dialog.dart';
import 'package:solitaire_p3/dialog/p3_cash_task2_dialog/p3_cash_task2_dialog.dart';
import 'package:solitaire_p3/dialog/p3_cash_task3_dialog/p3_cash_task3_dialog.dart';
import 'package:solitaire_p3/dialog/p3_cash_task_completed/p3_cash_task_completed_dialog.dart';
import 'package:solitaire_p3/dialog/p3_no_money/p3_nomoney_dialog.dart';
import 'package:solitaire_p3/hep/cash/cash_enums.dart';
import 'package:solitaire_p3/hep/cash/cash_task_hep.dart';
import 'package:solitaire_p3/hep/guide/guide_hep.dart';
import 'package:solitaire_p3/hep/p3_routers_name.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';

class P3CashCon extends P1BaseCon{
  var cashType=CashType.cashApp;
  List<AmountBean> amountList=[];
  GlobalKey cashTypeGlobalKey=GlobalKey();
  GlobalKey cashMoneyGlobalKey=GlobalKey();

  @override
  void onInit() {
    super.onInit();
    _initList();
    PointHep.instance.point(pointEvent: PointEvent.cash_page);
  }

  @override
  void onReady() {
    super.onReady();
    GuideHep.instance.showGuideStep6(
      context: context,
      cashTypeGlobalKey: cashTypeGlobalKey,
      cashMoneyGlobalKey: cashMoneyGlobalKey,
      clickCashMoneyCall: (){
        clickAmount(0,fromGuide: true);
      }
    );
  }

  clickCashType(int index){
    if(cashType==index){
      return;
    }
    PointHep.instance.point(pointEvent: PointEvent.cash_page_change_method);
    cashType=index;
    update(["cash_type","list"]);
    _initList();
  }

  clickAmount(index,{bool fromGuide=false}){
    var bean = amountList[index];
    PointHep.instance.point(pointEvent: PointEvent.cash_page_withdraw,params: {"cash_numbers":bean.money});
    if(null!=bean.cashTaskBean){
      switch(bean.cashTaskBean?.cashTask){
        case CashTask.level:
        case CashTask.luckyCard:
          P1RouterFun.showDialog(
            w: P3CashTask1Dialog(
              bean: bean.cashTaskBean!,
              clickNow: (){
                P1RouterFun.closePage();
              },
            ),
          );
          break;
        case CashTask.wannengka:
          P1RouterFun.showDialog(
            w: P3CashTask2Dialog(
              bean: bean.cashTaskBean!,
              clickNow: (){
                P1RouterFun.closePage();
              },
            ),
          );
          break;
        case CashTask.longjuanfeng:
          P1RouterFun.showDialog(
            w: P3CashTask3Dialog(
              bean: bean.cashTaskBean!,
              clickNow: (){
                P1RouterFun.closePage();
              },
            ),
          );
          break;
        case CashTask.complete:
          P1RouterFun.showDialog(
            w: P3CashTaskCompletedDialog(
              bean: bean.cashTaskBean!,
            ),
          );
          break;
      }
      return;
    }
    if(p3Coins.getData()<bean.money){
      P1RouterFun.showDialog(
        w: P3NoMoneyDialog(
          clickNow: (){
            if(fromGuide){
              P1RouterFun.offAllUnit(routers: P3RoutersName.p3Home);
              P1EventBean(code: P3EventCode.showNewUserGuide8).send();
            }else{
              P1RouterFun.closePage();
            }
          },
        ),
      );
      return;
    }
    P1RouterFun.toNextPage(str: P3RoutersName.p3account,p: {"type":cashType,"amount":bean.money});
  }

  clickClose(){
    P1RouterFun.closePage();
  }

  _initList()async{
    amountList.clear();
    for (var value in P3ValueHep.instance.getCashAmountList()) {
      var taskBean = await CashTaskHep.instance.queryCashTaskByCashTypeAmount(cashType: cashType,amount: value);
      amountList.add(AmountBean(money: value, cashTaskBean: taskBean));
    }
    update(["list"]);
  }

  @override
  bool registerP1Event() => true;

  @override
  onListenP1Event(P1EventBean bean) {
    switch(bean.code){
      case P3EventCode.updateCashList:
        _initList();
        break;
      case P3EventCode.updateCoins:
        update(["coins"]);
        break;
    }
  }
}