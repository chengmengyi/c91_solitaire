import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p2/bean/card_bean.dart';
import 'package:solitaire_p2/bean/random_card_bean.dart';
import 'package:solitaire_p2/dialog/p2_buy_wan_neng_card_dialog/p2_buy_wan_neng_card_dialog.dart';
import 'package:solitaire_p2/dialog/p2_fail_dialog/p2_fail_dialog.dart';
import 'package:solitaire_p2/dialog/p2_winner_dialog/p2_winner_dialog.dart';
import 'package:solitaire_p2/hep/p2_card_hep.dart';
import 'package:solitaire_p2/hep/p2_play.dart';
import 'package:solitaire_p2/hep/p2_storage.dart';
import 'package:solitaire_p2/hep/p2_user_info_hep.dart';
import 'package:solitaire_p2/hep/p2_value_hep.dart';

class P2Level10Con extends P1BaseCon{
  late P2Play p2play;

  @override
  void onInit() {
    super.onInit();
    p2play=P2Play();
  }

  @override
  void onReady() {
    super.onReady();
    _initCardList();
  }

  clickCard(CardBean bean){
    p2play.clickCard(
      bean: bean,
      refresh: (list){
        update(["list"]);
        _sendFlipCardMsg(list);
      },
    );
  }
  _initCardList(){
    p2play.cardList.clear();
    var currentIndex=0;
    while(p2play.cardList.length<6){
      var list=[CardBean(index: currentIndex,top: p2play.cardList.length>=4,cardNum: "-1", show: true, covered: true,globalKey: GlobalKey())];
      currentIndex++;
      if(p2play.cardList.length<5){
        list.add(CardBean(index:currentIndex,top: p2play.cardList.length>=4,cardNum: "-1", show: true, covered: true,globalKey: GlobalKey()));
        currentIndex++;
      }
      p2play.cardList.add(list);
      update(["list"]);
    }
    _checkOverlays();
  }
  _checkOverlays(){
    p2play.checkOverlays(
        call: (list){
          update(["list"]);
          _sendFlipCardMsg(list);
        }
    );
  }

  _sendFlipCardMsg(List<CardBean> list){
    if(list.isEmpty){
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      P1EventBean(code: P2EventCode.flipCards,anyValue: list).send();
    });
  }

  clickTest(){
    if(!kDebugMode){
      return;
    }
  }

  @override
  bool registerP1Event() => true;

  @override
  onListenP1Event(P1EventBean bean) {
    switch(bean.code){
      case P2EventCode.longJuanFengLottieEnd:
        p2play.hasLongJuanCard(
            call: (){
              update(["list"]);
            }
        );
        break;
      case P2EventCode.completedWindAnimator:
        _checkOverlays();
        break;
      case P2EventCode.replayGame:
        p2play.resetGame(
          call: (){
            _initCardList();
          },
        );
        break;
      case P2EventCode.resetCardList:
        update(["level"]);
        _initCardList();
        break;
    }
  }
}