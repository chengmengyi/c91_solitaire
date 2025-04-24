import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/bean/card_bean.dart';
import 'package:solitaire_p3/hep/guide/step1_view.dart';
import 'package:solitaire_p3/hep/guide/step2_view.dart';
import 'package:solitaire_p3/hep/guide/step3_view.dart';
import 'package:solitaire_p3/hep/guide/step4_view.dart';
import 'package:solitaire_p3/hep/guide/step5_view.dart';
import 'package:solitaire_p3/hep/guide/step6_view.dart';
import 'package:solitaire_p3/hep/guide/step7_view.dart';
import 'package:solitaire_p3/hep/guide/step8_view.dart';
import 'package:solitaire_p3/hep/p3_routers_name.dart';
import 'package:solitaire_p3/hep/p3_storage.dart';

class GuideHep{
  static final GuideHep _instance = GuideHep();
  static GuideHep get instance => _instance;

  OverlayEntry? _overlayEntry;

  var _currentNewUserStep=1;

  showGuideStep1({
    required BuildContext context,
    required Function() clickCall,
}){
    if(p3NewUserGuideCompleted.getData()||_currentNewUserStep!=1){
      return;
    }
    showOverlay(
      context: context,
      widget: Step1View(
        clickCall: (){
          _currentNewUserStep=2;
          clickCall.call();
        },
      ),
    );
  }

  showGuideStep2({
    required BuildContext context,
    required GlobalKey globalKey,
  }){
    if(p3NewUserGuideCompleted.getData()||_currentNewUserStep!=2){
      return;
    }
    var renderBox = globalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    showOverlay(
      context: context,
      widget: Step2View(
        offset: offset,
        width: renderBox.size.width,
        clickCall: (){
          _currentNewUserStep=3;
          P1RouterFun.toNextPage(str: P3RoutersName.p3Level10);
        },
      ),
    );
  }

  showGuideStep3(BuildContext context, CardBean cardBean){
    if(p3NewUserGuideCompleted.getData()||_currentNewUserStep!=3){
      return;
    }
    var renderBox = cardBean.globalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    showOverlay(
      context: context,
      widget: Step3View(
        offset: offset,
        cardBean: cardBean,
        clickCall: (){
          _currentNewUserStep=4;
          P1EventBean(code: P3EventCode.newUserStep3ClickCard,anyValue: cardBean).send();
          showGuideStep4(context);
        },
      ),
    );
  }

  showGuideStep4(BuildContext context){
    if(p3NewUserGuideCompleted.getData()||_currentNewUserStep!=4){
      return;
    }
    showOverlay(
      context: context,
      widget: Step4View(
        clickCall: (){
          _currentNewUserStep=5;
          showGuideStep5(context);
        },
      ),
    );
  }

  showGuideStep5(BuildContext context){
    if(p3NewUserGuideCompleted.getData()||_currentNewUserStep!=5){
      return;
    }
    showOverlay(
      context: context,
      widget: Step5View(
        clickCall: (){
          _currentNewUserStep=6;
          P1RouterFun.toNextPage(str: P3RoutersName.p3cash);
        },
      ),
    );
  }

  showGuideStep6({required BuildContext context, required GlobalKey cashTypeGlobalKey,required GlobalKey cashMoneyGlobalKey,required Function() clickCashMoneyCall}){
    if(p3NewUserGuideCompleted.getData()||_currentNewUserStep!=6){
      return;
    }
    var renderBox = cashTypeGlobalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    showOverlay(
      context: context,
      widget: Step6View(
        offset: offset,
        width: renderBox.size.width,
        clickCall: (){
          _currentNewUserStep=7;
          showGuideStep7(context, cashMoneyGlobalKey,clickCashMoneyCall);
        },
      ),
    );
  }

  showGuideStep7(BuildContext context, GlobalKey globalKey, Function() clickCashMoneyCall){
    if(p3NewUserGuideCompleted.getData()||_currentNewUserStep!=7){
      return;
    }
    var renderBox = globalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    showOverlay(
      context: context,
      widget: Step7View(
        offset: offset,
        clickCall: (){
          _currentNewUserStep=8;
          clickCashMoneyCall.call();
        },
      ),
    );
  }

  showGuideStep8({
    required BuildContext context,
    required GlobalKey globalKey,
  }){
    if(p3NewUserGuideCompleted.getData()||_currentNewUserStep!=8){
      return;
    }
    var renderBox = globalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    showOverlay(
      context: context,
      widget: Step8View(
        offset: offset,
        width: renderBox.size.width,
        clickCall: (){
          _currentNewUserStep=9;
          P1RouterFun.toNextPage(str: P3RoutersName.p3Level10);
          p3NewUserGuideCompleted.saveData(true);
        },
      ),
    );
  }

  bool canShowStep3()=>!p3NewUserGuideCompleted.getData()&&_currentNewUserStep==3;

  showOverlay({
    required BuildContext context,
    required Widget widget,
  }){
    _overlayEntry=OverlayEntry(builder: (_)=>widget);
    Overlay.of(context).insert(_overlayEntry!);
  }

  hideOverlay(){
    _overlayEntry?.remove();
    _overlayEntry=null;
  }
}