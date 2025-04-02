enum CardType{
  heitao,hongtao,meihua,fangkuai,
}

class RandomCardBean{
  String cardNum;
  CardType cardType;
  RandomCardBean({
    required this.cardNum,
    required this.cardType,
});

  @override
  String toString() {
    return 'RandomCardBean{cardNum: $cardNum, cardType: $cardType}';
  }
}