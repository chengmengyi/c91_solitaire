import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_hep/p1_mp3_hep.dart';
import 'package:solitaire_p1/p1_view/p1_lottie_view.dart';
import 'package:solitaire_p3/bean/card_bean.dart';

class LongJuanFengLottieView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LongJuanFengLottieViewState();
}

class _LongJuanFengLottieViewState extends State<LongJuanFengLottieView> with TickerProviderStateMixin{
  var showLottie=false;
  List<CardBean> list=[];
  late AnimationController lottieController;
  late StreamSubscription<P1EventBean>? _streamSubscription;

  @override
  void initState() {
    _streamSubscription=eventBus.on<P1EventBean>().listen((bean) {
      switch(bean.code){
        case P2EventCode.showLongJuanFengLottie:
          list.clear();
          if(bean.anyValue is List<CardBean>){
            list.addAll(bean.anyValue as List<CardBean>);
          }
          P1Mp3Hep.instance.playFeng();
          lottieController..reset()..forward();
          setState(() {
            showLottie=true;
          });
          break;
      }
    });
    lottieController=AnimationController(vsync: this,duration: const Duration(milliseconds: 800))..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        setState(() {
          showLottie=false;
        });
        P1EventBean(code: P2EventCode.longJuanFengLottieEnd,anyValue: list).send();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Center(
    child: Visibility(
      visible: showLottie,
      child: P1LottieView(
        name: "longjuanfeng",
        repeat: false,
        controller: lottieController,
      ),
    ),
  );
  @override
  void dispose() {
    lottieController.dispose();
    _streamSubscription?.cancel();
    _streamSubscription=null;
    super.dispose();
  }
}