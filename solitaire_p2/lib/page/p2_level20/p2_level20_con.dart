import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p2/bean/card_bean.dart';
import 'package:solitaire_p2/hep/p2_play.dart';

class P2Level20Con extends P1BaseCon{
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
        refresh: (){
          update(["list"]);
        },
        toNextLevel: (){
          update(["level"]);
          _initCardList();
        }
    );
  }

  _initCardList()async{
    p2play.cardList.clear();
    var currentIndex=0;
    while(p2play.cardList.length<2){
      if(p2play.cardList.isEmpty){
        List<CardBean> list=[];
        for(int index=0;index<10;index++){
          list.add(CardBean(index: currentIndex,top: p2play.cardList.isNotEmpty,cardNum: "-1", show: true, covered: true,globalKey: GlobalKey()));
          currentIndex++;
        }
        p2play.cardList.add(list);
      }else{
        List<CardBean> list=[];
        for(int index=0;index<3;index++){
          list.add(CardBean(index: currentIndex,top: p2play.cardList.isNotEmpty,cardNum: "-1", show: true, covered: true,globalKey: GlobalKey()));
          currentIndex++;
        }
        p2play.cardList.add(list);
      }
    }
    update(["list"]);
    p2play.checkOverlays(
        call: (){
          update(["list"]);
        }
    );
  }

  @override
  bool registerP1Event() => true;

  @override
  onListenP1Event(P1EventBean bean) {
    switch(bean.code){
      case P2EventCode.updateWindAnimator:
        p2play.hasLongJuanCard(
            call: (){
              update(["list"]);
            }
        );
        break;
      case P2EventCode.completedWindAnimator:
        p2play.checkOverlays(
            call: (){
              update(["list"]);
            }
        );
        break;
      case P2EventCode.replayGame:
        p2play.resetGame(
          call: (){
            _initCardList();
          },
        );
        break;
    }
  }
}