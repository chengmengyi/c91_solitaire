import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_ad.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';

class P3BuyLongJuanCardCon extends P1BaseCon{
  late ShakeAnimationController shakeAnimationController;

  @override
  void onInit() {
    super.onInit();
    shakeAnimationController=ShakeAnimationController();
  }

  clickCoins(Function() hasLongJuanCall){
    if(p3Coins.getData()<2000){
      shakeAnimationController.start();
      // P1RouterFun.closePage();
      // P1EventBean(code: P2EventCode.buyWanNengCardNoMoney).send();
      return;
    }else{
      P3UserInfoHep.instance.updateUserCoins(-2000);
      hasLongJuanCall.call();
      P1RouterFun.closePage();
    }
  }

  clickVideo(Function() hasLongJuanCall){
    P1AD.instance.showAd(
      closeAd: (){
        hasLongJuanCall.call();
        P1RouterFun.closePage();
      },
    );
  }

  clickClose(){
    P1RouterFun.closePage();
  }
}