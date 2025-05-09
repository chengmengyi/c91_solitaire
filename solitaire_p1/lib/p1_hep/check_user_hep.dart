import 'dart:io';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:solitaire_p1/p1_hep/check_user/flutter_check_af.dart';
import 'package:solitaire_p1/p1_hep/check_user/request_af/request_af_callback.dart';
import 'package:solitaire_p1/p1_hep/check_user/request_cloak/request_cloak_callback.dart';
import 'package:solitaire_p1/p1_hep/local_info.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';

class CheckUserHep{
  static final CheckUserHep _instance = CheckUserHep();
  static CheckUserHep get instance => _instance;

  bool aPackageShowing=false;

  init()async{
    var distinctId = await FlutterTbaInfo.instance.getDistinctId();
    var cloakData={
      "forth": await FlutterTbaInfo.instance.getBundleId(),
      "jam": Platform.isAndroid?"prospect":"offprint",
      "aquatic": await FlutterTbaInfo.instance.getAppVersion(),
      "affair": distinctId,
      "gustav": DateTime.now().millisecondsSinceEpoch,
      "algal": await FlutterTbaInfo.instance.getDeviceModel(),
      "shape": await FlutterTbaInfo.instance.getOsVersion(),
      "eve": await FlutterTbaInfo.instance.getIdfv(),
      "jury": await FlutterTbaInfo.instance.getGaid(),
      "we": await FlutterTbaInfo.instance.getAndroidId(),
      "astoria": await FlutterTbaInfo.instance.getIdfa(),
    };
    FlutterCheckAf.instance.init(
      afKey: afKey,
      afAppId: afAppid,
      distinctId: distinctId,
      clockUrl: cloakUrl,
      cloakWhiteKey: "cyrus",
      cloakData: cloakData,
      requestAfCallback: RequestAfCallback(
        startRequestAf: (){},
        requestSuccess: (bool isB){
          _checkUserDelay();
        },
        firstRequestAfB: (){},
        startAfSuccess: (){},
        startAfFail: (int code,String msg){},
      ),
      requestCloakCallback: RequestCloakCallback(
        startRequestCloak: (){},
        requestSuccess: (bool isWhite){
          _checkUserDelay();
        },
      ),
    );
  }

  bool checkUser()=>FlutterCheckAf.instance.checkUser();

  _checkUserDelay(){
    if(aPackageShowing&&checkUser()){
      aPackageShowing=false;
      P1RouterFun.toNextPageAndCloseCurrent(str: "/p3/home");
    }
  }
}