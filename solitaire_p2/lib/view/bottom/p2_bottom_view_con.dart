import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_mp3_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p2/bean/card_bean.dart';
import 'package:solitaire_p2/bean/random_card_bean.dart';
import 'package:solitaire_p2/dialog/p2_buy_long_juan_card_dialog/p2_buy_long_juan_card_dialog.dart';
import 'package:solitaire_p2/dialog/p2_buy_wan_neng_card_dialog/p2_buy_wan_neng_card_dialog.dart';
import 'package:solitaire_p2/hep/p2_card_hep.dart';
import 'package:solitaire_p2/hep/p2_play.dart';
import 'package:solitaire_p2/hep/p2_user_info_hep.dart';

class P2BottomViewCon extends P1BaseCon{
  late P2Play p2play;

  clickWanNeng(){
    if(!p2play.canClick){
      return;
    }
    P1RouterFun.showDialog(
      w: P2BuyWanNengCardDialog(
        hasWanNengCall: (){
          p2play.hasWanNengCard();
          update(["hand_card"]);
        },
      ),
    );
  }

  clickLongJuanFeng(){
    if(!p2play.canClick){
      return;
    }
    P1RouterFun.showDialog(
      w: P2BuyLongJuanDialog(
        hasLongJuanCall: (){
          List<CardBean> list=[];
          for (var value in p2play.cardList) {
            for (var value1 in value) {
              if(value1.show&&!value1.covered&&value1.cardNum!="-1"){
                list.add(value1);
              }
            }
          }
          P1EventBean(code: P2EventCode.showLongJuanFengLottie,anyValue: list).send();
        },
      ),
    );
  }

  changeHandCard(){
    if(!p2play.canClick){
      return;
    }
    p2play.changeHandCard((){
      update(["hand_card_num","hand_card"]);
    });
  }

  @override
  bool registerP1Event() => true;

  @override
  onListenP1Event(P1EventBean bean) {
    switch(bean.code){
      case P2EventCode.updateHandCard:
        update(["hand_card_num","hand_card"]);
        break;
      case P2EventCode.getFiveCards:
        p2play.getFiveCards(
          call: (){
            update(["hand_card_num","hand_card"]);
          }
        );
        break;
      case P2EventCode.removeHandCard:
        _removeHandCard();
        break;
    }
  }

  _removeHandCard()async{
    if(p2play.currentHandsNum<=0){
      return;
    }
    while(p2play.currentHandsNum>0){
      p2play.removeHandCard();
      update(["hand_card_num"]);
      P1Mp3Hep.instance.playXiaoChu();
      P2UserInfoHep.instance.updateUserCoins(100);
      await Future.delayed(const Duration(milliseconds: 1000));
    }
    p2play.showWinnerDialog();
  }
}