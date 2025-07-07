import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/bean/cash_task_bean.dart';
import 'package:solitaire_p3/dialog/p3_get_coins/p3_get_coins_dialog.dart';
import 'package:solitaire_p3/dialog/p3_net_dialog/p3_net_dialog.dart';
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
    case CashTask.level: return "task_level";
    case CashTask.wannengka: return "task_wanneng";
    case CashTask.longjuanfeng: return "task_longjuanfeng";
    case CashTask.luckyCard: return "task_card";
    default: return "task_level";
  }
}

String getTaskStr(CashTaskBean bean){
  switch(bean.cashTask){
    case CashTask.level: return "Complete the game ${bean.totalPro??0} more times";
    case CashTask.wannengka: return "Use ${bean.totalPro??0} cards";
    case CashTask.longjuanfeng: return "Use ${bean.totalPro??0} shurikens";
    case CashTask.luckyCard: return "Tap ${bean.totalPro??0} cards";
    default: return "Completed";
  }
}

showGetCoinsDialog(double addNum, GetCoinsEnum getCoinsEnum,{Function()? dismiss})async{
  var connectivityResult = await (Connectivity().checkConnectivity());
  if(connectivityResult.contains(ConnectivityResult.none)){
    P1RouterFun.showDialog(w: P3NetDialog(getCoinsEnum: getCoinsEnum,dismiss: dismiss,));
    return;
  }
  P1RouterFun.showDialog(w: P3GetCoinsDialog(addNum: addNum,getCoinsEnum: getCoinsEnum,dismiss: dismiss,));
}

String generatePhoneNumber() {
  final prefixList = ['130', '131', '132', '133', '134', '135', '136', '137', '138', '139',
    '150', '151', '152', '153', '155', '156', '157', '158', '159',
    '170', '171', '172', '173', '175', '176', '177', '178', '179',
    '180', '181', '182', '183', '184', '185', '186', '187', '188', '189'];
  final random = Random();
  final prefix = prefixList[random.nextInt(prefixList.length)];
  final suffix = List.generate(8, (_) => random.nextInt(10)).join(); // 8 digits
  return prefix + suffix;
}

String generateEmail() {
  final random = Random();
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  String username = List.generate(6 + random.nextInt(5), (index) => chars[random.nextInt(chars.length)]).join();
  const domains = ['gmail.com', 'yahoo.com', 'outlook.com'];
  String domain = domains[random.nextInt(domains.length)];
  return '$username@$domain';
}

bool isEmail(String input) {
  final emailRegex = RegExp(
    r'^[\w\.-]+@[\w\.-]+\.\w+$',
  );
  return emailRegex.hasMatch(input);
}