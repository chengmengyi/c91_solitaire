import 'package:flutter/material.dart';
import 'package:solitaire_p3/bean/random_card_bean.dart';

class CardBean{
  int index;
  bool top;
  String cardNum;
  bool covered;
  bool show;
  CardType cardType;
  GlobalKey globalKey;
  bool isMoneyCard;
  CardBean({
    required this.index,
    required this.top,
    required this.cardNum,
    required this.show,
    required this.covered,
    required this.globalKey,
    this.cardType=CardType.fangkuai,
    this.isMoneyCard=false,
});

  @override
  String toString() {
    return 'CardBean{index: $index, top: $top, cardNum: $cardNum, covered: $covered, show: $show, cardType: $cardType}';
  }
}