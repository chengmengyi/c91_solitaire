import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_ad.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_hep/point/ad_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/dialog/p3_get_coins/p3_get_coins_dialog.dart';
import 'package:solitaire_p3/hep/cash/cash_enums.dart';
import 'package:solitaire_p3/hep/cash/cash_task_hep.dart';
import 'package:solitaire_p3/hep/hep.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';

class P3LuckyCardCon extends P1BaseCon{
  var addNum=P3ValueHep.instance.getLuckyCardAddNum();

  @override
  void onInit() {
    super.onInit();
    PointHep.instance.point(pointEvent: PointEvent.card_view,params: {"level":p3CurrentLevel.getData()});
  }

  clickClose(){
    P1AD.instance.showAdByBPackage(
      adType: AdType.interstitial,
      showAd: P3ValueHep.instance.showIntAd(AdType.interstitial),
      adEvent: AdEvent.vvslt_floppopclose_int,
      closeAd: (){
        P3UserInfoHep.instance.updateTopPro(-5);
        P1RouterFun.closePage();
      },
    );
  }

  clickCard(){
    PointHep.instance.point(pointEvent: PointEvent.card_click,params: {"level":p3CurrentLevel.getData()});
    Future.delayed(const Duration(milliseconds: 2500),(){
      CashTaskHep.instance.updateCashTask(CashTask.luckyCard);
      P3UserInfoHep.instance.updateTopPro(-5);
      P1RouterFun.closePage();
      showGetCoinsDialog(addNum, GetCoinsEnum.card);
    });
  }
}