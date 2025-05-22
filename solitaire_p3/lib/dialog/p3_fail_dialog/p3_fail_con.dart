import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/firebase_hep.dart';
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

  @override
  void onInit() {
    super.onInit();
    PointHep.instance.point(pointEvent: PointEvent.game_page_fail,params: {"level":p3CurrentLevel.getData()});
  }

  clickLeft(){
    PointHep.instance.point(pointEvent: PointEvent.fail_replay_c,params: {"level":p3CurrentLevel.getData()});
    P1RouterFun.closePage();
    P1EventBean(code: P3EventCode.replayGame).send();
  }

  clickRight(){
    PointHep.instance.point(pointEvent: PointEvent.fail_getcards_c,params: {"level":p3CurrentLevel.getData()});
    var showAdType = FirebaseHep.instance.getShowAdType(AdType.reward);
    P1AD.instance.showAdByBPackage(
      adType: showAdType,
      showAd: P3ValueHep.instance.showIntAd(showAdType),
      adEvent: AdEvent.vvslt_failpop_rv,
      closeAd: (){
        P1EventBean(code: P3EventCode.getFiveCards).send();
        P1RouterFun.closePage();
      },
    );
  }

  clickHome(){
    PointHep.instance.point(pointEvent: PointEvent.fail_home_c,params: {"level":p3CurrentLevel.getData()});
    var showAdType = FirebaseHep.instance.getShowAdType(AdType.interstitial);
    P1AD.instance.showAdByBPackage(
      adType: showAdType,
      showAd: P3ValueHep.instance.showIntAd(showAdType),
      adEvent: AdEvent.vvslt_failpop_int,
      closeAd: (){
        P1RouterFun.toHome(str: P3RoutersName.p3Home);
      },
    );
  }
}