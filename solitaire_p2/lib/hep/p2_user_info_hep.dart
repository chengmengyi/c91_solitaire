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
      return getRouterNameByLevel(nextLevel);
    }else{
      P1EventBean(code: P2EventCode.updateLevel).send();
      return "";
    }
  }

  updateUserCoins(int addNum){
    p2Coins.saveData(p2Coins.getData()+addNum);
    P1EventBean(code: P2EventCode.updateCoins).send();
  }
}