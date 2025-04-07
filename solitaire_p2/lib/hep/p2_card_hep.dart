import 'dart:math';

import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p2/bean/random_card_bean.dart';

class P2CardHep{
  static final P2CardHep _instance = P2CardHep();
  static P2CardHep get instance => _instance;

  final List<String> _cardNumList = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K'];
  final List<String> _cardTypeList = ['♠', '♥', '♣', '♦'];

  //获取顶部随机的牌
  List<RandomCardBean> getTopRandomCards(int n, double adjacentProbability) {
    final Random random = Random();
    // 生成第一张牌
    int firstRankIndex = random.nextInt(_cardNumList.length);
    String firstRank = _cardNumList[firstRankIndex];
    int firstSuitIndex = random.nextInt(_cardTypeList.length);
    String firstSuit = _cardTypeList[firstSuitIndex];
    List<String> cards = ['$firstRank$firstSuit'];
    for (int i = 1; i < n; i++) {
      if (random.nextDouble() < adjacentProbability) {
        // 生成相邻的牌
        String prevRank = cards[i - 1].substring(0, cards[i - 1].length - 1);
        int prevRankIndex = _cardNumList.indexWhere((element) => element==prevRank);
        List<String> adjacentRanks = [];
        int prevAdjacentIndex = prevRankIndex - 1;
        int nextAdjacentIndex = prevRankIndex + 1;
        if (prevAdjacentIndex == -1) {
          prevAdjacentIndex = _cardNumList.length - 1;
        }
        if (nextAdjacentIndex == _cardNumList.length) {
          nextAdjacentIndex = 0;
        }
        adjacentRanks.add(_cardNumList[prevAdjacentIndex]);
        adjacentRanks.add(_cardNumList[nextAdjacentIndex]);
        int adjacentRankIndex = random.nextInt(adjacentRanks.length);
        String adjacentRank = adjacentRanks[adjacentRankIndex];
        int suitIndex = random.nextInt(_cardTypeList.length);
        String suit = _cardTypeList[suitIndex];
        print("kk====getTopRandomCards====第一张===$firstRank$firstSuit===概率：$adjacentProbability==满足概率===$adjacentRank$suit");
        cards.add("$adjacentRank$suit");
      } else {
        // 生成不相邻的随机牌
        int randomRankIndex = random.nextInt(_cardNumList.length);
        String randomRank = _cardNumList[randomRankIndex];
        int randomSuitIndex = random.nextInt(_cardTypeList.length);
        String randomSuit = _cardTypeList[randomSuitIndex];
        print("kk====getTopRandomCards====第一张===$firstRank$firstSuit===概率：$adjacentProbability==不满足概率===$randomRank$randomSuit");
        cards.add('$randomRank$randomSuit');
      }
    }

    List<RandomCardBean> newCard=[];
    for (var value in cards) {
      var num = value.substring(0,value.length-1);
      var type = value.substring(value.length-1,value.length);
      newCard.add(RandomCardBean(cardNum: num, cardType: _getCardType(type)));
    }

    return newCard;
  }

  //在指定列表中根据概率随机一张牌
  RandomCardBean getRandomCardByListAndProbability(List<String> ranks, double adjacentProbability) {
    final Random random = Random();
    CardType randomCardType=_getCardType(_cardTypeList.random());
    if (random.nextDouble() < adjacentProbability) {
      // 先随机选一张牌作为基础
      String baseCard = ranks.random();
      // 生成相邻的牌
      int baseRankIndex = _cardNumList.indexWhere((element) => element==baseCard);
      List<String> adjacentRanks = [];
      int prevAdjacentIndex = baseRankIndex - 1;
      int nextAdjacentIndex = baseRankIndex + 1;
      if (prevAdjacentIndex == -1) {
        prevAdjacentIndex = ranks.length - 1;
      }
      if (nextAdjacentIndex == _cardNumList.length) {
        nextAdjacentIndex = 0;
      }
      if (prevAdjacentIndex >= 0 && prevAdjacentIndex < _cardNumList.length) {
        adjacentRanks.add(_cardNumList[prevAdjacentIndex]);
      }
      if (nextAdjacentIndex >= 0 && nextAdjacentIndex < _cardNumList.length) {
        adjacentRanks.add(_cardNumList[nextAdjacentIndex]);
      }
      if (adjacentRanks.isNotEmpty) {
        var cardNum = adjacentRanks.random();
        print("kk====getRandomCardByListAndProbability====第一张===$baseCard===概率：$adjacentProbability==满足概率===${cardNum}");
        return RandomCardBean(cardNum: cardNum, cardType: randomCardType);
      } else {
        // 如果没有相邻牌，返回基础牌
        print("kk====getRandomCardByListAndProbability====第一张===$baseCard===概率：$adjacentProbability==满足概率==没有相邻的=$baseCard");
        return RandomCardBean(cardNum: baseCard, cardType: randomCardType);
      }
    } else {
      // 生成不相邻的随机牌
      var removeAdjacentRanks = _removeAdjacentRanks(ranks);
      var cardNum = removeAdjacentRanks.random();
      print("kk====getRandomCardByListAndProbability====概率：$adjacentProbability===不满足概率===${removeAdjacentRanks}===随机===$cardNum");
      return RandomCardBean(cardNum: cardNum, cardType: randomCardType);
    }
  }

  RandomCardBean randomHandCard()=>RandomCardBean(cardNum: _cardNumList.random(), cardType: _getCardType(_cardTypeList.random()));

  //检测是否相邻
  bool isCardsAdjacent(String card1, String card2) {
    int rankIndex1 = _cardNumList.indexWhere((element) => element==card1);
    int rankIndex2 = _cardNumList.indexWhere((element) => element==card2);
    if (rankIndex1 == -1 || rankIndex2 == -1) {
      return false;
    }
    int diff = (rankIndex1 - rankIndex2).abs();
    if (diff == 1) {
      return true;
    }
    // 处理 A 的特殊情况
    if ((rankIndex1 == 0 && rankIndex2 == _cardNumList.length - 1) || (rankIndex1 == _cardNumList.length - 1 && rankIndex2 == 0)) {
      return true;
    }
    return false;
  }

  List<String> _removeAdjacentRanks(List<String> targetRanks) {
    List<String> newAllRanks = List.from(_cardNumList);
    List<String> allRanks = List.from(_cardNumList);
    for (var value in targetRanks) {
      int targetIndex = _cardNumList.indexWhere((element) => element==value);
      int prevAdjacentIndex = targetIndex - 1;
      int nextAdjacentIndex = targetIndex + 1;
      if (prevAdjacentIndex == -1) {
        prevAdjacentIndex = allRanks.length - 1;
      }
      if (nextAdjacentIndex == allRanks.length) {
        nextAdjacentIndex = 0;
      }
      String prevAdjacentRank = allRanks[prevAdjacentIndex];
      String nextAdjacentRank = allRanks[nextAdjacentIndex];
      String currentAdjacentRank = allRanks[targetIndex];
      newAllRanks.remove(prevAdjacentRank);
      newAllRanks.remove(nextAdjacentRank);
      newAllRanks.remove(currentAdjacentRank);
    }
    return newAllRanks;

  }


  CardType _getCardType(String type){
    switch(type){
      case "♠": return CardType.heitao;
      case "♥": return CardType.hongtao;
      case "♣": return CardType.meihua;
      case "♦": return CardType.fangkuai;
      default: return CardType.heitao;
    }
  }
}