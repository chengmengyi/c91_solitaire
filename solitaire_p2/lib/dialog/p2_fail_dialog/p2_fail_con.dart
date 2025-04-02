import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p2/hep/p2_routers_name.dart';
import 'package:solitaire_p2/hep/p2_storage.dart';
import 'package:solitaire_p2/hep/p2_user_info_hep.dart';

class P2FailCon extends P1BaseCon{
  bool hasMoney=p2Coins.getData()>=2000;

  clickLeft(){
    if(hasMoney){
      P1RouterFun.closePage();
      P1EventBean(code: P2EventCode.replayGame).send();
    }else{
      clickHome();
    }
  }

  clickRight(){
    P1RouterFun.closePage();
    if(hasMoney){
      P2UserInfoHep.instance.updateUserCoins(-2000);
      P1EventBean(code: P2EventCode.getFiveCards).send();
    }else{
      P1EventBean(code: P2EventCode.replayGame).send();
    }
  }

  clickHome(){
    P1RouterFun.toHome(str: P2RoutersName.p2Home);
  }
}