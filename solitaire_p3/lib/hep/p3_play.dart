import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_hep/p1_mp3_hep.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/bean/random_card_bean.dart';
import 'package:solitaire_p3/dialog/p3_get_coins/p3_get_coins_dialog.dart';
import 'package:solitaire_p3/dialog/p3_winner_dialog/p3_winner_dialog.dart';
import 'package:solitaire_p3/hep/cash/cash_enums.dart';
import 'package:solitaire_p3/hep/cash/cash_task_hep.dart';
import 'package:solitaire_p3/hep/guide/guide_hep.dart';
import 'package:solitaire_p3/hep/hep.dart';
import 'package:solitaire_p3/hep/p3_card_hep.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';

import '../dialog/p3_fail_dialog/p3_fail_dialog.dart';

class P3Play{
  var currentHandsNum=17,canClick=false;
  List<List<CardBean>> cardList=[];
  final List<RandomCardBean> _topRandomCardList=[];
  RandomCardBean? currentHandCard;
  Offset? _handCardOffset;

  P3Play(){
    P3UserInfoHep.instance.setStartCoins();
    PointHep.instance.point(pointEvent: PointEvent.game_page,params: {"level":p3CurrentLevel.getData()});
  }

  hasWanNengCard(){
    P1Mp3Hep.instance.playWanNeng();
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
    if(!_checkCardNotEmpty()){
      if(currentHandsNum>0){
        P1EventBean(code: P3EventCode.removeHandCard).send();
      }else{
        showWinnerDialog();
      }
    }
  }

  changeHandCard(Function() call){
    currentHandCard = P2CardHep.instance.getRandomCardByListAndProbability(_getNoCoveredCardNumList(), P3ValueHep.instance.getHandsProbability());
    currentHandsNum--;
    call.call();
    _checkShowFailDialog();
  }

  removeHandCard(){
    currentHandsNum--;
  }

  clickCard({
    required CardBean bean,
    required Function(List<CardBean>) refresh,
  })async{
    if(!canClick||bean.covered||!bean.show||null==currentHandCard){
      return;
    }
    if(bean.isMoneyCard){
      for (var value in cardList) {
        var indexWhere = value.indexWhere((element) => element.index==bean.index);
        if(indexWhere>=0){
          value[indexWhere].show=false;
        }
      }
      refresh.call([]);
      var moneyCardAddNum = P3ValueHep.instance.getMoneyCardAddNum();
      if(_checkCardNotEmpty()){
        _checkOverlays(refresh);
        showGetCoinsDialog(moneyCardAddNum, GetCoinsEnum.card);
      }else{
        P3UserInfoHep.instance.updateUserCoins(moneyCardAddNum);
        if(currentHandsNum>0){
          P1EventBean(code: P3EventCode.removeHandCard).send();
        }else{
          showWinnerDialog();
        }
      }
      return;
    }
    var cardsAdjacent = false;
    if(currentHandCard?.hasWanNeng==true){
      cardsAdjacent=true;
      CashTaskHep.instance.updateCashTask(CashTask.wannengka);
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
    P3UserInfoHep.instance.updateTopPro(1);
    P1Mp3Hep.instance.playXiaoChu();
    P1EventBean(code: P3EventCode.moveHandCardToBottom,anyValue: bean,anyValue2: _handCardOffset).send();
    refresh.call([]);
    await Future.delayed(const Duration(milliseconds: 300));
    currentHandCard=RandomCardBean(cardNum: bean.cardNum, cardType: bean.cardType);
    currentHandCard?.hasWanNeng=false;
    _clickCardResult(P3ValueHep.instance.getCardAddNum(),refresh);
  }

  _clickCardResult(double addNum,Function(List<CardBean>) refresh)async{
    P1EventBean(code: P3EventCode.updateHandCard).send();
    P3UserInfoHep.instance.updateUserCoins(addNum);
    if(_checkCardNotEmpty()){
      _checkOverlays(refresh);
      P3UserInfoHep.instance.updatePlayCardNum();
    }else{
      if(currentHandsNum>0){
        P1EventBean(code: P3EventCode.removeHandCard).send();
      }else{
        showWinnerDialog();
      }
    }
  }

  showWinnerDialog(){
    P1Mp3Hep.instance.playShengLi();
    P1RouterFun.showDialog(
      w: P3WinnerDialog(
        close: (){
          P1RouterFun.closePage();
        },
        next: (){
          P3UserInfoHep.instance.setStartCoins();
          currentHandsNum=17;
          _topRandomCardList.clear();
          currentHandCard=null;
          var routerName = P3UserInfoHep.instance.updateLevel();
          CashTaskHep.instance.updateCashTask(CashTask.level);
          if(routerName.isEmpty){
            P1EventBean(code: P3EventCode.resetCardFrontStatus).send();
            P1EventBean(code: P3EventCode.resetCardList).send();
          }else{
            P1RouterFun.toNextPageAndCloseCurrent(str: routerName);
          }
        },
      ),
    );
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


    // for (int outerIndex = 0; outerIndex < cardList.length; outerIndex++) {
    //   for (int innerIndex = 0; innerIndex < cardList[outerIndex].length; innerIndex++) {
    //     var bean = cardList[outerIndex][innerIndex];
    //     final GlobalKey currentKey = bean.globalKey;
    //     final RenderBox? currentBox = currentKey.currentContext?.findRenderObject() as RenderBox?;
    //     if (currentBox == null) {
    //       continue;
    //     }
    //     final Path currentPath = _getRotatedPath(currentBox, bean.rotation);
    //     bool isOverlayed = false;
    //     for (int laterOuterIndex = outerIndex; laterOuterIndex < cardList.length; laterOuterIndex++) {
    //       for (int laterInnerIndex = 0; laterInnerIndex < cardList[laterOuterIndex].length; laterInnerIndex++) {
    //         if (laterOuterIndex > outerIndex || (laterOuterIndex == outerIndex && laterInnerIndex > innerIndex)) {
    //           var innerBean = cardList[laterOuterIndex][laterInnerIndex];
    //           if (!innerBean.show) {
    //             continue;
    //           }
    //           final GlobalKey otherKey = innerBean.globalKey;
    //           final RenderBox? otherBox = otherKey.currentContext?.findRenderObject() as RenderBox?;
    //           if (otherBox != null) {
    //             final Path otherPath = _getRotatedPath(otherBox, innerBean.rotation);
    //             if (_isPathOverlapping(currentPath, otherPath)) {
    //               isOverlayed = true;
    //               break;
    //             }
    //           }
    //         }
    //       }
    //       if (isOverlayed) {
    //         break;
    //       }
    //     }
    //     bean.covered = isOverlayed;
    //   }
    // }

    _setMoneyCard();
    _getTopAndHandCard(call);
  }

  Path _getRotatedPath(RenderBox box, double rotation) {
    final Offset position = box.localToGlobal(Offset.zero);
    final Size size = box.size;
    final Matrix4 transform = Matrix4.identity()
      ..translate(position.dx + size.width / 2, position.dy + size.height / 2)
      ..rotateZ(rotation * (pi / 180))
      ..translate(-size.width / 2, -size.height / 2);
    final Path path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..transform(transform.storage);
    return path;
  }

  bool _isPathOverlapping(Path path1, Path path2) {
    final Path intersection = Path.combine(PathOperation.intersect, path1, path2);
    return !intersection.getBounds().isEmpty;
  }


  _setMoneyCard(){
    var list = cardList.expand((element) => element).toList();
    var indexWhere = list.indexWhere((element) => element.isMoneyCard);
    if(indexWhere>=0){
      return;
    }
    var bottomList = list.where((element) => element.covered).toList();
    List<CardBean> randomList=[];
    while(randomList.length<3){
      var r = bottomList.random();
      var where = randomList.indexWhere((element) => element.index==r.index);
      if(where<0){
        randomList.add(r);
      }
    }
    for (var value in cardList) {
      for (var bean in value) {
        var where = randomList.indexWhere((element) => element.index==bean.index);
        if(where>=0){
          bean.isMoneyCard=true;
        }
      }
    }
  }

  _getTopAndHandCard(Function(List<CardBean>) call){
    List<CardBean> noCoverList=[];
    for (var value in cardList) {
      for (var bean in value) {
        if(!bean.covered&&bean.show){
          noCoverList.add(bean);
        }
      }
    }
    if(noCoverList.isNotEmpty){
      if(_topRandomCardList.isEmpty){
        var topRandomCards = P2CardHep.instance.getTopRandomCards(noCoverList.length, P3ValueHep.instance.getTopProbability());
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
            var randomCardByListAndProbability = P2CardHep.instance.getRandomCardByListAndProbability(_getTopCardNumList(), P3ValueHep.instance.getBottomProbability());
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
          currentHandCard = P2CardHep.instance.getRandomCardByListAndProbability(_getTopCardNumList(), P3ValueHep.instance.getHandsProbability());
        }else{
          currentHandCard = P2CardHep.instance.randomHandCard();
        }
        P1EventBean(code: P3EventCode.updateHandCard).send();
      }
    }
    canClick=true;
    call.call(noCoverList);
    _checkShowFailDialog();
  }

  _checkShowFailDialog(){
    if(_checkFail()){
      P1Mp3Hep.instance.playShiBai();
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
    currentHandCard = P2CardHep.instance.getRandomCardByListAndProbability(_getTopCardNumList(), P3ValueHep.instance.getHandsProbability());
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

  checkShowGuideStep3(BuildContext context)async{
    if(!GuideHep.instance.canShowStep3()){
      return;
    }
    await Future.delayed(const Duration(milliseconds: 600));
    CardBean? cardBean;
    for (var value in cardList) {
      var indexWhere = value.indexWhere((value1) => value1.top&&value1.cardNum.isNotEmpty&&value1.show&&P2CardHep.instance.isCardsAdjacent(value1.cardNum, currentHandCard?.cardNum??""));
      if(indexWhere>=0){
        cardBean=value[indexWhere];
        break;
      }
    }
    if(null==cardBean){
      return;
    }
    GuideHep.instance.showGuideStep3(context,cardBean);
  }

  setHandCardOffset(Offset offset){
    _handCardOffset=offset;
  }
}