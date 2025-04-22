import 'package:solitaire_p3/hep/p3_storage.dart';

class P3ValueHep{
  static final P3ValueHep _instance = P3ValueHep();
  static P3ValueHep get instance => _instance;

  double getLuckyCardAddNum()=> 20.03;

  double getWheelAddNum()=> 30.03;

  List<int> getCashAmountList()=>[200,400];

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
}