import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p2/hep/p2_storage.dart';
import 'package:solitaire_p2/hep/p2_user_info_hep.dart';

class P2BuyLongJuanCardCon extends P1BaseCon{
  clickCoins(Function() hasLongJuanCall){
    if(p2Coins.getData()<2000){
      P1RouterFun.closePage();
      P1EventBean(code: P2EventCode.buyWanNengCardNoMoney).send();
      return;
    }else{
      P2UserInfoHep.instance.updateUserCoins(-2000);
      hasLongJuanCall.call();
      P1RouterFun.closePage();
    }
  }

  clickVideo(){

  }

  clickClose(){
    P1RouterFun.closePage();
  }
}