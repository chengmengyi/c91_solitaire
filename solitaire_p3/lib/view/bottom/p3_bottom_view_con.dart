import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_mp3_hep.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/bean/random_card_bean.dart';
import 'package:solitaire_p3/dialog/p3_buy_long_juan_card_dialog/p3_buy_long_juan_card_dialog.dart';
import 'package:solitaire_p3/dialog/p3_buy_wan_neng_card_dialog/p3_buy_wan_neng_card_dialog.dart';
import 'package:solitaire_p3/hep/cash/cash_enums.dart';
import 'package:solitaire_p3/hep/cash/cash_task_hep.dart';
import 'package:solitaire_p3/hep/guide/guide_hep.dart';
import 'package:solitaire_p3/hep/guide/longjuanfeng_guide_view.dart';
import 'package:solitaire_p3/hep/guide/wanneng_guide_view.dart';
import 'package:solitaire_p3/hep/p3_card_hep.dart';
import 'package:solitaire_p3/hep/p3_play.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';

class P2BottomViewCon extends P1BaseCon{
  late P3Play p3play;
  GlobalKey longjuanfengGlobalKey=GlobalKey();
  GlobalKey wannengGlobalKey=GlobalKey();

  clickWanNeng({fromGuide=false}){
    if(!p3play.canClick){
      return;
    }
    if(fromGuide){
      p3play.hasWanNengCard();
      update(["hand_card"]);
      p3ShowedLongJuanFengGuide.saveData(true);
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

  clickLongJuanFeng({fromGuide=false}){
    if(!p3play.canClick){
      return;
    }
    if(fromGuide){
      _useLongJuanFeng(fromGuide: fromGuide);
      return;
    }
    P1RouterFun.showDialog(
      w: P2BuyLongJuanDialog(
        hasLongJuanCall: (){
          _useLongJuanFeng();
        },
      ),
    );
  }

  _useLongJuanFeng({fromGuide=false}){
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
    if(fromGuide){
      Future.delayed(const Duration(milliseconds: 1000),(){
        _showWannengGuide();
      },);
    }
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
      case P3EventCode.showLongjuanfengGuide:
        _showLongjuanfengGuide();
        break;
    }
  }

  _showLongjuanfengGuide(){
    PointHep.instance.point(pointEvent: PointEvent.newuser_guide,params: {"pop_step":"pop5"});
    var renderBox = longjuanfengGlobalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    GuideHep.instance.showOverlay(
      context: context,
      widget: LongJuanFengGuideView(
        offset: offset,
        clickCall: (){
          clickLongJuanFeng(fromGuide: true);
        },
      ),
    );
  }

  _showWannengGuide(){
    PointHep.instance.point(pointEvent: PointEvent.newuser_guide,params: {"pop_step":"pop6"});
    var renderBox = wannengGlobalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    GuideHep.instance.showOverlay(
      context: context,
      widget: WannengGuideView(
        offset: offset,
        clickCall: (){
          clickWanNeng(fromGuide: true);
        },
      ),
    );
  }

  _removeHandCard()async{
    if(p3play.currentHandsNum<=0){
      return;
    }
    while(p3play.currentHandsNum>0){
      p3play.removeHandCard();
      update(["hand_card_num"]);
      P1Mp3Hep.instance.playXiaoChu();
      P3UserInfoHep.instance.updateUserCoins(P3ValueHep.instance.getCardAddNum(),removeHandCard: true);
      await Future.delayed(const Duration(milliseconds: 400));
    }
    p3play.showWinnerDialog();
  }
}