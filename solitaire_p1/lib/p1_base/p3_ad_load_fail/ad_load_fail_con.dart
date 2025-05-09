import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';

class AdLoadFailCon extends P1BaseCon{
  String popScene="other";
  @override
  void onInit() {
    super.onInit();
    PointHep.instance.point(pointEvent: PointEvent.claim_fail_pop,params: {"pop_scene":popScene});
  }

  clickTry(Function() tryAgain){
    PointHep.instance.point(pointEvent: PointEvent.claim_fail_pop_try,params: {"pop_scene":popScene});
    P1RouterFun.closePage();
    tryAgain.call();
  }

  clickClose(){
    PointHep.instance.point(pointEvent: PointEvent.claim_fail_pop_close,params: {"pop_scene":popScene});
    P1RouterFun.closePage();
  }
}