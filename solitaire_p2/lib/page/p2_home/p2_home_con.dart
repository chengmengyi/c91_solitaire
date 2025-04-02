import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p2/hep/p2_routers_name.dart';
import 'package:solitaire_p2/hep/p2_storage.dart';
import 'package:solitaire_p2/hep/p2_user_info_hep.dart';

class P2HomeCon extends P1BaseCon{
  var currentLevel=p2CurrentLevel.getData();

  clickPlay(){
    P1RouterFun.toNextPage(str: P2RoutersName.p2Level10);
  }

  @override
  bool registerP1Event() => true;

  @override
  onListenP1Event(P1EventBean bean) {
    switch(bean.code){
      case P2EventCode.updateLevel:
        currentLevel=p2CurrentLevel.getData();
        update(["level"]);
        break;
    }
  }
}