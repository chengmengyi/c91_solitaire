import 'package:event_bus/event_bus.dart';

final EventBus eventBus=EventBus();

class P2EventCode{
  //p2
  static const int updateLevel=1;
  static const int updateCoins=2;
  static const int resetCardList=3;
  static const int updateHandCard=4;
  static const int updateWindAnimator=5;
  static const int completedWindAnimator=6;
  static const int replayGame=7;
  static const int getFiveCards=8;
  static const int flipCards=9;
  static const int resetCardFrontStatus=10;
  static const int showCoinsLottie=11;
  static const int showLongJuanFengLottie=12;
  static const int longJuanFengLottieEnd=13;
  static const int removeHandCard=14;
}

class P3EventCode{
  //p3
  static const int updateLevel=100;
  static const int updateCoins=101;
  static const int resetCardList=102;
  static const int updateHandCard=103;
  static const int updateWindAnimator=104;
  static const int completedWindAnimator=105;
  static const int replayGame=106;
  static const int getFiveCards=107;
  static const int flipCards=108;
  static const int resetCardFrontStatus=109;
  static const int showCoinsLottie=110;
  static const int showLongJuanFengLottie=111;
  static const int longJuanFengLottieEnd=112;
  static const int removeHandCard=113;
  static const int updateTopPro=114;
  static const int flipLuckyCardEnd=115;
  static const int newUserStep3ClickCard=116;
  static const int updateCashList=117;
  static const int showNewUserGuide8=118;
  static const int showLongjuanfengGuide=119;
}

class P1EventBean{
  int code;
  int? intValue;
  dynamic anyValue;
  P1EventBean({
    required this.code,
    this.intValue,
    this.anyValue,
  });

  send(){
    eventBus.fire(this);
  }
}