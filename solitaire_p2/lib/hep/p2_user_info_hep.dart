import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p2/hep/hep.dart';
import 'package:solitaire_p2/hep/p2_routers_name.dart';
import 'package:solitaire_p2/hep/p2_storage.dart';

class P2UserInfoHep {
  static final P2UserInfoHep _instance = P2UserInfoHep();
  static P2UserInfoHep get instance => _instance;

  String updateLevel(){
    var currentLevel = p2CurrentLevel.getData();
    int nextLevel = currentLevel + 1;
    int currentStage = (currentLevel - 1) ~/ 10;
    int nextStage = (nextLevel - 1) ~/ 10;
    p2CurrentLevel.saveData(nextLevel);
    var isNextLevel=currentStage != nextStage;
    if(isNextLevel){
      return _getRouterNameByLevel(nextLevel);
    }else{
      P1EventBean(code: P2EventCode.updateLevel).send();
      return "";
    }

    // p2CurrentLevel.saveData(20);
    // P1EventBean(code: P2EventCode.updateLevel).send();
    // return "";
  }

  String _getRouterNameByLevel(int nextLevel){
    var i = nextLevel%20;
    if(i<=10){
      return P2RoutersName.p2Level10;
    }else if(i<=20){
      return P2RoutersName.p2Level20;
    }
    return "";
  }

  updateUserCoins(int addNum){
    p2Coins.saveData(p2Coins.getData()+addNum);
    P1EventBean(code: P2EventCode.updateCoins).send();
  }
}