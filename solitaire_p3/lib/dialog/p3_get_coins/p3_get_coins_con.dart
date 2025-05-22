import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/firebase_hep.dart';
import 'package:solitaire_p1/p1_hep/p1_ad.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_hep/point/ad_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/dialog/p3_get_coins/p3_get_coins_dialog.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';

class P3GetCoinsCon extends P1BaseCon{
  GetCoinsEnum getCoinsEnum=GetCoinsEnum.other;

  @override
  void onInit() {
    super.onInit();
    PointHep.instance.point(pointEvent: PointEvent.claim_pop,);
  }

  clickDou(double addNum, Function()? dismiss){
    PointHep.instance.point(pointEvent: PointEvent.claim_pop_claim,params: {"pop_scene":getCoinsEnum.name});
    var showAdType = FirebaseHep.instance.getShowAdType(AdType.reward);
    P1AD.instance.showAdByBPackage(
      adType: showAdType,
      showAd: P3ValueHep.instance.showIntAd(showAdType),
      adEvent: AdEvent.vvslt_obtainpop_rv,
      popScene: getCoinsEnum.name,
      closeAd: (){
        P1RouterFun.closePage();
        P3UserInfoHep.instance.updateUserCoins(addNum*2);
        dismiss?.call();
      },
    );
  }

  clickSingle(double addNum, Function()? dismiss){
    PointHep.instance.point(pointEvent: PointEvent.claim_pop_claim_single,params: {"pop_scene":getCoinsEnum.name});
    var showAdType = FirebaseHep.instance.getShowAdType(AdType.interstitial);
    P1AD.instance.showAdByBPackage(
      adType: showAdType,
      showAd: P3ValueHep.instance.showIntAd(showAdType),
      adEvent: AdEvent.vvslt_obtainpopclose_int,
      popScene: getCoinsEnum.name,
      closeAd: (){
        P1RouterFun.closePage();
        P3UserInfoHep.instance.updateUserCoins(addNum);
        dismiss?.call();
      },
    );
  }

  clickClose(Function()? dismiss){
    PointHep.instance.point(pointEvent: PointEvent.claim_pop_close,params: {"pop_scene":getCoinsEnum.name});
    var showAdType = FirebaseHep.instance.getShowAdType(AdType.interstitial);
    P1AD.instance.showAdByBPackage(
      adType: showAdType,
      showAd: P3ValueHep.instance.showIntAd(showAdType),
      adEvent: AdEvent.vvslt_obtainpopclose_int,
      popScene: getCoinsEnum.name,
      closeAd: (){
        P1RouterFun.closePage();
        dismiss?.call();
      },
    );
  }
}