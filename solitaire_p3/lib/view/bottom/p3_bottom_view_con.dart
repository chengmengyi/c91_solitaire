import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_mp3_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/bean/random_card_bean.dart';
import 'package:solitaire_p3/dialog/p3_buy_long_juan_card_dialog/p3_buy_long_juan_card_dialog.dart';
import 'package:solitaire_p3/dialog/p3_buy_wan_neng_card_dialog/p3_buy_wan_neng_card_dialog.dart';
import 'package:solitaire_p3/hep/cash/cash_enums.dart';
import 'package:solitaire_p3/hep/cash/cash_task_hep.dart';
import 'package:solitaire_p3/hep/p3_card_hep.dart';
import 'package:solitaire_p3/hep/p3_play.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';

class P2BottomViewCon extends P1BaseCon{
  late P3Play p3play;

  clickWanNeng(){
    if(!p3play.canClick){
      return;
    }
    P1RouterFun.showDialog(
      w: P3BuyWanNengCardDialog(
        hasWanNengCall: (){
          p3play.hasWanNengCard();
          update(["hand_card"]);
        },
      ),
    );
  }

  clickLongJuanFeng(){
    if(!p3play.canClick){
      return;
    }
    P1RouterFun.showDialog(
      w: P2BuyLongJuanDialog(
        hasLongJuanCall: (){
          CashTaskHep.instance.updateCashTask(CashTask.task3,CashTaskType.get5Longjuanfeng);
          List<CardBean> list=[];
          for (var value in p3play.cardList) {
            for (var value1 in value) {
              if(value1.show&&!value1.covered&&value1.cardNum!="-1"){
                list.add(value1);
              }
            }
          }
          P1EventBean(code: P3EventCode.showLongJuanFengLottie,anyValue: list).send();
        },
      ),
    );
  }

  changeHandCard(){
    if(!p3play.canClick){
      return;
    }
    p3play.changeHandCard((){
      update(["hand_card_num","hand_card"]);
      p3play.checkShowGuideStep3(context);
    });
  }

  @override
  bool registerP1Event() => true;

  @override
  onListenP1Event(P1EventBean bean) {
    switch(bean.code){
      case P3EventCode.updateHandCard:
        update(["hand_card_num","hand_card"]);
        break;
      case P3EventCode.getFiveCards:
        p3play.getFiveCards(
          call: (){
            update(["hand_card_num","hand_card"]);
          }
        );
        break;
      case P3EventCode.removeHandCard:
        _removeHandCard();
        break;
    }
  }

  _removeHandCard()async{
    if(p3play.currentHandsNum<=0){
      return;
    }
    while(p3play.currentHandsNum>0){
      p3play.removeHandCard();
      update(["hand_card_num"]);
      P1Mp3Hep.instance.playXiaoChu();
      P3UserInfoHep.instance.updateUserCoins(100);
      await Future.delayed(const Duration(milliseconds: 1000));
    }
    p3play.showWinnerDialog();
  }
}