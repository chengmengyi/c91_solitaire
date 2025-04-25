import 'package:solitaire_p1/p1_hep/p1_hep.dart';

class ValueBean {
  ValueBean({
      this.intAd, 
      this.cardEliminationReward, 
      this.cashCardReward, 
      this.wheelReward, 
      this.cardReward,});

  ValueBean.fromJson(dynamic json) {
    if (json['int_ad'] != null) {
      intAd = [];
      json['int_ad'].forEach((v) {
        intAd?.add(IntAd.fromJson(v));
      });
    }
    if (json['card_elimination_reward'] != null) {
      cardEliminationReward = [];
      json['card_elimination_reward'].forEach((v) {
        cardEliminationReward?.add(CardReward.fromJson(v));
      });
    }
    if (json['cash_card_reward'] != null) {
      cashCardReward = [];
      json['cash_card_reward'].forEach((v) {
        cashCardReward?.add(CardReward.fromJson(v));
      });
    }
    if (json['wheel_reward'] != null) {
      wheelReward = [];
      json['wheel_reward'].forEach((v) {
        wheelReward?.add(CardReward.fromJson(v));
      });
    }
    if (json['card_reward'] != null) {
      cardReward = [];
      json['card_reward'].forEach((v) {
        cardReward?.add(CardReward.fromJson(v));
      });
    }
  }
  List<IntAd>? intAd;
  List<CardReward>? cardEliminationReward;
  List<CardReward>? cashCardReward;
  List<CardReward>? wheelReward;
  List<CardReward>? cardReward;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (intAd != null) {
      map['int_ad'] = intAd?.map((v) => v.toJson()).toList();
    }
    if (cardEliminationReward != null) {
      map['card_elimination_reward'] = cardEliminationReward?.map((v) => v.toJson()).toList();
    }
    if (cashCardReward != null) {
      map['cash_card_reward'] = cashCardReward?.map((v) => v.toJson()).toList();
    }
    if (wheelReward != null) {
      map['wheel_reward'] = wheelReward?.map((v) => v.toJson()).toList();
    }
    if (cardReward != null) {
      map['card_reward'] = cardReward?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CardReward {
  CardReward({
      this.firstNumber, 
      this.reward, 
      this.endNumber,});

  CardReward.fromJson(dynamic json) {
    firstNumber = json['first_number'].toString().toDou();
    reward=[];
    reward?.clear();
    if(json['reward'] != null){
      for (var value in json['reward']) {
        reward?.add(value.toString().toDou());
      }
    }
    endNumber = json['end_number'].toString().toDou();
  }
  double? firstNumber;
  List<double>? reward;
  double? endNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_number'] = firstNumber;
    map['reward'] = reward;
    map['end_number'] = endNumber;
    return map;
  }

}

class IntAd {
  IntAd({
      this.firstNumber, 
      this.point, 
      this.endNumber,});

  IntAd.fromJson(dynamic json) {
    firstNumber = json['first_number'].toString().toDou();
    point = json['point'];
    endNumber = json['end_number'].toString().toDou();
  }
  double? firstNumber;
  int? point;
  double? endNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_number'] = firstNumber;
    map['point'] = point;
    map['end_number'] = endNumber;
    return map;
  }

}