import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/hep/cash/cash_enums.dart';
import 'package:solitaire_p3/hep/p3_routers_name.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';

class P3CashCon extends P1BaseCon{
  var cashType=CashType.cashApp;
  List<int> amountList=P3ValueHep.instance.getCashAmountList();

  clickCashType(int index){
    if(cashType==index){
      return;
    }
    cashType=index;
    update(["cash_type","list"]);
  }

  clickAmount(index){
    P1RouterFun.toNextPage(str: P3RoutersName.p3account,p: {"type":cashType,"amount":amountList[index]});
  }

  clickClose(){
    P1RouterFun.closePage();
  }
}