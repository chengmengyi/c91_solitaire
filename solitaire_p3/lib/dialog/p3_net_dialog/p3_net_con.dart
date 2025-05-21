import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/point/point_event.dart';
import 'package:solitaire_p1/p1_hep/point/point_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/dialog/p3_get_coins/p3_get_coins_dialog.dart';

class P3NetCon extends P1BaseCon{
  GetCoinsEnum getCoinsEnum=GetCoinsEnum.other;

  @override
  void onInit() {
    super.onInit();
    PointHep.instance.point(pointEvent: PointEvent.claim_nointernet_pop,params: {"pop_scene":getCoinsEnum.name});
  }

  clickGot(Function()? dismiss){
    PointHep.instance.point(pointEvent: PointEvent.claim_nointernet_pop_got,params: {"pop_scene":getCoinsEnum.name});
    P1RouterFun.closePage();
    dismiss?.call();
  }

  clickClose(Function()? dismiss){
    PointHep.instance.point(pointEvent: PointEvent.claim_nointernet_pop_close,params: {"pop_scene":getCoinsEnum.name});
    P1RouterFun.closePage();
    dismiss?.call();
  }
}