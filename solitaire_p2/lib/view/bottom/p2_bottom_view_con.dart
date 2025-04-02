import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p2/bean/random_card_bean.dart';
import 'package:solitaire_p2/dialog/p2_buy_wan_neng_card_dialog/p2_buy_wan_neng_card_dialog.dart';
import 'package:solitaire_p2/hep/p2_card_hep.dart';
import 'package:solitaire_p2/hep/p2_play.dart';

class P2BottomViewCon extends P1BaseCon{
  P2Play? p2play;

  clickWanNeng(){
    P1RouterFun.showDialog(w: P2BuyWanNengCardDialog());
  }

  clickLongJuanFeng(){
    // _checkOverlays();

  }

  changeHandCard(){
    // currentHandCard = P2CardHep.instance.getRandomCardByListAndProbability(_getNoCoveredCardNumList(), P2ValueHep.instance.getHandsProbability());
    // currentHandsNum--;
    // update(["hand_card_num","hand_card"]);
  }
}