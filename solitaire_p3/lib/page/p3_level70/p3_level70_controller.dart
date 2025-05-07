import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/hep/p3_play.dart';

class P3Level70Controller extends P1BaseCon{
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


  _initCardList()async{
    p3play.cardList.clear();
    var currentIndex=0;
    while(p3play.cardList.length<3){
      if(p3play.cardList.isEmpty){
        List<CardBean> list=[];
        for(int index=0;index<16;index++){
          list.add(CardBean(index: currentIndex,top: false,cardNum: "-1", show: true, covered: true,globalKey: GlobalKey()));
          currentIndex++;
        }
        p3play.cardList.add(list);
      }else if(p3play.cardList.length==1){
        List<CardBean> list=[];
        for(int index=0;index<6;index++){
          list.add(CardBean(index: currentIndex,top: false,cardNum: "-1", show: true, covered: true,globalKey: GlobalKey(),));
          currentIndex++;
        }
        p3play.cardList.add(list);
      }else{
        List<CardBean> list=[];
        for(int index=0;index<6;index++){
          list.add(CardBean(index: currentIndex,top: true,cardNum: "-1", show: true, covered: true,globalKey: GlobalKey()));
          currentIndex++;
        }
        p3play.cardList.add(list);
      }
    }
    update(["list"]);
    _checkOverlays();
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
    }
  }
}