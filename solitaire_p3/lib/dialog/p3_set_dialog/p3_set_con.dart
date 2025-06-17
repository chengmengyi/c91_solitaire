import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/local_info.dart';
import 'package:solitaire_p1/p1_hep/p1_mp3_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/hep/p3_routers_name.dart';

class P3SetCon extends P1BaseCon{
  clickClose(){
    P1RouterFun.closePage();
  }

  clickHome(){
    P1RouterFun.toHome(str: P3RoutersName.p3Home);
  }

  showPrivacy(){
    P1RouterFun.toNextPage(str: P3RoutersName.p3web,p: {"url":privacyStr,"title":"Privacy Policy"});
  }

  clickMusic(){
    P1Mp3Hep.instance.setPlayOrStopBg();
    update(["music"]);
  }

  clickSound(){
    P1Mp3Hep.instance.setPlaySound();
    update(["sound"]);
  }
}