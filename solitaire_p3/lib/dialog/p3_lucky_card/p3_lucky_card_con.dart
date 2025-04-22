import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/dialog/p3_get_coins/p3_get_coins_dialog.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';

class P3LuckyCardCon extends P1BaseCon{
  var addNum=P3ValueHep.instance.getLuckyCardAddNum();

  clickClose(){
    P3UserInfoHep.instance.updateTopPro(-5);
    P1RouterFun.closePage();
  }

  clickCard(){
    Future.delayed(const Duration(milliseconds: 2500),(){
      P3UserInfoHep.instance.updateTopPro(-5);
      P1RouterFun.closePage();
      P1RouterFun.showDialog(w: P3GetCoinsDialog(addNum: addNum,));
    });
  }
}