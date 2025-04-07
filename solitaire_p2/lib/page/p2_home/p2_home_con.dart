import 'package:flutter/foundation.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_ad.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p2/hep/hep.dart';
import 'package:solitaire_p2/hep/p2_routers_name.dart';
import 'package:solitaire_p2/hep/p2_storage.dart';
import 'package:solitaire_p2/hep/p2_user_info_hep.dart';

class P2HomeCon extends P1BaseCon{
  var currentLevel=p2CurrentLevel.getData();

  clickPlay(){
    var routerName = _getRouterNameByLevel();
    if(routerName.isNotEmpty){
      P1RouterFun.toNextPage(str: routerName);
    }
  }

  String _getRouterNameByLevel(){
    var i = (p2CurrentLevel.getData()-1)%20;
    if(i<=10){
      return P2RoutersName.p2Level10;
    }else if(i<=20){
      return P2RoutersName.p2Level20;
    }
    return "";
  }

  clickTest(){
    if(!kDebugMode){
      return;
    }
    // P2UserInfoHep.instance.updateUserCoins(1000);

    P1AD.instance.initAdInfo();
  }

  @override
  bool registerP1Event() => true;

  @override
  onListenP1Event(P1EventBean bean) {
    switch(bean.code){
      case P2EventCode.updateLevel:
        currentLevel=p2CurrentLevel.getData();
        update(["level"]);
        break;
    }
  }
}