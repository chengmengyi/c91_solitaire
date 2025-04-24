import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/hep/p3_play.dart';

class P3Level10Con extends P1BaseCon{
  late P3Play p3play;

  @override
  void onInit() {
    super.onInit();
    p3play=P3Play();
  }

  @override
  void onReady() {
    super.onReady();
    _initCardList();
  }

  clickCard(CardBean bean){
    p3play.clickCard(
      bean: bean,
      refresh: (list){
        update(["list"]);
        _sendFlipCardMsg(list);
      },
    );
  }
  _initCardList(){
    p3play.cardList.clear();
    var currentIndex=0;
    while(p3play.cardList.length<6){
      var list=[CardBean(index: currentIndex,top: p3play.cardList.length>=4,cardNum: "-1", show: true, covered: true,globalKey: GlobalKey())];
      currentIndex++;
      if(p3play.cardList.length<5){
        list.add(CardBean(index:currentIndex,top: p3play.cardList.length>=4,cardNum: "-1", show: true, covered: true,globalKey: GlobalKey()));
        currentIndex++;
      }
      p3play.cardList.add(list);
      update(["list"]);
    }
    _checkOverlays();
    p3play.checkShowGuideStep3(context);
  }
  _checkOverlays(){
    p3play.checkOverlays(
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
      P1EventBean(code: P3EventCode.flipCards,anyValue: list).send();
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
      case P3EventCode.longJuanFengLottieEnd:
        p3play.hasLongJuanCard(
            call: (){
              update(["list"]);
            }
        );
        break;
      case P3EventCode.completedWindAnimator:
        _checkOverlays();
        break;
      case P3EventCode.replayGame:
        p3play.resetGame(
          call: (){
            _initCardList();
          },
        );
        break;
      case P3EventCode.resetCardList:
        update(["level"]);
        _initCardList();
        break;
      case P3EventCode.newUserStep3ClickCard:
        clickCard(bean.anyValue as CardBean);
        break;
    }
  }
}