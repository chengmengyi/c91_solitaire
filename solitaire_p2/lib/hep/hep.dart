import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p2/bean/card_bean.dart';
import 'package:solitaire_p2/hep/p2_routers_name.dart';

String getCardImageIcon(CardBean bean){
  if(bean.covered){
    return "card_back";
  }else{
    var cardNum=0;
    switch(bean.cardNum){
      case "A":
        cardNum=1;
        break;
      case "J":
        cardNum=11;
        break;
      case "Q":
        cardNum=12;
        break;
      case "K":
        cardNum=13;
        break;
      default:
        cardNum=bean.cardNum.toInt();
        break;
    }
    return "${bean.cardType.name}$cardNum";
  }
}

String getRouterNameByLevel(int nextLevel){
  var i = nextLevel%20;
  if(i<=10){
    return P2RoutersName.p2Level10;
  }else if(i<=20){
    return P2RoutersName.p2Level20;
  }
  return "";
}