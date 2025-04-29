import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';

class AdLoadFailCon extends P1BaseCon{
  @override
  void onInit() {
    super.onInit();
    PointHep.instance.point(pointEvent: PointEvent.claim_fail_pop);
  }

  clickTry(Function() tryAgain){
    PointHep.instance.point(pointEvent: PointEvent.claim_fail_pop_try);
    P1RouterFun.closePage();
    tryAgain.call();
  }

  clickClose(){
    PointHep.instance.point(pointEvent: PointEvent.claim_fail_pop_close);
    P1RouterFun.closePage();
  }
}