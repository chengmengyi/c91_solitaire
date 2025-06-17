import 'package:solitaire_p1/p1_base/p1_base_con.dart';
import 'package:solitaire_p1/p1_hep/local_info.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';

class P3WebCon extends P1BaseCon{
  late WebViewController controller;

  @override
  void onInit() {
    super.onInit();
    controller=WebViewController();
  }

  @override
  void onReady() {
    super.onReady();
    // controller.loadRequest(Uri.parse(privacyStr));
    controller.loadRequest(Uri.parse(P1RouterFun.getArguments()["url"]));
  }
}