import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solitaire_p1/p1_hep/p1_event.dart';
import 'package:solitaire_p1/p1_view/p1_lottie_view.dart';

class CoinsLottieView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CoinsLottieViewState();
}

class _CoinsLottieViewState extends State<CoinsLottieView> with TickerProviderStateMixin{
  var showCoinsLottie=false;
  late AnimationController coinLottieController;
  late StreamSubscription<P1EventBean>? _streamSubscription;

  @override
  void initState() {
    _streamSubscription=eventBus.on<P1EventBean>().listen((bean) {
      switch(bean.code){
        case P3EventCode.showCoinsLottie:
          coinLottieController..reset()..forward();
          setState(() {
            showCoinsLottie=true;
          });
          break;
      }
    });
    coinLottieController=AnimationController(vsync: this,duration: const Duration(milliseconds: 400))..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        setState(() {
          showCoinsLottie=false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Visibility(
    visible: showCoinsLottie,
    child: P1LottieView(
      name: "coins",
      repeat: false,
      controller: coinLottieController,
    ),
  );
  @override
  void dispose() {
    coinLottieController.dispose();
    _streamSubscription?.cancel();
    _streamSubscription=null;
    super.dispose();
  }
}