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