import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_routers/p1_routers_fun.dart';
import 'package:solitaire_p3/hep/guide/step1_view.dart';
import 'package:solitaire_p3/hep/guide/step2_view.dart';
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
    // if(p3NewUserGuideCompleted.getData()||_currentNewUserStep!=1){
    //   return;
    // }
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
    // if(p3NewUserGuideCompleted.getData()||_currentNewUserStep!=2){
    //   return;
    // }
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

  showGuideStep3(){
    // if(p3NewUserGuideCompleted.getData()||_currentNewUserStep!=2){
    //   return;
    // }
    
  }

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