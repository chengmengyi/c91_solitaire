import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/hep/p3_routers_name.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';

class P3FailCon extends P1BaseCon{
  bool hasMoney=p3Coins.getData()>=2000;

  clickLeft(){
    if(hasMoney){
      P1RouterFun.closePage();
      P1EventBean(code: P3EventCode.replayGame).send();
    }else{
      clickHome();
    }
  }

  clickRight(){
    P1RouterFun.closePage();
    if(hasMoney){
      P3UserInfoHep.instance.updateUserCoins(-2000);
      P1EventBean(code: P3EventCode.getFiveCards).send();
    }else{
      P1EventBean(code: P3EventCode.replayGame).send();
    }
  }

  clickHome(){
    P1RouterFun.toHome(str: P3RoutersName.p3Home);
  }
}