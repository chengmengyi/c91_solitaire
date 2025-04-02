import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p2/hep/p2_storage.dart';

class P2BuyWanNengCardCon extends P1BaseCon{
  clickCoins(){
    if(p2Coins.getData()<2000){
      P1RouterFun.closePage();
      P1EventBean(code: P2EventCode.buyWanNengCardNoMoney).send();
      return;
    }
  }

  clickVideo(){

  }

  clickClose(){
    P1RouterFun.closePage();
  }
}