import 'package:flutter/material.dart';
import 'package:solitaire_p2/bean/random_card_bean.dart';

class CardBean{
  int index;
  bool top;
  String cardNum;
  bool covered;
  bool show;
  CardType cardType;
  GlobalKey globalKey;
  CardBean({
    required this.index,
    required this.top,
    required this.cardNum,
    required this.show,
    required this.covered,
    required this.globalKey,
    this.cardType=CardType.fangkuai,
});

  @override
  String toString() {
    return 'CardBean{index: $index, top: $top, cardNum: $cardNum, covered: $covered, show: $show, cardType: $cardType}';
  }
}