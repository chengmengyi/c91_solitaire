import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/firebase_hep.dart';
import 'package:solitaire_p1/p1_hep/p1_ad.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_hep/point/ad_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';

class P3WinnerCon extends P1BaseCon{
  @override
  void onInit() {
    super.onInit();
    PointHep.instance.point(pointEvent: PointEvent.game_page_victory,params: {"level":p3CurrentLevel.getData()});
  }

  clickNext(Function() next){
    var showAdType = FirebaseHep.instance.getShowAdType(AdType.interstitial);
    P1AD.instance.showAdByBPackage(
      adType: showAdType,
      showAd: P3ValueHep.instance.showIntAd(showAdType),
      adEvent: AdEvent.vvslt_victorypop_int,
      closeAd: (){
        PointHep.instance.point(pointEvent: PointEvent.game_next_c,params: {"level":p3CurrentLevel.getData()});
        P1RouterFun.closePage();
        next.call();
      },
    );
  }

  clickHome(Function() close){
    var showAdType = FirebaseHep.instance.getShowAdType(AdType.interstitial);
    P1AD.instance.showAdByBPackage(
      adType: showAdType,
      showAd: P3ValueHep.instance.showIntAd(showAdType),
      adEvent: AdEvent.vvslt_victorypop_int,
      closeAd: (){
        PointHep.instance.point(pointEvent: PointEvent.game_home_c,params: {"level":p3CurrentLevel.getData()});
        P1RouterFun.closePage();
        close.call();
      },
    );
  }
}