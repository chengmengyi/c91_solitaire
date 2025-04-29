import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_ad.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p2/hep/p2_storage.dart';
import 'package:solitaire_p2/hep/p2_user_info_hep.dart';

class P2BuyWanNengCardCon extends P1BaseCon{
  late ShakeAnimationController shakeAnimationController;

  @override
  void onInit() {
    super.onInit();
    shakeAnimationController=ShakeAnimationController();
  }


  clickCoins(Function() hasWanNengCall){
    if(p2Coins.getData()<2000){
      shakeAnimationController.start();
      return;
    }else{
      P2UserInfoHep.instance.updateUserCoins(-2000);
      hasWanNengCall.call();
      P1RouterFun.closePage();
    }
  }

  clickVideo(Function() hasWanNengCall){
    P1AD.instance.showAdByAPackage(
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