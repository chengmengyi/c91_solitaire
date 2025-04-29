import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/dialog/p3_lucky_card/p3_lucky_card_dialog.dart';
import 'package:solitaire_p3/hep/p3_routers_name.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';

class P3UserInfoHep {
  static final P3UserInfoHep _instance = P3UserInfoHep();
  static P3UserInfoHep get instance => _instance;

  String updateLevel(){
    var currentLevel = p3CurrentLevel.getData();
    int nextLevel = currentLevel + 1;
    int currentStage = (currentLevel - 1) ~/ 10;
    int nextStage = (nextLevel - 1) ~/ 10;
    p3CurrentLevel.saveData(nextLevel);
    var isNextLevel=currentStage != nextStage;
    if(isNextLevel){
      return _getRouterNameByLevel(nextLevel);
    }else{
      P1EventBean(code: P3EventCode.updateLevel).send();
      return "";
    }

    // p2CurrentLevel.saveData(20);
    // P1EventBean(code: P3EventCode.updateLevel).send();
    // return "";
  }

  String _getRouterNameByLevel(int nextLevel){
    var i = nextLevel%20;
    if(i<=10){
      return P3RoutersName.p3Level10;
    }else if(i<=20){
      return P3RoutersName.p3Level20;
    }
    return "";
  }

  updateUserCoins(double addNum){
    var d = (Decimal.parse("${p3Coins.getData()}")+Decimal.parse("$addNum")).toDouble();
    p3Coins.saveData(d);
    var moneyLevel = p3LastMoneyLevel.getData()+100;
    if(p3Coins.getData()>=moneyLevel){
      PointHep.instance.point(pointEvent: PointEvent.cash_dall,params: {"money_from":moneyLevel});
      p3LastMoneyLevel.saveData(moneyLevel);
    }
    P1EventBean(code: P3EventCode.updateCoins).send();
    if(addNum>0){
      P1EventBean(code: P3EventCode.showCoinsLottie).send();
    }
  }

  updatePlayCardNum(){
    p3PlayCardNum.saveData(p3PlayCardNum.getData()+1);
    if(p3PlayCardNum.getData()>=4&&!p3ShowedLongJuanFengGuide.getData()){
      P1EventBean(code: P3EventCode.showLongjuanfengGuide).send();
    }
  }

  updateTopPro(int addNum){
    p3TopPro.saveData(p3TopPro.getData()+addNum);
    P1EventBean(code: P3EventCode.updateTopPro).send();

    if(p3TopPro.getData()>=5){
      var isLucky = p3LastIsLuckyCard.getData();
      if(isLucky){
        P1RouterFun.showDialog(w: P3LuckyCardDialog());
      }else{

      }
      p3LastIsLuckyCard.saveData(!isLucky);
    }
  }
}