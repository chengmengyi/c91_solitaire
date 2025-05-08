import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/local_notification_hep.dart';
import 'package:solitaire_p1/p1_hep/p1_ad.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_mp3_hep.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/dialog/p3_get_coins/p3_get_coins_dialog.dart';
import 'package:solitaire_p3/dialog/p3_lucky_card/p3_lucky_card_dialog.dart';
import 'package:solitaire_p3/dialog/p3_net_dialog/p3_net_dialog.dart';
import 'package:solitaire_p3/dialog/p3_wheel_dialog/p3_wheel_dialog.dart';
import 'package:solitaire_p3/hep/cash/cash_enums.dart';
import 'package:solitaire_p3/hep/cash/cash_task_hep.dart';
import 'package:solitaire_p3/hep/guide/guide_hep.dart';
import 'package:solitaire_p3/hep/p3_routers_name.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';

class P3HomeCon extends P1BaseCon{
  var currentLevel=p3CurrentLevel.getData();
  GlobalKey playGlobalKey=GlobalKey();

  @override
  void onInit() {
    super.onInit();
    P1Mp3Hep.instance.playBgMp3();
    PointHep.instance.point(pointEvent: PointEvent.home_page);
    LocalNotificationHep.instance.setLocalNotifications();
    LocalNotificationHep.instance.checkFromIcon();
  }

  @override
  void onReady() {
    super.onReady();
    _checkShowGuide();
  }

  clickPlay(){
    PointHep.instance.point(pointEvent: PointEvent.home_page_cash);
    var routerName = _getRouterNameByLevel();
    if(routerName.isNotEmpty){
      P1RouterFun.toNextPage(str: routerName);
    }
  }

  clickCash(){
    PointHep.instance.point(pointEvent: PointEvent.home_page_withdraw);
    P1RouterFun.toNextPage(str: P3RoutersName.p3cash);
  }

  clickStart(){
    if(getProgress()>=1.0){
      clickCash();
    }else{
      clickPlay();
    }
  }

  String _getRouterNameByLevel(){
    var i = (p3CurrentLevel.getData()-1)%60+1;
    if(i<=10){
      return P3RoutersName.p3Level10;
    }else if(i<=20){
      return P3RoutersName.p3Level20;
    }else if(i<=30){
      return P3RoutersName.p3Level30;
    }else if(i<=40){
      return P3RoutersName.p3Level40;
    }else if(i<=50){
      return P3RoutersName.p3Level60;
    }else if(i<=60){
      return P3RoutersName.p3Level90;
    }
    // if(i<=10){
    //   return P3RoutersName.p3Level10;
    // }else if(i<=20){
    //   return P3RoutersName.p3Level20;
    // }else if(i<=30){
    //   return P3RoutersName.p3Level30;
    // }else if(i<=40){
    //   return P3RoutersName.p3Level40;
    // }else if(i<=50){
    //   return P3RoutersName.p3Level50;
    // }else if(i<=60){
    //   return P3RoutersName.p3Level60;
    // }else if(i<=70){
    //   return P3RoutersName.p3Level70;
    // }else if(i<=90){
    //   return P3RoutersName.p3Level90;
    // }
    return "";
  }

  clickTest(){
    if(!kDebugMode){
      return;
    }
    // p3CurrentLevel.saveData(1);
    // P3UserInfoHep.instance.updateLevel();
    // P3UserInfoHep.instance.updateUserCoins(200.03);
    // P1Mp3Hep.instance.test();
    // P3UserInfoHep.instance.updateTopPro(2);

    // _checkShowGuide();

    // P1RouterFun.showDialog(w: P3NetDialog());

    // CashTaskHep.instance.updateCashTask(CashTask.wannengka);


    P1Mp3Hep.instance.playMusic();
  }

  double getProgress(){
    var d = p3Coins.getData()/200;
    if(d<=0){
      return 0;
    }else if(d>=1.0){
      return 1.0;
    }else{
      return d;
    }
  }

  _checkShowGuide(){
    GuideHep.instance.showGuideStep1(
      context: context,
      clickCall: (){
        GuideHep.instance.showGuideStep2(context: context, globalKey: playGlobalKey);
      },
    );
  }

  @override
  bool registerP1Event() => true;

  @override
  onListenP1Event(P1EventBean bean) {
    switch(bean.code){
      case P3EventCode.updateLevel:
        currentLevel=p3CurrentLevel.getData();
        update(["level"]);
        break;
      case P3EventCode.updateCoins:
        update(["progress"]);
        break;
      case P3EventCode.showNewUserGuide8:
        GuideHep.instance.showGuideStep8(context: context, globalKey: playGlobalKey);
        break;
    }
  }
}