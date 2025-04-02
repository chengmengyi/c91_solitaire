enum CardType{
  heitao,hongtao,meihua,fangkuai,
}

class RandomCardBean{
  String cardNum;
  CardType cardType;
  bool? hasWanNeng;
  RandomCardBean({
    required this.cardNum,
    required this.cardType,
    this.hasWanNeng,
});

  @override
  String toString() {
    return 'RandomCardBean{cardNum: $cardNum, cardType: $cardType}';
  }
}