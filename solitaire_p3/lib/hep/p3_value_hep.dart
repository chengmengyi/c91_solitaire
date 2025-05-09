import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:solitaire_p1/p1_hep/firebase_hep.dart';
import 'package:solitaire_p1/p1_hep/local_info.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p3/bean/value_bean.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';

StorageData<String> p3ValueConfig=StorageData<String>(key: "p3ValueConfig", defaultValue: "");

class P3ValueHep{
  static final P3ValueHep _instance = P3ValueHep();
  static P3ValueHep get instance => _instance;

  ValueBean? _valueBean;

  initValue(){
    _initBean();
    print("kkkk===first init value");
    FirebaseHep.instance.valueCallback=(s){
      if(p3ValueConfig.getData().isEmpty){
        print("kkkk===second init value");
        p3ValueConfig.saveData(s);
        _initBean();
      }
    };
  }

  _initBean(){
    try{
      var s = p3ValueConfig.getData();
      if(s.isEmpty){
        _valueBean=ValueBean.fromJson(jsonDecode(valueStr.base64()));
        return;
      }
      _valueBean=ValueBean.fromJson(jsonDecode(s));
    }catch(e){
      _valueBean=ValueBean.fromJson(jsonDecode(valueStr.base64()));
    }
  }

  test(){
    print("kk===${_generateRandomNumber(0.01,0.06)}");
  }

  bool showIntAd(AdType adType){
    // if(kDebugMode){
    //   return false;
    // }
    if(adType==AdType.reward){
      return true;
    }
    var list = _valueBean?.intAd??[];
    if(list.isEmpty){
      return false;
    }
    var userCoins = p3Coins.getData();
    var last = list.last;
    if(userCoins>=(last.endNumber??200)){
      return Random().nextInt(100)<(last.point??5);
    }
    for (var value in list) {
      if(userCoins>=(value.firstNumber??0)&&userCoins<(value.endNumber??0)){
        return Random().nextInt(100)<(value.point??5);
      }
    }
    return false;
  }

  double getCardAddNum()=> _randomAddNum(_valueBean?.cardEliminationReward??[]);

  double getLuckyCardAddNum()=> _randomAddNum(_valueBean?.cardReward??[]);

  double getWheelAddNum()=>_randomAddNum(_valueBean?.wheelReward??[]);

  double getMoneyCardAddNum()=>_randomAddNum(_valueBean?.cashCardReward??[]);

  bool checkWheelShowBox(){
    var list = _valueBean?.wheelReward??[];
    if(list.isEmpty){
      return false;
    }
    var d = list.first.endNumber??130;
    return p3Coins.getData()>=d;
  }

  List<int> getCashAmountList()=>[200,400];

  double _randomAddNum(List<CardReward> list){
    if(list.isEmpty){
      return 0.0001;
    }
    var last = list.last;
    var userCoins = p3Coins.getData();
    if(userCoins>=(last.endNumber??200)){
      var reward = last.reward??[];
      if(reward.isEmpty){
        return 0.0001;
      }
      if(reward.length==1){
        return reward.first;
      }
      return _generateRandomNumber(reward.first,reward.last);
    }
    for (var value in list) {
      if(userCoins>=(value.firstNumber??0)&&userCoins<(value.endNumber??0)){
        var reward = value.reward??[];
        if(reward.isEmpty){
          return 0.0001;
        }
        if(reward.length==1){
          return reward.first;
        }
        return _generateRandomNumber(reward.first,reward.last);
      }
    }
    return 0.0001;
  }

  //获取顶层概率
  double getTopProbability(){
    var level = p3CurrentLevel.getData()%20;
    double p=0.0;
    if(level<=10){
      p=0.7;
    }else if(level<=20){
      p=0.65;
    }else if(level<=30){
      p=0.55;
    }else if(level<=40){
      p=0.4;
    }else if(level<=50){
      p=0.3;
    }
    return p;
  }

  //获取手牌概率
  double getHandsProbability(){
    var level = p3CurrentLevel.getData()%20;
    double p=0.0;
    if(level<=10){
      p=0.7;
    }else if(level<=20){
      p=0.6;
    }else if(level<=30){
      p=0.5;
    }else if(level<=40){
      p=0.4;
    }else if(level<=50){
      p=0.3;
    }
    return p;
  }

  //获取底层概率
  double getBottomProbability(){
    var level = p3CurrentLevel.getData()%20;
    double p=0.0;
    if(level<=10){
      p=0.65;
    }else if(level<=20){
      p=0.6;
    }else if(level<=30){
      p=0.5;
    }else if(level<=40){
      p=0.4;
    }else if(level<=50){
      p=0.4;
    }
    return p;
  }

  int _countDecimalPlaces(double number) {
    String numStr = number.toString();
    int dotIndex = numStr.indexOf('.');
    if (dotIndex == -1) {
      return 0;
    }
    return numStr.length - dotIndex - 1;
  }

  double _generateRandomNumber(double min, double max) {
    int decimalPlaces = _countDecimalPlaces(min) > _countDecimalPlaces(max)
        ? _countDecimalPlaces(min)
        : _countDecimalPlaces(max);
    int newDecimalPlaces = decimalPlaces + 1;
    double multiplier = pow(10, newDecimalPlaces).toDouble();
    int minInt = (min * multiplier).toInt();
    int maxInt = (max * multiplier).toInt();
    Random random = Random();
    int randomInt = minInt + random.nextInt(maxInt - minInt + 1);
    return randomInt / multiplier;
  }
}