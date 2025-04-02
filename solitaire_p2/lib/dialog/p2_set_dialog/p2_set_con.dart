import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p2/hep/p2_routers_name.dart';

class P2SetCon extends P1BaseCon{
  clickClose(){
    P1RouterFun.closePage();
  }

  clickHome(){
    P1RouterFun.toHome(str: P2RoutersName.p2Home);
  }

  showPrivacy(){

  }
}