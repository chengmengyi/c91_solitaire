import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p2/hep/p2_storage.dart';

class P2UserInfoHep {
  static final P2UserInfoHep _instance = P2UserInfoHep();
  static P2UserInfoHep get instance => _instance;

  updateLevel(){
    p2CurrentLevel.saveData(p2CurrentLevel.getData()+1);
    P1EventBean(code: P2EventCode.updateLevel).send();
  }

  updateUserCoins(int addNum){
    p2Coins.saveData(p2Coins.getData()+addNum);
    P1EventBean(code: P2EventCode.updateCoins).send();
  }
}