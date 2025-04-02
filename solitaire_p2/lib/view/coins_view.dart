import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_hep.dart';
import 'package:solitaire_p1/p1_view/p1_image.dart';
import 'package:solitaire_p1/p1_view/p1_text.dart';
import 'package:solitaire_p2/hep/p2_storage.dart';

class CoinsView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CoinsViewState();
}

class _CoinsViewState extends State<CoinsView>{
  var shaking=false;
  late StreamSubscription<P1EventBean>? _streamSubscription;
  late ShakeAnimationController shakeAnimationController;

  @override
  void initState() {
    _streamSubscription=eventBus.on<P1EventBean>().listen((bean) {
      switch(bean.code){
        case P2EventCode.updateCoins:
          setState(() {});
          break;
        case P2EventCode.buyWanNengCardNoMoney:
          shakeAnimationController.start();
          setState(() {
            shaking=true;
          });
          Future.delayed(const Duration(milliseconds: 1200),(){
            setState(() {
              shaking=false;
            });
          });
          break;
      }
    });
    shakeAnimationController=ShakeAnimationController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 118.w,
    height: 32.h,
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        P1Image(name: "coins1",width: 118.w,height: 32.h,),
        Row(
          children: [
            SizedBox(width: 2.w,),
            P1Image(name: "coins2",width: 30.w,height: 30.h,),
            ShakeAnimationWidget(
              shakeAnimationController: shakeAnimationController,
              shakeAnimationType: ShakeAnimationType.LeftRightShake,
              isForward: false,
              shakeCount: 1,
              shakeRange: 0.2,
              child: P1Text(text: "${p2Coins.getData()}", size: 15.sp, color: shaking?"#C13336":"#FFFFFF"),
            ),
          ],
        )
      ],
    ),
  );

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _streamSubscription=null;
    super.dispose();
  }
}