import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p2/bean/card_bean.dart';
import 'package:solitaire_p2/bean/random_card_bean.dart';
import 'package:solitaire_p2/dialog/p2_winner_dialog/p2_winner_dialog.dart';
import 'package:solitaire_p2/hep/p2_card_hep.dart';
import 'package:solitaire_p2/hep/p2_user_info_hep.dart';
import 'package:solitaire_p2/hep/p2_value_hep.dart';

import '../dialog/p2_fail_dialog/p2_fail_dialog.dart';

class P2Play{
  var currentHandsNum=17,canClick=false;
  List<List<CardBean>> cardList=[];
  final List<RandomCardBean> _topRandomCardList=[];
  RandomCardBean? currentHandCard;

  hasWanNengCard(){
    currentHandCard?.hasWanNeng=true;
  }

  hasLongJuanCard({required Function() call}){
    for (var value in cardList) {
      for (var value1 in value) {
        if(!value1.covered&&value1.show&&value1.cardNum!="-1"){
          value1.show=false;
        }
      }
    }
    call.call();
  }

  changeHandCard(Function() call){
    currentHandCard = P2CardHep.instance.getRandomCardByListAndProbability(_getNoCoveredCardNumList(), P2ValueHep.instance.getHandsProbability());
    currentHandsNum--;
    call.call();
    if(_checkFail()){
      P1RouterFun.showDialog(w: P2FailDialog(),);
    }
  }

  clickCard({
    required CardBean bean,
    required Function(List<CardBean>) refresh,
    required Function() toNextLevel,
  }){
    if(!canClick||bean.covered||!bean.show||null==currentHandCard){
      return;
    }

    var cardsAdjacent = false;
    if(currentHandCard?.hasWanNeng==true){
      cardsAdjacent=true;
    }else{
      cardsAdjacent = P2CardHep.instance.isCardsAdjacent(bean.cardNum, currentHandCard?.cardNum??"");
    }
    if(!cardsAdjacent){
      return;
    }
    for (var value in cardList) {
      var indexWhere = value.indexWhere((element) => element.index==bean.index);
      if(indexWhere>=0){
        value[indexWhere].show=false;
      }
    }
    currentHandCard=RandomCardBean(cardNum: bean.cardNum, cardType: bean.cardType);
    currentHandCard?.hasWanNeng=false;
    _clickCardResult(100,refresh,toNextLevel);
  }

  _clickCardResult(int addNum,Function(List<CardBean>) refresh, Function() toNextLevel){
    P1EventBean(code: P2EventCode.updateHandCard).send();
    refresh.call([]);
    P2UserInfoHep.instance.updateUserCoins(addNum);
    if(_checkCardNotEmpty()){
      _checkOverlays(refresh);
    }else{
      P1RouterFun.showDialog(
        w: P2WinnerDialog(
          close: (){
            P1RouterFun.closePage();
          },
          next: (){
            currentHandsNum=17;
            _topRandomCardList.clear();
            currentHandCard=null;
            var routerName = P2UserInfoHep.instance.updateLevel();
            if(routerName.isEmpty){
              P1EventBean(code: P2EventCode.resetCardFrontStatus).send();
              toNextLevel.call();
            }else{
              P1RouterFun.toNextPageAndCloseCurrent(str: routerName);
            }
          },
        ),
      );
    }
  }

  checkOverlays({required Function(List<CardBean>) call,}){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _checkOverlays(call);
    });
  }

  _checkOverlays(Function(List<CardBean>) call) {
    canClick=false;
    for (int outerIndex = 0; outerIndex < cardList.length; outerIndex++) {
      for (int innerIndex = 0; innerIndex < cardList[outerIndex].length; innerIndex++) {
        var bean = cardList[outerIndex][innerIndex];
        final GlobalKey currentKey = bean.globalKey;
        final RenderBox? currentBox = currentKey.currentContext?.findRenderObject() as RenderBox?;
        if (currentBox!= null) {
          final Offset currentPosition = currentBox.localToGlobal(Offset.zero);
          final Size currentSize = currentBox.size;
          final Rect currentRect = Rect.fromLTWH(
            currentPosition.dx,
            currentPosition.dy,
            currentSize.width,
            currentSize.height,
          );
          bool isOverlayed = false;
          for (int laterOuterIndex = outerIndex; laterOuterIndex < cardList.length; laterOuterIndex++) {
            for (int laterInnerIndex = 0; laterInnerIndex < cardList[laterOuterIndex].length; laterInnerIndex++) {
              if (laterOuterIndex > outerIndex || (laterOuterIndex == outerIndex && laterInnerIndex > innerIndex)) {
                var innerBean = cardList[laterOuterIndex][laterInnerIndex];
                if(!innerBean.show){
                  continue;
                }
                final GlobalKey otherKey = innerBean.globalKey;
                final RenderBox? otherBox = otherKey.currentContext?.findRenderObject() as RenderBox?;
                if (otherBox!= null) {
                  final Offset otherPosition =
                  otherBox.localToGlobal(Offset.zero);
                  final Size otherSize = otherBox.size;
                  final Rect otherRect = Rect.fromLTWH(
                    otherPosition.dx,
                    otherPosition.dy,
                    otherSize.width,
                    otherSize.height,
                  );
                  if (currentRect.overlaps(otherRect)) {
                    isOverlayed = true;
                    break;
                  }
                }
              }
            }
            if (isOverlayed) {
              break;
            }
          }
          bean.covered=isOverlayed;
        }
      }
    }
    _getTopAndHandCard(call);
  }

  _getTopAndHandCard(Function(List<CardBean>) call){
    List<CardBean> noCoverList=[];
    for (var value in cardList) {
      for (var bean in value) {
        if(!bean.covered&&bean.show){
          print("kk===noCoverList===${bean.index}====${bean.cardNum}");
          noCoverList.add(bean);
        }
      }
    }
    if(noCoverList.isNotEmpty){
      if(_topRandomCardList.isEmpty){
        var topRandomCards = P2CardHep.instance.getTopRandomCards(noCoverList.length, P2ValueHep.instance.getTopProbability());
        _topRandomCardList.addAll(topRandomCards);
        var currentIndex=0;
        for (var value in cardList) {
          for (var bean in value) {
            if(!bean.covered&&bean.show){
              var randomCardBean = _topRandomCardList[currentIndex];
              bean.cardNum=randomCardBean.cardNum;
              bean.cardType=randomCardBean.cardType;
              currentIndex++;
            }
          }
        }
      }else{
        for (var value1 in noCoverList) {
          if(value1.cardNum=="-1"){
            var randomCardByListAndProbability = P2CardHep.instance.getRandomCardByListAndProbability(_getTopCardNumList(), P2ValueHep.instance.getBottomProbability());
            for (var value in cardList) {
              for (var bean in value) {
                if(bean.index==value1.index){
                  bean.cardNum=randomCardByListAndProbability.cardNum;
                  bean.cardType=randomCardByListAndProbability.cardType;
                }
              }
            }
          }
        }
      }
      if(null==currentHandCard){
        if(_topRandomCardList.isNotEmpty){
          currentHandCard = P2CardHep.instance.getRandomCardByListAndProbability(_getTopCardNumList(), P2ValueHep.instance.getHandsProbability());
        }else{
          currentHandCard = P2CardHep.instance.randomHandCard();
        }
        P1EventBean(code: P2EventCode.updateHandCard).send();
      }
    }
    canClick=true;
    call.call(noCoverList);
    if(_checkFail()){
      P1RouterFun.showDialog(w: P2FailDialog(),);
    }
  }

  bool _checkFail(){
    if(currentHandsNum>0){
      return false;
    }
    List<CardBean> list=[];
    for (var value in cardList) {
      for (var value1 in value) {
        if(!value1.covered&&value1.show&&value1.cardNum!="-1"){
          list.add(value1);
        }
      }
    }

    for (var value2 in list) {
      var cardsAdjacent = P2CardHep.instance.isCardsAdjacent(value2.cardNum, currentHandCard?.cardNum??"");
      if(cardsAdjacent){
        return false;
      }
    }
    return true;
  }

  resetGame({required Function call,}){
    currentHandsNum=17;
    _topRandomCardList.clear();
    currentHandCard=null;
    call.call();
  }

  getFiveCards({required Function call,}){
    currentHandsNum=4;
    currentHandCard = P2CardHep.instance.getRandomCardByListAndProbability(_getTopCardNumList(), P2ValueHep.instance.getHandsProbability());
    call.call();
  }

  List<String> _getTopCardNumList(){
    List<String> list=[];
    for (var value in _topRandomCardList) {
      list.add(value.cardNum);
    }
    return list;
  }

  List<String> _getNoCoveredCardNumList(){
    List<String> noCoverList=[];
    for (var value in cardList) {
      for (var bean in value) {
        if(!bean.covered&&bean.cardNum!="-1"&&bean.show){
          print("kk===_getNoCoveredCardNumList===${bean.index}====${bean.cardNum}");
          noCoverList.add(bean.cardNum);
        }
      }
    }
    return noCoverList;
  }

  String getHandCardImageIcon(){
    if(null==currentHandCard){
      return "";
    }
    if(currentHandCard?.hasWanNeng==true){
      return "wanneng_card";
    }
    var cardNum=1;
    switch(currentHandCard?.cardNum){
      case "A":
        cardNum=1;
        break;
      case "J":
        cardNum=11;
        break;
      case "Q":
        cardNum=12;
        break;
      case "K":
        cardNum=13;
        break;
      default:
        cardNum=(currentHandCard?.cardNum??"").toInt();
        break;
    }
    return "${currentHandCard?.cardType.name}$cardNum";
  }

  bool _checkCardNotEmpty(){
    for (var value in cardList) {
      for (var value1 in value) {
        if(value1.show){
          return true;
        }
      }
    }
    return false;
  }
}