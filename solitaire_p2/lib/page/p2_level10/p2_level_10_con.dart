import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p2/bean/card_bean.dart';
import 'package:solitaire_p2/bean/random_card_bean.dart';
import 'package:solitaire_p2/dialog/p2_buy_wan_neng_card_dialog/p2_buy_wan_neng_card_dialog.dart';
import 'package:solitaire_p2/dialog/p2_winner_dialog/p2_winner_dialog.dart';
import 'package:solitaire_p2/hep/p2_card_hep.dart';
import 'package:solitaire_p2/hep/p2_play.dart';
import 'package:solitaire_p2/hep/p2_storage.dart';
import 'package:solitaire_p2/hep/p2_user_info_hep.dart';
import 'package:solitaire_p2/hep/p2_value_hep.dart';

class P2Level10Con extends P1BaseCon{
  var currentHandsNum=17;
  List<List<CardBean>> cardList=[];
  final List<RandomCardBean> _topRandomCardList=[];
  RandomCardBean? currentHandCard;

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
    if(bean.covered||!bean.show||null==currentHandCard){
      return;
    }
    var cardsAdjacent = P2CardHep.instance.isCardsAdjacent(bean.cardNum, currentHandCard?.cardNum??"");
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
    update(["list","hand_card"]);
    P2UserInfoHep.instance.updateUserCoins(100);
    if(_checkCardNotEmpty()){
      _checkOverlays();
    }else{
      P1RouterFun.showDialog(
        w: P2WinnerDialog(
          close: (){
            P1RouterFun.closePage();
          },
          next: (){
            _toNextLevel();
          },
        ),
      );
    }
  }

  clickWanNeng(){
    P1EventBean(code: P2EventCode.buyWanNengCardNoMoney).send();
    // P1RouterFun.showDialog(w: P2BuyWanNengCardDialog());
  }

  clickLongJuanFeng(){
    // _checkOverlays();

  }

  changeHandCard(){
    currentHandCard = P2CardHep.instance.getRandomCardByListAndProbability(_getNoCoveredCardNumList(), P2ValueHep.instance.getHandsProbability());
    currentHandsNum--;
    update(["hand_card_num","hand_card"]);
  }

  _toNextLevel(){
    currentHandsNum=17;
    _topRandomCardList.clear();
    currentHandCard=null;
    P2UserInfoHep.instance.updateLevel();
    update(["level"]);
    _initCardList();
  }

  _initCardList()async{
    cardList.clear();
    var currentIndex=0;
    while(cardList.length<6){
      await Future.delayed(const Duration(milliseconds: 200));
      var list=[CardBean(index: currentIndex,top: cardList.length>=4,cardNum: "-1", show: true, covered: true,globalKey: GlobalKey())];
      currentIndex++;
      if(cardList.length<5){
        list.add(CardBean(index:currentIndex,top: cardList.length>=4,cardNum: "-1", show: true, covered: true,globalKey: GlobalKey()));
        currentIndex++;
      }
      cardList.add(list);
      update(["list"]);
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _checkOverlays();
    });
  }

  _checkOverlays() {
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
    _getTopAndHandCard();
  }

  _getTopAndHandCard(){
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
        var indexWhere = noCoverList.indexWhere((element) => element.cardNum=="-1");
        if(indexWhere>=0){
          var randomCardByListAndProbability = P2CardHep.instance.getRandomCardByListAndProbability(_getTopCardNumList(), P2ValueHep.instance.getBottomProbability());
          for (var value in cardList) {
            for (var bean in value) {
              if(bean.index==noCoverList[indexWhere].index){
                bean.cardNum=randomCardByListAndProbability.cardNum;
                bean.cardType=randomCardByListAndProbability.cardType;
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
      }
    }
    update(["list","hand_card"]);
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

  String getCardImageIcon(CardBean bean){
    if(bean.covered){
      return "card_back";
    }else{
      var cardNum=0;
      switch(bean.cardNum){
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
          cardNum=bean.cardNum.toInt();
          break;
      }
      return "${bean.cardType.name}$cardNum";
    }
  }

  String getHandCardImageIcon(){
    if(null==currentHandCard){
      return "";
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