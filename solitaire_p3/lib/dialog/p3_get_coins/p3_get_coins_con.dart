import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';

class P3GetCoinsCon extends P1BaseCon{

  clickDou(double addNum){
    P1RouterFun.closePage();
    P3UserInfoHep.instance.updateUserCoins(addNum*2);
  }

  clickSingle(double addNum){
    P1RouterFun.closePage();
    P3UserInfoHep.instance.updateUserCoins(addNum);
  }
}