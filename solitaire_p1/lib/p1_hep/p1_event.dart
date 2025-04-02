import 'package:event_bus/event_bus.dart';

final EventBus eventBus=EventBus();

class P2EventCode{
  //p2
  static const int updateLevel=1;
  static const int updateCoins=2;
  static const int buyWanNengCardNoMoney=3;
}

class P1EventBean{
  int code;
  int? intValue;
  P1EventBean({
    required this.code,
    this.intValue,
  });

  send(){
    eventBus.fire(this);
  }
}