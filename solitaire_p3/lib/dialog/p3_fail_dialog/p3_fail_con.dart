import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_ad.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_hep/point/ad_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/hep/p3_routers_name.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';

class P3FailCon extends P1BaseCon{
  bool hasMoney=p3Coins.getData()>=2000;

  @override
  void onInit() {
    super.onInit();
    PointHep.instance.point(pointEvent: PointEvent.game_page_fail,params: {"level":p3CurrentLevel.getData()});
  }

  clickLeft(){
    PointHep.instance.point(pointEvent: PointEvent.fail_replay_c,params: {"level":p3CurrentLevel.getData()});
    if(hasMoney){
      P1RouterFun.closePage();
      P1EventBean(code: P3EventCode.replayGame).send();
    }else{
      clickHome();
    }
  }

  clickRight(){
    PointHep.instance.point(pointEvent: PointEvent.fail_getcards_c,params: {"level":p3CurrentLevel.getData()});
    P1RouterFun.closePage();
    if(hasMoney){
      P3UserInfoHep.instance.updateUserCoins(-2000);
      P1EventBean(code: P3EventCode.getFiveCards).send();
    }else{
      P1EventBean(code: P3EventCode.replayGame).send();
    }
  }

  clickHome(){
    P1AD.instance.showAdByBPackage(
      adType: AdType.interstitial,
      showAd: P3ValueHep.instance.showIntAd(AdType.interstitial),
      adEvent: AdEvent.vvslt_failpop_int,
      closeAd: (){
        PointHep.instance.point(pointEvent: PointEvent.fail_home_c,params: {"level":p3CurrentLevel.getData()});
        P1RouterFun.toHome(str: P3RoutersName.p3Home);
      },
    );
  }
}