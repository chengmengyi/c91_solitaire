import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';

class P3CashTask2Con extends P1BaseCon{
  @override
  void onInit() {
    super.onInit();
    PointHep.instance.point(pointEvent: PointEvent.withdraw_task_pop,params: {"withdraw_step":"step2"});
  }

  click(Function() clickNow){
    PointHep.instance.point(pointEvent: PointEvent.withdraw_task_pop_complete,params: {"withdraw_step":"step2"});
    P1RouterFun.closePage();
    clickNow.call();
  }
}