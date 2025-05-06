import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/bean/cash_task_bean.dart';
import 'package:solitaire_p3/hep/cash/cash_enums.dart';

String getCardImageIcon(CardBean bean){
  if(bean.covered){
    return "card_back";
  }else{
    var cardNum=0;
    switch(bean.cardNum){
      case "A":
        cardNum=1;
        break;
      case "J":
        cardNum=11;
        break;
      case "Q":
        cardNum=12;
        break;
      case "K":
        cardNum=13;
        break;
      default:
        cardNum=bean.cardNum.toInt();
        break;
    }
    return "${bean.cardType.name}$cardNum";
  }
}

String getTaskIcon(CashTaskBean bean){
  switch(bean.cashTask){
    case CashTask.task1: return "task_level";
    case CashTask.task2: return "task_wanneng";
    case CashTask.task3: return "task_longjuanfeng";
    default: return "task_level";
  }
}

String getTaskStr(CashTaskBean bean){
  switch(bean.cashTask){
    case CashTask.task1:
      if((bean.currentPro??0)<(bean.totalPro??0)){
        return "Complete the game 5 more times";
      }else{
        return "Tap 2 cards";
      }
    case CashTask.task2: return "Use 5 cards";
    case CashTask.task3: return "Use 5 shurikens";
    default: return "Completed";
  }
}