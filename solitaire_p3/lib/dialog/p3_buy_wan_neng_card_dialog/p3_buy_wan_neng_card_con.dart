import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/firebase_hep.dart';
import 'package:solitaire_p1/p1_hep/p1_ad.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_hep/point/ad_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';

class P3BuyWanNengCardCon extends P1BaseCon{
  late ShakeAnimationController shakeAnimationController;

  @override
  void onInit() {
    super.onInit();
    shakeAnimationController=ShakeAnimationController();
    PointHep.instance.point(pointEvent: PointEvent.wild_card_page,);
  }


  // clickCoins(Function() hasWanNengCall){
  //   if(p3Coins.getData()<2000){
  //     shakeAnimationController.start();
  //     return;
  //   }else{
  //     P3UserInfoHep.instance.updateUserCoins(-2000);
  //     hasWanNengCall.call();
  //     P1RouterFun.closePage();
  //   }
  // }

  clickVideo(Function() hasWanNengCall){
    PointHep.instance.point(pointEvent: PointEvent.wild_collect_c,);
    var adType = FirebaseHep.instance.getShowAdType(AdType.reward);
    P1AD.instance.showAdByBPackage(
      adType: adType,
      showAd: P3ValueHep.instance.showIntAd(adType),
      adEvent: AdEvent.vvslt_wildcar_rv,
      closeAd: (){
        hasWanNengCall.call();
        P1RouterFun.closePage();
      },
    );
  }

  clickClose(){
    P1RouterFun.closePage();
  }
}