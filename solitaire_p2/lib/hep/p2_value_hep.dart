import 'dart:math';

import 'package:solitaire_p2/hep/p2_storage.dart';

class P2ValueHep{
  static final P2ValueHep _instance = P2ValueHep();
  static P2ValueHep get instance => _instance;

  //获取顶层概率
  double getTopProbability(){
    var level = p2CurrentLevel.getData()%20;
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
    print("kk=====顶层概率===$p");
    return p;
  }

  //获取手牌概率
  double getHandsProbability(){
    var level = p2CurrentLevel.getData()%20;
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
    print("kk=====手牌概率===$p");
    return p;
  }

  //获取底层概率
  double getBottomProbability(){
    var level = p2CurrentLevel.getData()%20;
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
    print("kk=====底层概率===$p");
    return p;
  }
}