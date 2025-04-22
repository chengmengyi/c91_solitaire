import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/hep/p3_user_info_hep.dart';
import 'package:solitaire_p3/hep/p3_value_hep.dart';

class P3WheelCon extends P1BaseCon{
  var wheelAddNum=P3ValueHep.instance.getLuckyCardAddNum();
  List<double> coinsList=[];

  @override
  void onInit() {
    super.onInit();
    _initCoinsList();
  }

  _initCoinsList(){
    coinsList.clear();
    coinsList.add(200);
    coinsList.add(wheelAddNum);
    
  }

  clickClose(){
    P3UserInfoHep.instance.updateTopPro(-5);
    P1RouterFun.closePage();
  }
}